import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
part 'vendor_booking_response.mapper.dart';

@MappableClass()
class VendorBookingResponse with VendorBookingResponseMappable {
  final List<VendorBookingItem> items;

  VendorBookingResponse({required this.items});
}

@MappableClass()
class VendorBookingItem with VendorBookingItemMappable {
  final String id;
  final String displayCode;
  final String fullName;
  final DateTime bookingDate;
  @MappableField(key: 'uiStatus', hook: RsvStatusHook())
  final RsvStatus uiStatus;

  VendorBookingItem({
    required this.id,
    required this.displayCode,
    required this.fullName,
    required this.bookingDate,
    required this.uiStatus,
  });
}

class RsvStatusHook extends MappingHook {
  const RsvStatusHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return RsvStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
        orElse: () => RsvStatus.pending,
      );
    }
    return value;
  }
}
