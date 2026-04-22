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
  final List<ProfileGuests> guests;
  final String? cancellationReason;
  final List<String>? guestsNames;
  final List<String> thingsToKnow;
  final String passId;
  final String? termsAndConditions;
  final int totalPrice;
  final String vendorName;
  final String bookingType;
  final String passName;
  final List<String>? media;
  final String? qrCode;
  final String? qrCodeUrl;

  UpcomingEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    this.cancellationReason,
    this.guestsNames,
    required this.guests,
    required this.thingsToKnow,
    required this.passId,
    this.termsAndConditions,
    required this.totalPrice,
    required this.vendorName,
    required this.bookingType,
    required this.passName,
    this.media,
    this.qrCode,
    this.qrCodeUrl,
  });
}

@MappableClass()
class ProfileGuests with ProfileGuestsMappable {
  final String name, email, gender;

  const ProfileGuests({
    required this.name,
    required this.email,
    required this.gender,
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

  @MappableValue('No Show')
  noShow,
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
  final List<String> media;

  PassportVendor({
    required this.vendorId,
    required this.visitCount,
    required this.vendorName,
    this.media = const [],
  });
}
