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
    required this.assignment,
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

extension ScheduleParser on Map<String, OperatingHours> {
  List<DateTime> toOpenDateTimes() {
    final now = DateTime.now();
    final List<DateTime> result = [];

    // Map of day names to Dart weekday integers (Monday=1 ... Sunday=7)
    final dayMap = {
      "monday": DateTime.monday,
      "tuesday": DateTime.tuesday,
      "wednesday": DateTime.wednesday,
      "thursday": DateTime.thursday,
      "friday": DateTime.friday,
      "saturday": DateTime.saturday,
      "sunday": DateTime.sunday,
    };

    forEach((key, value) {
      // Clean the key (trim whitespace, lower case) to ensure matching
      final normalizedDay = key.trim().toLowerCase();

      if (dayMap.containsKey(normalizedDay)) {
        final targetWeekday = dayMap[normalizedDay]!;

        // --- Date Calculation Logic ---
        // We cannot just put 'targetWeekday' into the day field of DateTime
        // because the 1st of the month isn't necessarily a Monday.
        // Instead, we find the date of that weekday in the *current week*.

        // 1. Find the Monday of the current week
        final mondayOfCurrentWeek = now.subtract(
          Duration(days: now.weekday - 1),
        );

        // 2. Add the offset to get the specific day
        final targetDate = mondayOfCurrentWeek.add(
          Duration(days: targetWeekday - 1),
        );

        // --- Time Parsing Logic ---
        // Parse "9:00" -> hour: 9, minute: 0
        final timeParts = value.open.split(":");
        final int hour = int.parse(timeParts[0]);
        final int minute = int.parse(timeParts[1]);

        // Combine Date and Time
        final dateTime = DateTime(
          targetDate.year,
          targetDate.month,
          targetDate.day,
          hour,
          minute,
        );

        result.add(dateTime);
      }
    });

    // Optional: Sort the list by date/time
    result.sort((a, b) => a.compareTo(b));

    return result;
  }
}

@MappableClass()
class Experiences with ExperiencesMappable {
  final String description;
  final String? title;
  Experiences({required this.description, this.title});
}

@MappableClass()
class CategoryNoDesc with CategoryNoDescMappable {
  final String id;
  final String name;
  CategoryNoDesc({required this.id, required this.name});
}

@MappableClass()
class Event with EventMappable {
  final String id;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> media, tags;
  final Location location;
  final List<Detail> details;
  final PriceType priceType;
  final String? detailsTitle;
  final List<Experiences> experiences;
  final List<String>? thingsToKnow;
  final CategoryNoDesc? category;
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
    this.thingsToKnow,
    this.bookingExperience,
    this.isFavorited = false,
    this.detailsTitle,
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

@MappableEnum()
enum PriceType {
  @MappableValue('CASUAL')
  casual,
  @MappableValue('MODERATE')
  moderate,
  @MappableValue('PREMIUM')
  premium,
  @MappableValue('LUXURY')
  luxury,
}

extension PriceTypeX on PriceType {
  String get label {
    switch (this) {
      case PriceType.casual:
        return r"Casual ($)";
      case PriceType.moderate:
        return r"Moderate ($$)";
      case PriceType.premium:
        return r"Premium ($$$)";
      case PriceType.luxury:
        return r"Luxury ($$$$)";
    }
  }
}
