import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/booking/data/booking_status.dart';

part 'booking.mapper.dart';

@MappableClass()
class Booking with BookingMappable {
  final String? id;
  final String eventId;
  final DateTime bookingDate;
  final BookingStatus status;
  final String? notes;

  Booking({
    this.id,
    required this.eventId,
    required this.bookingDate,
    required this.status,
    this.notes,
  });
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
