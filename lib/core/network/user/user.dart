import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'user.mapper.dart';

// Role enum
@MappableEnum()
enum Role {
  none,
  @MappableValue('SEEKER')
  seeker,
  @MappableValue('OWNER')
  owner,
  @MappableValue('AMBASSADOR')
  ambassador,
}

// Status enum (based on your JSON)
@MappableEnum()
enum UserStatus {
  @MappableValue('PENDING')
  pending,
  @MappableValue('ACTIVE')
  active,
  @MappableValue('REJECTED')
  rejected,
  @MappableValue('SUSPENDED')
  suspended,
}

@MappableClass()
class User with UserMappable {
  final String? id;
  final String email;
  final String? phone;
  final String? fullName;
  final String? avatar;
  final String? gender;
  final String? nationality;
  final UserStatus status;
  final DateTime? dateOfBirth;
  final Role role;
  final String? referralCode;
  final String? password;
  final List<String>? interests;
  final List<String>? contentNiches;
  final String? businessName;
  final List<String>? areas;
  final String? audienceSizeRange;
  final String? groupSize;
  final String? preferredCountry;
  final DateTime createdAt;
  final SocialLinks? socialLinks;
  final String? businessCategory;
  final OwnerProfile? ownerProfile;

  User({
    this.id,
    required this.email,
    this.phone,
    this.fullName,
    this.avatar,
    required this.status,
    this.gender,
    this.nationality,
    this.dateOfBirth,
    this.audienceSizeRange,
    required this.role,
    this.referralCode,
    required this.createdAt,
    this.interests,
    this.contentNiches,
    this.businessName,
    this.areas,
    this.groupSize,
    this.preferredCountry,
    this.socialLinks,
    this.password,
    this.businessCategory,
    this.ownerProfile,
  });
}

@MappableClass()
class OwnerProfile with OwnerProfileMappable {
  final List<VendorSummary>? vendors;

  OwnerProfile({this.vendors});
}

@MappableClass()
class VendorSummary with VendorSummaryMappable {
  final String id;
  final String name;
  final String? image;
  final CategoryNoDesc? category;
  final Location? location;

  VendorSummary({
    required this.id,
    required this.name,
    this.image,
    this.category,
     this.location,
  });
}

@MappableClass()
class SocialLinks with SocialLinksMappable {
  final String? facebook;
  final String? instagram;
  final String? website;

  SocialLinks({this.facebook, this.instagram, this.website});
}

extension UserToGuest on User {
  Guest toGuest() {
    return Guest(
      age: calcualteAge(dateOfBirth),
      name: fullName ?? "Unnamed",
      email: email,
      phoneNumber: phone!,
      instagram: socialLinks?.instagram ?? "",
      gender: gender ?? "male",
    );
  }
}

int calcualteAge(DateTime? bDay) {
  if (bDay == null) {
    return 0;
  }

  return DateTime.now().year - bDay.year;
}
