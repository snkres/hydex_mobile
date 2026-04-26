import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/owner/models/vendor_booking_response.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
part 'event_booking_response.mapper.dart';

@MappableClass()
class EventBookingItem with EventBookingItemMappable {
  final String id;
  final String displayCode;
  final String fullName;
  final DateTime bookingDate;
  final int? guestNumber;
  final int? numberOfGuests;
  final String passName;
  @MappableField(key: 'uiStatus', hook: RsvStatusHook())
  final RsvStatus status;

  EventBookingItem({
    required this.id,
    required this.displayCode,
    required this.fullName,
    required this.bookingDate,
    required this.guestNumber,
    required this.numberOfGuests,
    required this.passName,
    required this.status,
  });
}
