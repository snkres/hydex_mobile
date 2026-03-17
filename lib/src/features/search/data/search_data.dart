import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:intl/intl.dart';

part 'search_data.mapper.dart';

@MappableClass()
class SearchData with SearchDataMappable {
  final List<Vendor>? vendors;
  final List<SearchEvent>? events;

  SearchData({this.vendors, this.events});
}

@MappableClass()
class SearchEvent with SearchEventMappable {
  final String id, name, description;
  final PriceType? priceType;
  final CategoryNoDesc category;
  final Location location;
  final DateTime startTime, endTime;
  final List<String> media;

  SearchEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.category,
    this.priceType,
    required this.location,
    required this.media,
  });
}

class PriceOption {
  final PriceType type;
  final String label;

  const PriceOption({required this.type, required this.label});
}

extension EventExtensions on SearchEvent {
  /// Returns the duration in hours between start and end time
  /// Example: "6" for 6 hours
  String getEventDurationHours() {
    final duration = endTime.difference(startTime);
    return duration.inHours.toString();
  }

  /// Returns formatted time range for the event
  /// Example: "9:00 AM - 15 Jan, 9:00 PM"
  String getFormattedEventTimeRange() {
    try {
      // Format: "9:00 AM - 15 Jan, 9:00 PM"
      final startTimeFormat = DateFormat('h:mm a');
      final endDateFormat = DateFormat('d MMM');
      final endTimeFormat = DateFormat('h:mm a');

      final startStr = startTimeFormat.format(startTime);
      final endDateStr = endDateFormat.format(endTime);
      final endTimeStr = endTimeFormat.format(endTime);

      return "$startStr – $endDateStr, $endTimeStr";
    } catch (e) {
      return "";
    }
  }
}

extension AssignmentEventExtensions on AssignmentEvent {
  /// Returns the duration in hours between start and end time
  /// Example: "6" for 6 hours
  String getEventDurationHours() {
    final duration = endTime.difference(startTime);
    return duration.inHours.toString();
  }

  /// Returns formatted time range for the event
  /// Example: "9:00 AM - 15 Jan, 9:00 PM"
  String getFormattedEventTimeRange() {
    try {
      // Format: "9:00 AM - 15 Jan, 9:00 PM"
      final startTimeFormat = DateFormat('h:mm a');
      final endDateFormat = DateFormat('d MMM');
      final endTimeFormat = DateFormat('h:mm a');

      final startStr = startTimeFormat.format(startTime);
      final endDateStr = endDateFormat.format(endTime);
      final endTimeStr = endTimeFormat.format(endTime);

      return "$startStr – $endDateStr, $endTimeStr";
    } catch (e) {
      return "";
    }
  }
}
