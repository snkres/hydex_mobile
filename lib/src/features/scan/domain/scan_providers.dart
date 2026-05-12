import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hydex/core/network/connection.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/scan/data/bulk_request.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:hydex/src/features/scan/data/scan_response.dart';
import 'package:hydex/src/features/scan/domain/offline_sync.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_providers.g.dart';

@riverpod
Future<PermissionStatus> cameraPermissionStatus(Ref ref) async {
  return Permission.camera.status;
}

@riverpod
Future<ScanResponse> getScanDetails(Ref ref, {required String id}) async {
  final response = await DioHelper.get("/owner/bookings/$id");

  final data = response.data["data"];

  return ScanResponseMapper.fromMap(data);
}

@riverpod
Future<void> updateBookingStatus(
  Ref ref, {
  required RsvStatus status,
  required String id,
  String? rejectionReason,
}) async {
  try {
    await DioHelper.patch(
      "/owner/bookings/$id/status",
      data: {
        "status": status.value,
        if (rejectionReason != null) "rejectionReason": rejectionReason,
      },
    );

  } on NetworkException {
    await OfflineSyncDB.savePendingRequest(
      BulkRequest(
        bookingID: id,
        status: status.name.toUpperCase(),
        rejectionReason: rejectionReason,
      ),
    );
    if (kDebugMode) {
      print('📴 Offline — saved booking $id for later sync');
    }
  }
}

@riverpod
Future<void> bulkUpdateBookingStatus(
  Ref ref, {
  required List<BulkRequest> items,
}) async {
  final response = await DioHelper.post(
    "/owner/bookings/status/bulk",
    data: {"items": items.map((e) => e.toJson()).toList()},
  );

  print(response.data);
}

@Riverpod(keepAlive: true)
Future<void> offlineSyncListener(Ref ref) async {
  ref.listen(connectivityStatusProvider, (prev, next) {
    final status = next.value;
    if (status == InternetStatus.connected) {
      _syncPendingRequests(ref);
    }
  });
}

Future<void> _syncPendingRequests(Ref ref) async {
  final pending = await OfflineSyncDB.getPendingRequests();
  if (pending.isEmpty) return;

  if (kDebugMode) {
    print('🔄 Syncing ${pending.length} pending requests...');
  }

  try {
    await ref.read(bulkUpdateBookingStatusProvider(items: pending).future);
    await OfflineSyncDB.clearPendingRequests();
    if (kDebugMode) {
      print('✅ Offline sync complete');
    }
  } catch (e) {
    if (kDebugMode) {
      print('❌ Offline sync failed, will retry on next reconnect: $e');
    }
  }
}
