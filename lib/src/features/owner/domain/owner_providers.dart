import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/owner/models/owner_event.dart';
import 'package:hydex/src/features/owner/models/vendor_booking_response.dart';
import 'package:hydex/src/features/owner/models/vendor_sales.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_providers.g.dart';

@riverpod
Future<List<OwnerEvent>> getOwnerEvents(Ref ref, {bool active = false}) async {
  try {
    final query = active ? "?status=active" : "";
    final response = await DioHelper.get("/owner/events$query");
    final items = response.data['data']['items'] as List<dynamic>;
    return items
        .map((e) => OwnerEventMapper.fromMap(e as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}

@riverpod
Future<OwnerEvent> getOwnerEventDetails(
  Ref ref, {
  required String eventID,
}) async {
  try {
    final response = await DioHelper.get("/owner/events/$eventID");
    final data = response.data['data'];
    return OwnerEventMapper.fromMap(data);
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}

@riverpod
Future<void> getOwnerEventBookings(Ref ref, {required String eventID}) async {
  try {
    final response = await DioHelper.get("/owner/events/$eventID/bookings");
    final data = response.data['data'];
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}

@riverpod
Future<List<VendorBookingItem>> getOwnerVendorBookings(
  Ref ref, {
  required String vendorId,
}) async {
  try {
    final response = await DioHelper.get("/owner/vendors/$vendorId/bookings");
    final items = response.data['data']['items'] as List<dynamic>;
    return items
        .map((e) => VendorBookingItemMapper.fromMap(e as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}

@riverpod
Future<int> getVendorReservations(Ref ref, {required String vendorId}) async {
  try {
    final response = await DioHelper.get(
      "/owner/vendors/$vendorId/bookings/stats",
    );
    final data = response.data['data'];
    return data["upcomingReservationsCount"];
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}

@riverpod
Future<VendorSales> getVendorSales(Ref ref, {required String vendorId}) async {
  try {
    final response = await DioHelper.get(
      "/owner/vendors/$vendorId/sales/stats",
    );
    final data = response.data['data'];
    return VendorSalesMapper.fromMap(data);
  } catch (e) {
    throw Exception('Failed to load owner events: $e');
  }
}
