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
  final String? id;
  final String email;
  final String? phone;
  final String? fullName;
  final String? avatar;
  final String? gender;
  final String? nationality;
  final DateTime? dateOfBirth;
  final String role;
  final String? referralCode;
  final String? password;

  User({
    this.id,
    required this.email,
    this.phone,
    this.fullName,
    this.avatar,
    this.gender,
    this.nationality,
    this.dateOfBirth,
    required this.role,
    this.referralCode,
    this.password,
  });
}
