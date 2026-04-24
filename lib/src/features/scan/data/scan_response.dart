import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
part 'scan_response.mapper.dart';

@MappableClass()
class ScanResponse with ScanResponseMappable {
  final String id;
  final DateTime bookingDate;
  final String fullName;
  final String email;
  final String? phone;
  final String? gender;
  final String? qrCodeUrl;
  final String status;
  final ScanPass pass;

  ScanResponse({
    required this.id,
    required this.bookingDate,
    required this.fullName,
    required this.email,
    this.phone,
    this.gender,
    this.qrCodeUrl,
    required this.status,
    required this.pass,
  });
}

@MappableClass()
class ScanPass with ScanPassMappable {
  final String name;
  final ScanBookingExperience? bookingExperience;

  ScanPass({required this.name, this.bookingExperience});
}

@MappableClass()
class ScanBookingExperience with ScanBookingExperienceMappable {
  final ScanVendor? vendor;
  final ScanEvent? event;

  ScanBookingExperience({this.vendor, this.event});
}

@MappableClass()
class ScanVendor with ScanVendorMappable {
  final String name;

  ScanVendor({required this.name});
}

@MappableClass()
class ScanEvent with ScanEventMappable {
  final String name;
  final List<String>? media;
  final Location location;

  ScanEvent({required this.name, this.media, required this.location});
}
