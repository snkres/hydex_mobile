import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/core/network/user/user.dart';

part 'profile.mapper.dart';

@MappableClass()
class Profile with ProfileMappable {
  final ProfileUser user;
  final ProfileSum summary;

  Profile({required this.user, required this.summary});
}

@MappableClass()
class ProfileUser with ProfileUserMappable {
  final String id;
  final String fullName;
  final String? avatar;
  final Role role;
  final String email;
  final String nationality;
  final DateTime createdAt;
  final String phone;
  ProfileUser({
    required this.id,
    required this.fullName,
    this.avatar,
    required this.role,
    required this.email,
    required this.phone,
    required this.nationality,
    required this.createdAt,
  });
}

@MappableClass()
class ProfileSum with ProfileSumMappable {
  final int upcomingCount;
  final int invitesCount;

  ProfileSum({this.invitesCount = 0, this.upcomingCount = 0});
}
