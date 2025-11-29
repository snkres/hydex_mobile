import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'upcoming_event.mapper.dart';

@MappableClass()
class UpcomingEvent with UpcomingEventMappable {
  final String id;
  final String name;
  final DateTime date;
  final String time;
  final Location location;
  final UpcomingEventStatus status;
  final int numberOfGuests;

  UpcomingEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.numberOfGuests,
  });
}

@MappableEnum()
enum UpcomingEventStatus {
  @MappableValue('Pending')
  pending,

  @MappableValue('Confirmed')
  confirmed,

  @MappableValue('Invitation')
  invitation,

  @MappableValue('Cancelled')
  cancelled,
}
