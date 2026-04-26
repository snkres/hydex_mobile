import 'package:dart_mappable/dart_mappable.dart';

part 'event_status.mapper.dart';

@MappableEnum()
enum EventStatus {
  @MappableValue('active')
  active,
  @MappableValue('pending')
  pending,
  @MappableValue('rejected')
  rejected,
  @MappableValue('past')
  past,
  @MappableValue('cancelled')
  cancelled,
}
