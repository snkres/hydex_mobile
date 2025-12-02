import 'package:dart_mappable/dart_mappable.dart';

part 'category.mapper.dart';

@MappableClass()
class EventCategory with EventCategoryMappable {
  final String? id;
  final String name;
  final String description;
  final String? image;

  EventCategory({
    this.id,
    required this.description,
    this.image,
    required this.name,
  });
}

@MappableClass()
class VendorCategory with VendorCategoryMappable {
  final String name;
  final String? image;

  VendorCategory({required this.name, this.image});
}
