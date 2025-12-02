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
  final String description;
  final Location location;
  final bool isFavorited;

  final String priceType;
  final Map<String, OperatingHours> operatingHours;
  final List<String> experiences;
  final List<String> media;

  final List<String> gallery;
  final List<Detail> details;
  final String? detailsDescription;
  final VendorCategory? category;
  final List<String> tags;
  final List<String> thingsToKnow;
  final List<EventInsideVendor> events;
  final BookingExperience? bookingExperience;

  Vendor({
    required this.id,
    required this.ownerId,
    this.logo,
    this.bookingExperience,
    this.category,
    required this.name,
    required this.headline,
    this.isFavorited = false,
    this.events = const [],
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

@MappableClass()
class EventInsideVendor with EventInsideVendorMappable {
  final String id;
  final String? name;
  final DateTime startTime;
  final List<String>? media;

  EventInsideVendor({
    required this.id,
    this.name,
    this.media,
    required this.startTime,
  });
}
