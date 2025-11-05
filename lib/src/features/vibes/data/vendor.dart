
import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'vendor.mapper.dart';


@MappableClass()
class Vendor with VendorMappable {
  final String id;
  final String ownerId;
  final String logo;
  final String name;
  final String headline;
  final String website;
  final String description;
  final Location location;
  final String categoryId;
  final String priceType;
  final Map<String, OperatingHours> operatingHours;
  final List<String> experiences;
  final List<String> media;
  final List<String> gallery;
  final List<Detail> details;
  final String detailsDescription;
  final List<String> tags;
  final List<String> thingsToKnow;
  final bool isApproved;
  final bool isDrafted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Vendor({
    required this.id,
    required this.ownerId,
    required this.logo,
    required this.name,
    required this.headline,
    required this.website,
    required this.description,
    required this.location,
    required this.categoryId,
    required this.priceType,
    required this.operatingHours,
    required this.experiences,
    required this.media,
    required this.gallery,
    required this.details,
    required this.detailsDescription,
    required this.tags,
    required this.thingsToKnow,
    required this.isApproved,
    required this.isDrafted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
