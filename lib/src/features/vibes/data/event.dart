import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';

part 'event.mapper.dart';

@MappableEnum()
enum BannerType {
  @MappableValue('FEATURED')
  featured,
  @MappableValue('PROMOTIONAL')
  promotional,
}

@MappableClass()
class Banner with BannerMappable {
  final String id;
  final BannerType type;
  final String headline;
  final String subtitle;
  String? image;
  String? video;
  final DateTime campaignStartDate;
  final DateTime campaignEndDate;

  Banner({
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

@MappableClass()
class Detail with DetailMappable {
  final String image;
  final String title;

  Detail({required this.image, required this.title});
}

@MappableClass()
class OperatingHours with OperatingHoursMappable {
  final String open;
  final String close;

  OperatingHours({required this.open, required this.close});
}

@MappableClass()
class Experiences with ExperiencesMappable {
  final String description;
  final String? title;
  Experiences({required this.description, this.title});
}

@MappableClass()
class Event with EventMappable {
  final String id;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> media;
  final Location location;
  final List<Detail> details;
  final String priceType;
  final List<String> tags;
  final List<Experiences> experiences;
  final EventCategory? category;
  final bool isFavorited;
  final BookingExperience? bookingExperience;

  final Vendor vendor;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.media,
    required this.location,
    required this.details,
    required this.priceType,
    required this.tags,
    required this.category,
    required this.experiences,
    required this.vendor,
    required this.createdAt,
    this.bookingExperience,
    this.isFavorited = false,
  });
}

@MappableClass()
class Passes with PassesMappable {
  final String id;
  final String name;
  final String? benefits;
  final double price;
  final int maximumAmount;
  final int currentBookings;
  final bool isActive;
  final int rouletteRemainingWins;
  final int rouletteMaxWins;
  final int? discountPercentage;

  Passes({
    required this.id,
    required this.name,
    required this.benefits,
    required this.price,
    required this.maximumAmount,
    required this.currentBookings,
    required this.isActive,
    required this.rouletteRemainingWins,
    required this.rouletteMaxWins,
    required this.discountPercentage,
  });
}

@MappableClass()
class BookingExperience with BookingExperienceMappable {
  final String id;
  final List<Passes> passes;

  BookingExperience({required this.id, required this.passes});
}
