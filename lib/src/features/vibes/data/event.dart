import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
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
  final Assignment assignment;

  Banner({
    required this.id,
    required this.type,
    required this.headline,
    required this.subtitle,
    this.image,
    this.video,
    required this.campaignStartDate,
    required this.campaignEndDate,
    required this.assignment
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

extension OperatingHoursX on OperatingHours {
  DateTime toOpenDateTime() {
    final currentDate = DateTime.now();
    final parts = open.split(':');
    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
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
  final int? rouletteRemainingWins;
  final int? rouletteMaxWins;
  final int? discountPercentage;

  Passes({
    required this.id,
    required this.name,
    required this.benefits,
    required this.price,
    required this.maximumAmount,
    required this.currentBookings,
    required this.isActive,
    this.rouletteRemainingWins,
    this.rouletteMaxWins,
    required this.discountPercentage,
  });
}

@MappableClass()
class BookingExperience with BookingExperienceMappable {
  final String id;
  final List<Passes> passes;
  final bool requireReservationApproval;

  BookingExperience({
    required this.id,
    required this.passes,
    this.requireReservationApproval = false,
  });
}

@MappableClass()
class Assignment with AssignmentMappable {
  final String id;
  final AssignmentStatus targetType;
  final Vendor vendor;

  Assignment({
    required this.id,
    required this.targetType,
    required this.vendor,
  });
}

@MappableEnum()
enum AssignmentStatus {
  @MappableValue('VENDOR')
  vendor,
  @MappableValue('EVENT')
  event,
}
