
import 'package:dart_mappable/dart_mappable.dart';

part 'event.mapper.dart';


@MappableClass()
class Event with EventMappable {
  final String? id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String imageUrl;


  Event({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.imageUrl,
  });
}