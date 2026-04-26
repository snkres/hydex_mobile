import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/owner/models/scan_type.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/features/scan/ui/rsv_output.dart';
import 'package:hydex/src/features/scan/ui/scan_output.dart';

class ScanTicket extends ConsumerWidget {
  const ScanTicket({super.key, required this.type, required this.bookingId});
  final ScanType type;
  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(getScanDetailsProvider(id: bookingId));

    return details.when(
      data: (data) => type == .booking
          ? ScanOutput(data: data, isTicket: true)
          : RsvOutput(data: data, isTicket: true),
      error: (e, s) {
        log("Error", error: e, stackTrace: s);
        return Scaffold(body: Center(child: Text("Error")));
      },
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
