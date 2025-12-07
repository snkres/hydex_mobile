import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'upcoming_event.mapper.dart';

@MappableClass()
class UpcomingEvent with UpcomingEventMappable {
  final String id;
  final String name;
  final DateTime date;
  final String time;
  final Location location;
  final UpcomingEventStatus status;
  final int numberOfGuests;

  UpcomingEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.numberOfGuests,
  });
}

@MappableEnum()
enum UpcomingEventStatus {
  @MappableValue('Pending')
  pending,

  @MappableValue('Confirmed')
  confirmed,

  @MappableValue('Invitation')
  invitation,

  @MappableValue('Cancelled')
  cancelled,
}

@MappableClass()
class HistoryData with HistoryDataMappable {
  final String id;
  final String name;
  final DateTime date;
  final String time;
  final Location location;
  final HistoryStatus status;
  final String? cancellationReason;

  HistoryData({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    this.cancellationReason,
    required this.status,
  });
}

@MappableEnum()
enum HistoryStatus {
  @MappableValue('Cancelled')
  cancelled,

  @MappableValue('Rejected')
  rejected,

  @MappableValue('Confirmed')
  confirmed,
}

@MappableClass()
class PassportData with PassportDataMappable {
  final int totalExperiences;
  final List<PassportCategory> categories;

  const PassportData({
    required this.totalExperiences,
    required this.categories,
  });
}

@MappableClass()
class PassportCategory with PassportCategoryMappable {
  final String? categoryId;
  final String categoryName;
  final int? count;
  final List<PassportVendor>? vendors;

  PassportCategory({
    this.categoryId,
    required this.categoryName,
    this.count,
    this.vendors,
  });
}

@MappableClass()
class PassportVendor with PassportVendorMappable {
  final String vendorId;
  final int visitCount;
  final String vendorName;

  PassportVendor({
    required this.vendorId,
    required this.visitCount,
    required this.vendorName,
  });
}
