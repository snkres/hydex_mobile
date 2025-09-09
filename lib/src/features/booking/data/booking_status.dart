import 'package:dart_mappable/dart_mappable.dart';

part 'booking_status.mapper.dart';

// Role enum
@MappableEnum()
enum BookingStatus {
  @MappableValue('PENDING')
  pending,
  @MappableValue('CONFIRMED')
  confirmed,
  @MappableValue('CANCELLED')
  cancelled,
  @MappableValue('COMPLETED')
  completed,
}
