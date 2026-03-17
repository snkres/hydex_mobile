import 'package:dart_mappable/dart_mappable.dart';

part 'category.mapper.dart';

@MappableClass()
class EventCategory with EventCategoryMappable {
  final String? id;
  final String name;
  final String description;
  final String? image;
  final List<SubCategories>? subCategories;

  EventCategory({
    this.id,
    required this.description,
    this.image,
    required this.name,
    this.subCategories = const [],
  });
}

@MappableClass()
class VendorCategory with VendorCategoryMappable {
  final String name;
  final String? image;

  VendorCategory({required this.name, this.image});
}

@MappableClass()
class SubCategories with SubCategoriesMappable {
  final String id;
  final String? title, description, imageUrl;

  SubCategories({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
  });
}
