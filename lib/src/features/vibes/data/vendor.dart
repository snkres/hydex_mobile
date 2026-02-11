import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:intl/intl.dart';

part 'vendor.mapper.dart';

@MappableClass()
class Vendor with VendorMappable {
  final String id;
  final String? logo;
  final String name;
  final String headline;
  final String description;
  final Location location;
  final bool isFavorited;

  final PriceType priceType;
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
  final String? termsAndConditions;

  Vendor({
    required this.id,
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
    this.termsAndConditions,
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

extension VendorExtensions on Vendor {
  /// Returns the operating hours for the current day as a formatted string
  /// Example: "9:00 AM - 5:00 PM"
  /// Returns "Closed" if no hours are available for the current day
  String getTodayOperatingHours() {
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

    // Get the current day name (DateTime.weekday: 1 = Monday, 7 = Sunday)
    final currentDayName = dayNames[now.weekday - 1];

    // Get the operating hours for the current day
    final todayHours = operatingHours[currentDayName];

    if (todayHours == null) {
      return "Closed";
    }

    return "${todayHours.open} - ${todayHours.close}";
  }

  /// Returns the duration in hours between start and end time for the current day
  /// Example: "6" for 6 hours
  /// Returns "0" if closed or unable to parse times
  String getTodayOperatingHoursDuration() {
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
      return "0";
    }

    try {
      // Parse the time strings (assuming format like "9:00 AM" or "21:00")
      final openTime = _parseTimeString(todayHours.open, now);
      final closeTime = _parseTimeString(todayHours.close, now);

      if (openTime == null || closeTime == null) {
        return "0";
      }

      // Calculate duration
      var duration = closeTime.difference(openTime);

      // If close time is before open time, it means it closes the next day
      if (duration.isNegative) {
        duration = closeTime.add(Duration(days: 1)).difference(openTime);
      }

      return duration.inHours.toString();
    } catch (e) {
      return "0";
    }
  }

  /// Returns formatted operating hours range for the current day
  /// Example: "9:00 PM - 13 Oct, 3:00 AM"
  /// Returns "Closed" if no hours are available
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
