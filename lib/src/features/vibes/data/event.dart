import 'package:dart_mappable/dart_mappable.dart';

part 'event.mapper.dart';

@MappableEnum()
enum EventType {
  @MappableValue('FEATURED')
  featured,
  @MappableValue('PROMOTIONAL')
  promotional,
}

@MappableClass()
class Event with EventMappable {
  final String id;
  final EventType type;
  final String headline;
  final String subtitle;
  String? image;
  String? video;
  final DateTime campaignStartDate;
  final DateTime campaignEndDate;

  Event({
    required this.id,
    required this.type,
    required this.headline,
    required this.subtitle,
    this.image,
    this.video,
    required this.campaignStartDate,
    required this.campaignEndDate,
  });
}
