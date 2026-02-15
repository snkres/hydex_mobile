// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile.dart';

class ProfileMapper extends ClassMapperBase<Profile> {
  ProfileMapper._();

  static ProfileMapper? _instance;
  static ProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileMapper._());
      ProfileUserMapper.ensureInitialized();
      ProfileSumMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Profile';

  static ProfileUser _$user(Profile v) => v.user;
  static const Field<Profile, ProfileUser> _f$user = Field('user', _$user);
  static ProfileSum _$summary(Profile v) => v.summary;
  static const Field<Profile, ProfileSum> _f$summary = Field(
    'summary',
    _$summary,
  );

  @override
  final MappableFields<Profile> fields = const {
    #user: _f$user,
    #summary: _f$summary,
  };

  static Profile _instantiate(DecodingData data) {
    return Profile(user: data.dec(_f$user), summary: data.dec(_f$summary));
  }

  @override
  final Function instantiate = _instantiate;

  static Profile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Profile>(map);
  }

  static Profile fromJson(String json) {
    return ensureInitialized().decodeJson<Profile>(json);
  }
}

mixin ProfileMappable {
  String toJson() {
    return ProfileMapper.ensureInitialized().encodeJson<Profile>(
      this as Profile,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileMapper.ensureInitialized().encodeMap<Profile>(
      this as Profile,
    );
  }

  ProfileCopyWith<Profile, Profile, Profile> get copyWith =>
      _ProfileCopyWithImpl<Profile, Profile>(
        this as Profile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileMapper.ensureInitialized().stringifyValue(this as Profile);
  }

  @override
  bool operator ==(Object other) {
    return ProfileMapper.ensureInitialized().equalsValue(
      this as Profile,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileMapper.ensureInitialized().hashValue(this as Profile);
  }
}

extension ProfileValueCopy<$R, $Out> on ObjectCopyWith<$R, Profile, $Out> {
  ProfileCopyWith<$R, Profile, $Out> get $asProfile =>
      $base.as((v, t, t2) => _ProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileCopyWith<$R, $In extends Profile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileUserCopyWith<$R, ProfileUser, ProfileUser> get user;
  ProfileSumCopyWith<$R, ProfileSum, ProfileSum> get summary;
  $R call({ProfileUser? user, ProfileSum? summary});
  ProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Profile, $Out>
    implements ProfileCopyWith<$R, Profile, $Out> {
  _ProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Profile> $mapper =
      ProfileMapper.ensureInitialized();
  @override
  ProfileUserCopyWith<$R, ProfileUser, ProfileUser> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  ProfileSumCopyWith<$R, ProfileSum, ProfileSum> get summary =>
      $value.summary.copyWith.$chain((v) => call(summary: v));
  @override
  $R call({ProfileUser? user, ProfileSum? summary}) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (summary != null) #summary: summary,
    }),
  );
  @override
  Profile $make(CopyWithData data) => Profile(
    user: data.get(#user, or: $value.user),
    summary: data.get(#summary, or: $value.summary),
  );

  @override
  ProfileCopyWith<$R2, Profile, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileUserMapper extends ClassMapperBase<ProfileUser> {
  ProfileUserMapper._();

  static ProfileUserMapper? _instance;
  static ProfileUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileUserMapper._());
      RoleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileUser';

  static String _$id(ProfileUser v) => v.id;
  static const Field<ProfileUser, String> _f$id = Field('id', _$id);
  static String _$fullName(ProfileUser v) => v.fullName;
  static const Field<ProfileUser, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static String? _$avatar(ProfileUser v) => v.avatar;
  static const Field<ProfileUser, String> _f$avatar = Field(
    'avatar',
    _$avatar,
    opt: true,
  );
  static Role _$role(ProfileUser v) => v.role;
  static const Field<ProfileUser, Role> _f$role = Field('role', _$role);
  static String _$email(ProfileUser v) => v.email;
  static const Field<ProfileUser, String> _f$email = Field('email', _$email);
  static String _$phone(ProfileUser v) => v.phone;
  static const Field<ProfileUser, String> _f$phone = Field('phone', _$phone);

  @override
  final MappableFields<ProfileUser> fields = const {
    #id: _f$id,
    #fullName: _f$fullName,
    #avatar: _f$avatar,
    #role: _f$role,
    #email: _f$email,
    #phone: _f$phone,
  };

  static ProfileUser _instantiate(DecodingData data) {
    return ProfileUser(
      id: data.dec(_f$id),
      fullName: data.dec(_f$fullName),
      avatar: data.dec(_f$avatar),
      role: data.dec(_f$role),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileUser>(map);
  }

  static ProfileUser fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileUser>(json);
  }
}

mixin ProfileUserMappable {
  String toJson() {
    return ProfileUserMapper.ensureInitialized().encodeJson<ProfileUser>(
      this as ProfileUser,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileUserMapper.ensureInitialized().encodeMap<ProfileUser>(
      this as ProfileUser,
    );
  }

  ProfileUserCopyWith<ProfileUser, ProfileUser, ProfileUser> get copyWith =>
      _ProfileUserCopyWithImpl<ProfileUser, ProfileUser>(
        this as ProfileUser,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileUserMapper.ensureInitialized().stringifyValue(
      this as ProfileUser,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileUserMapper.ensureInitialized().equalsValue(
      this as ProfileUser,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileUserMapper.ensureInitialized().hashValue(this as ProfileUser);
  }
}

extension ProfileUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileUser, $Out> {
  ProfileUserCopyWith<$R, ProfileUser, $Out> get $asProfileUser =>
      $base.as((v, t, t2) => _ProfileUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileUserCopyWith<$R, $In extends ProfileUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? fullName,
    String? avatar,
    Role? role,
    String? email,
    String? phone,
  });
  ProfileUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileUser, $Out>
    implements ProfileUserCopyWith<$R, ProfileUser, $Out> {
  _ProfileUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileUser> $mapper =
      ProfileUserMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? fullName,
    Object? avatar = $none,
    Role? role,
    String? email,
    String? phone,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fullName != null) #fullName: fullName,
      if (avatar != $none) #avatar: avatar,
      if (role != null) #role: role,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
    }),
  );
  @override
  ProfileUser $make(CopyWithData data) => ProfileUser(
    id: data.get(#id, or: $value.id),
    fullName: data.get(#fullName, or: $value.fullName),
    avatar: data.get(#avatar, or: $value.avatar),
    role: data.get(#role, or: $value.role),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
  );

  @override
  ProfileUserCopyWith<$R2, ProfileUser, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileSumMapper extends ClassMapperBase<ProfileSum> {
  ProfileSumMapper._();

  static ProfileSumMapper? _instance;
  static ProfileSumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileSumMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileSum';

  static int _$invitesCount(ProfileSum v) => v.invitesCount;
  static const Field<ProfileSum, int> _f$invitesCount = Field(
    'invitesCount',
    _$invitesCount,
    opt: true,
    def: 0,
  );
  static int _$upcomingCount(ProfileSum v) => v.upcomingCount;
  static const Field<ProfileSum, int> _f$upcomingCount = Field(
    'upcomingCount',
    _$upcomingCount,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<ProfileSum> fields = const {
    #invitesCount: _f$invitesCount,
    #upcomingCount: _f$upcomingCount,
  };

  static ProfileSum _instantiate(DecodingData data) {
    return ProfileSum(
      invitesCount: data.dec(_f$invitesCount),
      upcomingCount: data.dec(_f$upcomingCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileSum fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileSum>(map);
  }

  static ProfileSum fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileSum>(json);
  }
}

mixin ProfileSumMappable {
  String toJson() {
    return ProfileSumMapper.ensureInitialized().encodeJson<ProfileSum>(
      this as ProfileSum,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileSumMapper.ensureInitialized().encodeMap<ProfileSum>(
      this as ProfileSum,
    );
  }

  ProfileSumCopyWith<ProfileSum, ProfileSum, ProfileSum> get copyWith =>
      _ProfileSumCopyWithImpl<ProfileSum, ProfileSum>(
        this as ProfileSum,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileSumMapper.ensureInitialized().stringifyValue(
      this as ProfileSum,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileSumMapper.ensureInitialized().equalsValue(
      this as ProfileSum,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileSumMapper.ensureInitialized().hashValue(this as ProfileSum);
  }
}

extension ProfileSumValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileSum, $Out> {
  ProfileSumCopyWith<$R, ProfileSum, $Out> get $asProfileSum =>
      $base.as((v, t, t2) => _ProfileSumCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileSumCopyWith<$R, $In extends ProfileSum, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? invitesCount, int? upcomingCount});
  ProfileSumCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileSumCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileSum, $Out>
    implements ProfileSumCopyWith<$R, ProfileSum, $Out> {
  _ProfileSumCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileSum> $mapper =
      ProfileSumMapper.ensureInitialized();
  @override
  $R call({int? invitesCount, int? upcomingCount}) => $apply(
    FieldCopyWithData({
      if (invitesCount != null) #invitesCount: invitesCount,
      if (upcomingCount != null) #upcomingCount: upcomingCount,
    }),
  );
  @override
  ProfileSum $make(CopyWithData data) => ProfileSum(
    invitesCount: data.get(#invitesCount, or: $value.invitesCount),
    upcomingCount: data.get(#upcomingCount, or: $value.upcomingCount),
  );

  @override
  ProfileSumCopyWith<$R2, ProfileSum, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileSumCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

