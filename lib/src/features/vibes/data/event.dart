import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:intl/intl.dart';

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
  final EventCategory? category;

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
    this.category,
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

        // 1. Find the Monday of the current week
        final mondayOfCurrentWeek = now.subtract(
          Duration(days: now.weekday - 1),
        );

        // 2. Add the offset to get the specific day
        final targetDate = mondayOfCurrentWeek.add(
          Duration(days: targetWeekday - 1),
        );

        final openTimeParts = value.open.split(":");
        final int openHour = int.parse(openTimeParts[0]);
        final int openMinute = int.parse(openTimeParts[1]);

        final startDateTime = DateTime(
          targetDate.year,
          targetDate.month,
          targetDate.day,
          openHour,
          openMinute,
        );

        final closeTimeParts = value.close.split(":");
        final int closeHour = int.parse(closeTimeParts[0]);
        final int closeMinute = int.parse(closeTimeParts[1]);

        var endDateTime = DateTime(
          targetDate.year,
          targetDate.month,
          targetDate.day,
          closeHour,
          closeMinute,
        );

        // Handle closing time being on the next day (e.g., 23:00 to 02:00)
        if (endDateTime.isBefore(startDateTime)) {
          endDateTime = endDateTime.add(const Duration(days: 1));
        }

        // Generate 30-minute slots
        var currentSlot = startDateTime;
        while (currentSlot.isBefore(endDateTime)) {
          result.add(currentSlot);
          currentSlot = currentSlot.add(const Duration(minutes: 30));
        }
      }
    });
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
  final PriceType? priceType;
  final String? detailsTitle;
  final List<Experiences> experiences;
  final List<String>? thingsToKnow;
  final CategoryNoDesc? category;
  final bool isFavorited;
  final BookingExperience? bookingExperience;
  final String? termsAndConditions;

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
    this.priceType,
    required this.tags,
    required this.category,
    required this.experiences,
    required this.vendor,
    required this.createdAt,
    this.thingsToKnow,
    this.bookingExperience,
    this.isFavorited = false,
    this.detailsTitle,
    this.termsAndConditions,
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
  final AssignmentVendor? vendor;

  final AssignmentEvent? event;

  Assignment({
    required this.id,
    required this.targetType,
    this.vendor,
    this.event,
  });
}

@MappableClass()
class AssignmentEvent with AssignmentEventMappable {
  final String id;
  final PriceType? priceType;
  final String name, description;
  final List<String> media;
  final Location location;
  final DateTime startTime;
  final DateTime endTime;

  AssignmentEvent({
    required this.id,
    this.priceType,
    required this.name,
    required this.description,
    required this.media,
    required this.location,
    required this.startTime,
    required this.endTime,
  });
}

@MappableClass()
class AssignmentVendor with AssignmentVendorMappable {
  final String id;
  final PriceType? priceType;
  final String name, description;
  final List<String> media;
  final Location location;
  final Map<String, OperatingHours> operatingHours;

  AssignmentVendor({
    required this.id,
    this.priceType,
    required this.name,
    required this.description,
    required this.media,
    required this.location,
    required this.operatingHours,
  });
}

extension AssignmentEventExtensions on AssignmentVendor {
  /// Returns the duration in hours between start and end time
  /// Example: "6" for 6 hours
  String getFormattedOperatingHoursRange() {
    final now = DateTime.now();
    final dayNames = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    // Get the current day name
    final currentDayName = dayNames[now.weekday - 1];
    final todayHours = operatingHours[currentDayName];

    if (todayHours == null) {
      return "Closed";
    }

    try {
      final openTime = _parseTimeString(todayHours.open, now);
      final closeTime = _parseTimeString(todayHours.close, now);

      if (openTime == null || closeTime == null) {
        print("Close Time $closeTime");
        print("Open Time $openTime");

        return "Closed";
      }

      // If close time is before open time, it closes the next day
      final actualCloseTime = closeTime.isBefore(openTime)
          ? closeTime.add(Duration(days: 1))
          : closeTime;

      // Format: "9:00 PM - 13 Oct, 3:00 AM"
      final startFormat = DateFormat('h:mm a');
      final endDateFormat = DateFormat('d MMM');
      final endTimeFormat = DateFormat('h:mm a');

      final startStr = startFormat.format(openTime);
      final endDateStr = endDateFormat.format(actualCloseTime);
      final endTimeStr = endTimeFormat.format(actualCloseTime);

      return "$startStr – $endDateStr, $endTimeStr";
    } catch (e) {
      print("Error Time: $e");
      return "Closed";
    }
  }

  DateTime? _parseTimeString(String timeStr, DateTime baseDate) {
    try {
      // Try parsing with AM/PM format first (e.g., "9:00 PM")
      try {
        final format = DateFormat('h:mm a');
        final parsedTime = format.parse(timeStr);
        return DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          parsedTime.hour,
          parsedTime.minute,
        );
      } catch (_) {
        // Try 24-hour format (e.g., "21:00")
        final format = DateFormat('HH:mm');
        final parsedTime = format.parse(timeStr);
        return DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          parsedTime.hour,
          parsedTime.minute,
        );
      }
    } catch (e) {
      return null;
    }
  }
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
