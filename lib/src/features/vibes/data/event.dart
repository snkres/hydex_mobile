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
  final String image;
  final String video;
  final DateTime campaignStartDate;
  final DateTime campaignEndDate;
  final String categoryId;

  Event({
    required this.id,
    required this.type,
    required this.headline,
    required this.subtitle,
    required this.image,
    required this.video,
    required this.campaignStartDate,
    required this.campaignEndDate,
    required this.categoryId,
  });
}
