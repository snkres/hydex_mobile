import 'package:dart_mappable/dart_mappable.dart';

part 'category.mapper.dart';

class ExperienceCategory {
  final String heading;
  final String description;
  final String imagePath;
  final String?
  actionText; // Optional action text like "Own the", "Discover", etc.

  ExperienceCategory({
    required this.heading,
    required this.description,
    required this.imagePath,
    this.actionText,
  });
}

@MappableClass()
class EventCategory with EventCategoryMappable {
  final String id;
  final String name;
  final String description;
  final String? image;

  EventCategory({
    required this.id,
    required this.description,
    this.image,
    required this.name,
  });
}
