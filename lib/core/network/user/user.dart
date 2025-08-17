import 'package:dart_mappable/dart_mappable.dart';

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
  @MappableValue('INACTIVE')
  inactive,
  @MappableValue('SUSPENDED')
  suspended,
}

@MappableClass()
class User with UserMappable {
  final String id;
  final String email;
  final String? phone;

  @MappableField(key: 'firstName')
  final String firstName;

  @MappableField(key: 'lastName')
  final String lastName;

  final String? avatar;
  final Role role;
  final UserStatus status;

  @MappableField(key: 'isVerified')
  final bool isVerified;

  @MappableField(key: 'isOnboarded')
  final bool isOnboarded;

  @MappableField(key: 'queuePosition')
  final int? queuePosition;

  @MappableField(key: 'queuedAt')
  final DateTime? queuedAt;

  @MappableField(key: 'invitedAt')
  final DateTime? invitedAt;

  @MappableField(key: 'createdAt')
  final DateTime createdAt;

  @MappableField(key: 'updatedAt')
  final DateTime updatedAt;

  @MappableField(key: 'adminProfile')
  final Map<String, dynamic>? adminProfile;

  User({
    required this.id,
    required this.email,
    this.phone,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.role,
    required this.status,
    required this.isVerified,
    required this.isOnboarded,
    this.queuePosition,
    this.queuedAt,
    this.invitedAt,
    required this.createdAt,
    required this.updatedAt,
    this.adminProfile,
  });

  // Convenience getters
  String get fullName => '$firstName $lastName';

  bool get isPending => status == UserStatus.pending;
  bool get isActive => status == UserStatus.active;
  bool get isSeeker => role == Role.seeker;
  bool get isOwner => role == Role.owner;
  bool get isAmbassador => role == Role.ambassador;
}

@MappableClass()
class UserRegister with UserRegisterMappable {
  final String email;
  final String? phone;
  final String fullName;

  final String role;
  final String password;
  final PersonalInfo? personalInfo;
  final String? referralCode;

  UserRegister({
    required this.email,
    this.phone,
    required this.fullName,
    required this.password,
    this.referralCode,
    required this.role,
    this.personalInfo,
  });
}

@MappableClass()
class PersonalInfo with PersonalInfoMappable {
  final String nationality;
  final String gender;
  final String dateOfBirth;
  final String socialStatus;
  final String? instagram;
  final String? facebook;

  PersonalInfo({
    required this.nationality,
    required this.gender,
    required this.dateOfBirth,
    required this.socialStatus,
    this.instagram,
    this.facebook,
  });
}
