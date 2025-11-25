import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'vendor.mapper.dart';

@MappableClass()
class Vendor with VendorMappable {
  final String id;
  final String ownerId;
  final String? logo;
  final String name;
  final String headline;
  final String website;
  final String description;
  final Location location;

  final String priceType;
  final Map<String, OperatingHours> operatingHours;
  final List<String> experiences;
  final List<String> media;

  final List<String> gallery;
  final List<Detail> details;
  final String? detailsDescription;

  final List<String> tags;
  final List<String> thingsToKnow;

  Vendor({
    required this.id,
    required this.ownerId,
    this.logo,
    required this.name,
    required this.headline,
    required this.website,
    required this.description,
    required this.location,
    required this.priceType,
    required this.operatingHours,
    required this.experiences,
    required this.media,
    required this.gallery,
    required this.details,
    this.detailsDescription,
    required this.tags,
    required this.thingsToKnow,
  });
}
