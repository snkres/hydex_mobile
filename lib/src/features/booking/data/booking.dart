import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/booking/data/booking_status.dart';
import 'package:hydex/src/features/vibes/data/event.dart';

part 'booking.mapper.dart';

@MappableClass()
class Booking with BookingMappable {
  final String? id;
  final String eventId;
  final DateTime bookingDate;
  final BookingStatus status;
  final String? notes;
  final double? fees;
  final bool top;
  final Banner event;
  final int numberOfGuests;

  Booking({
    this.id,
    this.fees,
    this.top = false,
    required this.eventId,
    required this.bookingDate,
    required this.status,
    this.notes,
    required this.event,
    required this.numberOfGuests,
  });
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
