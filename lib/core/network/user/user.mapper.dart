// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class RoleMapper extends EnumMapper<Role> {
  RoleMapper._();

  static RoleMapper? _instance;
  static RoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RoleMapper._());
    }
    return _instance!;
  }

  static Role fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Role decode(dynamic value) {
    switch (value) {
      case r'none':
        return Role.none;
      case 'SEEKER':
        return Role.seeker;
      case 'OWNER':
        return Role.owner;
      case 'AMBASSADOR':
        return Role.ambassador;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Role self) {
    switch (self) {
      case Role.none:
        return r'none';
      case Role.seeker:
        return 'SEEKER';
      case Role.owner:
        return 'OWNER';
      case Role.ambassador:
        return 'AMBASSADOR';
    }
  }
}

extension RoleMapperExtension on Role {
  dynamic toValue() {
    RoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Role>(this);
  }
}

class UserStatusMapper extends EnumMapper<UserStatus> {
  UserStatusMapper._();

  static UserStatusMapper? _instance;
  static UserStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserStatusMapper._());
    }
    return _instance!;
  }

  static UserStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  UserStatus decode(dynamic value) {
    switch (value) {
      case 'PENDING':
        return UserStatus.pending;
      case 'ACTIVE':
        return UserStatus.active;
      case 'INACTIVE':
        return UserStatus.inactive;
      case 'SUSPENDED':
        return UserStatus.suspended;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(UserStatus self) {
    switch (self) {
      case UserStatus.pending:
        return 'PENDING';
      case UserStatus.active:
        return 'ACTIVE';
      case UserStatus.inactive:
        return 'INACTIVE';
      case UserStatus.suspended:
        return 'SUSPENDED';
    }
  }
}

extension UserStatusMapperExtension on UserStatus {
  dynamic toValue() {
    UserStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<UserStatus>(this);
  }
}

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
      RoleMapper.ensureInitialized();
      UserStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static String _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field('id', _$id);
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email = Field('email', _$email);
  static String? _$phone(User v) => v.phone;
  static const Field<User, String> _f$phone =
      Field('phone', _$phone, opt: true);
  static String _$firstName(User v) => v.firstName;
  static const Field<User, String> _f$firstName =
      Field('firstName', _$firstName);
  static String _$lastName(User v) => v.lastName;
  static const Field<User, String> _f$lastName = Field('lastName', _$lastName);
  static String? _$avatar(User v) => v.avatar;
  static const Field<User, String> _f$avatar =
      Field('avatar', _$avatar, opt: true);
  static Role _$role(User v) => v.role;
  static const Field<User, Role> _f$role = Field('role', _$role);
  static UserStatus _$status(User v) => v.status;
  static const Field<User, UserStatus> _f$status = Field('status', _$status);
  static bool _$isVerified(User v) => v.isVerified;
  static const Field<User, bool> _f$isVerified =
      Field('isVerified', _$isVerified);
  static bool _$isOnboarded(User v) => v.isOnboarded;
  static const Field<User, bool> _f$isOnboarded =
      Field('isOnboarded', _$isOnboarded);
  static int? _$queuePosition(User v) => v.queuePosition;
  static const Field<User, int> _f$queuePosition =
      Field('queuePosition', _$queuePosition, opt: true);
  static DateTime? _$queuedAt(User v) => v.queuedAt;
  static const Field<User, DateTime> _f$queuedAt =
      Field('queuedAt', _$queuedAt, opt: true);
  static DateTime? _$invitedAt(User v) => v.invitedAt;
  static const Field<User, DateTime> _f$invitedAt =
      Field('invitedAt', _$invitedAt, opt: true);
  static DateTime _$createdAt(User v) => v.createdAt;
  static const Field<User, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static DateTime _$updatedAt(User v) => v.updatedAt;
  static const Field<User, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt);
  static Map<String, dynamic>? _$adminProfile(User v) => v.adminProfile;
  static const Field<User, Map<String, dynamic>> _f$adminProfile =
      Field('adminProfile', _$adminProfile, opt: true);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #email: _f$email,
    #phone: _f$phone,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #avatar: _f$avatar,
    #role: _f$role,
    #status: _f$status,
    #isVerified: _f$isVerified,
    #isOnboarded: _f$isOnboarded,
    #queuePosition: _f$queuePosition,
    #queuedAt: _f$queuedAt,
    #invitedAt: _f$invitedAt,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #adminProfile: _f$adminProfile,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        email: data.dec(_f$email),
        phone: data.dec(_f$phone),
        firstName: data.dec(_f$firstName),
        lastName: data.dec(_f$lastName),
        avatar: data.dec(_f$avatar),
        role: data.dec(_f$role),
        status: data.dec(_f$status),
        isVerified: data.dec(_f$isVerified),
        isOnboarded: data.dec(_f$isOnboarded),
        queuePosition: data.dec(_f$queuePosition),
        queuedAt: data.dec(_f$queuedAt),
        invitedAt: data.dec(_f$invitedAt),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt),
        adminProfile: data.dec(_f$adminProfile));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toMap() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl<User, User>(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return UserMapper.ensureInitialized().equalsValue(this as User, other);
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get adminProfile;
  $R call(
      {String? id,
      String? email,
      String? phone,
      String? firstName,
      String? lastName,
      String? avatar,
      Role? role,
      UserStatus? status,
      bool? isVerified,
      bool? isOnboarded,
      int? queuePosition,
      DateTime? queuedAt,
      DateTime? invitedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      Map<String, dynamic>? adminProfile});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get adminProfile => $value.adminProfile != null
          ? MapCopyWith(
              $value.adminProfile!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(adminProfile: v))
          : null;
  @override
  $R call(
          {String? id,
          String? email,
          Object? phone = $none,
          String? firstName,
          String? lastName,
          Object? avatar = $none,
          Role? role,
          UserStatus? status,
          bool? isVerified,
          bool? isOnboarded,
          Object? queuePosition = $none,
          Object? queuedAt = $none,
          Object? invitedAt = $none,
          DateTime? createdAt,
          DateTime? updatedAt,
          Object? adminProfile = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (email != null) #email: email,
        if (phone != $none) #phone: phone,
        if (firstName != null) #firstName: firstName,
        if (lastName != null) #lastName: lastName,
        if (avatar != $none) #avatar: avatar,
        if (role != null) #role: role,
        if (status != null) #status: status,
        if (isVerified != null) #isVerified: isVerified,
        if (isOnboarded != null) #isOnboarded: isOnboarded,
        if (queuePosition != $none) #queuePosition: queuePosition,
        if (queuedAt != $none) #queuedAt: queuedAt,
        if (invitedAt != $none) #invitedAt: invitedAt,
        if (createdAt != null) #createdAt: createdAt,
        if (updatedAt != null) #updatedAt: updatedAt,
        if (adminProfile != $none) #adminProfile: adminProfile
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      email: data.get(#email, or: $value.email),
      phone: data.get(#phone, or: $value.phone),
      firstName: data.get(#firstName, or: $value.firstName),
      lastName: data.get(#lastName, or: $value.lastName),
      avatar: data.get(#avatar, or: $value.avatar),
      role: data.get(#role, or: $value.role),
      status: data.get(#status, or: $value.status),
      isVerified: data.get(#isVerified, or: $value.isVerified),
      isOnboarded: data.get(#isOnboarded, or: $value.isOnboarded),
      queuePosition: data.get(#queuePosition, or: $value.queuePosition),
      queuedAt: data.get(#queuedAt, or: $value.queuedAt),
      invitedAt: data.get(#invitedAt, or: $value.invitedAt),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      adminProfile: data.get(#adminProfile, or: $value.adminProfile));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserRegisterMapper extends ClassMapperBase<UserRegister> {
  UserRegisterMapper._();

  static UserRegisterMapper? _instance;
  static UserRegisterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRegisterMapper._());
      PersonalInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserRegister';

  static String _$email(UserRegister v) => v.email;
  static const Field<UserRegister, String> _f$email = Field('email', _$email);
  static String? _$phone(UserRegister v) => v.phone;
  static const Field<UserRegister, String> _f$phone =
      Field('phone', _$phone, opt: true);
  static String _$fullName(UserRegister v) => v.fullName;
  static const Field<UserRegister, String> _f$fullName =
      Field('fullName', _$fullName);
  static String _$password(UserRegister v) => v.password;
  static const Field<UserRegister, String> _f$password =
      Field('password', _$password);
  static String? _$referralCode(UserRegister v) => v.referralCode;
  static const Field<UserRegister, String> _f$referralCode =
      Field('referralCode', _$referralCode, opt: true);
  static String _$role(UserRegister v) => v.role;
  static const Field<UserRegister, String> _f$role = Field('role', _$role);
  static PersonalInfo? _$personalInfo(UserRegister v) => v.personalInfo;
  static const Field<UserRegister, PersonalInfo> _f$personalInfo =
      Field('personalInfo', _$personalInfo, opt: true);

  @override
  final MappableFields<UserRegister> fields = const {
    #email: _f$email,
    #phone: _f$phone,
    #fullName: _f$fullName,
    #password: _f$password,
    #referralCode: _f$referralCode,
    #role: _f$role,
    #personalInfo: _f$personalInfo,
  };

  static UserRegister _instantiate(DecodingData data) {
    return UserRegister(
        email: data.dec(_f$email),
        phone: data.dec(_f$phone),
        fullName: data.dec(_f$fullName),
        password: data.dec(_f$password),
        referralCode: data.dec(_f$referralCode),
        role: data.dec(_f$role),
        personalInfo: data.dec(_f$personalInfo));
  }

  @override
  final Function instantiate = _instantiate;

  static UserRegister fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserRegister>(map);
  }

  static UserRegister fromJson(String json) {
    return ensureInitialized().decodeJson<UserRegister>(json);
  }
}

mixin UserRegisterMappable {
  String toJson() {
    return UserRegisterMapper.ensureInitialized()
        .encodeJson<UserRegister>(this as UserRegister);
  }

  Map<String, dynamic> toMap() {
    return UserRegisterMapper.ensureInitialized()
        .encodeMap<UserRegister>(this as UserRegister);
  }

  UserRegisterCopyWith<UserRegister, UserRegister, UserRegister> get copyWith =>
      _UserRegisterCopyWithImpl<UserRegister, UserRegister>(
          this as UserRegister, $identity, $identity);
  @override
  String toString() {
    return UserRegisterMapper.ensureInitialized()
        .stringifyValue(this as UserRegister);
  }

  @override
  bool operator ==(Object other) {
    return UserRegisterMapper.ensureInitialized()
        .equalsValue(this as UserRegister, other);
  }

  @override
  int get hashCode {
    return UserRegisterMapper.ensureInitialized()
        .hashValue(this as UserRegister);
  }
}

extension UserRegisterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserRegister, $Out> {
  UserRegisterCopyWith<$R, UserRegister, $Out> get $asUserRegister =>
      $base.as((v, t, t2) => _UserRegisterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserRegisterCopyWith<$R, $In extends UserRegister, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PersonalInfoCopyWith<$R, PersonalInfo, PersonalInfo>? get personalInfo;
  $R call(
      {String? email,
      String? phone,
      String? fullName,
      String? password,
      String? referralCode,
      String? role,
      PersonalInfo? personalInfo});
  UserRegisterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserRegisterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserRegister, $Out>
    implements UserRegisterCopyWith<$R, UserRegister, $Out> {
  _UserRegisterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserRegister> $mapper =
      UserRegisterMapper.ensureInitialized();
  @override
  PersonalInfoCopyWith<$R, PersonalInfo, PersonalInfo>? get personalInfo =>
      $value.personalInfo?.copyWith.$chain((v) => call(personalInfo: v));
  @override
  $R call(
          {String? email,
          Object? phone = $none,
          String? fullName,
          String? password,
          Object? referralCode = $none,
          String? role,
          Object? personalInfo = $none}) =>
      $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (phone != $none) #phone: phone,
        if (fullName != null) #fullName: fullName,
        if (password != null) #password: password,
        if (referralCode != $none) #referralCode: referralCode,
        if (role != null) #role: role,
        if (personalInfo != $none) #personalInfo: personalInfo
      }));
  @override
  UserRegister $make(CopyWithData data) => UserRegister(
      email: data.get(#email, or: $value.email),
      phone: data.get(#phone, or: $value.phone),
      fullName: data.get(#fullName, or: $value.fullName),
      password: data.get(#password, or: $value.password),
      referralCode: data.get(#referralCode, or: $value.referralCode),
      role: data.get(#role, or: $value.role),
      personalInfo: data.get(#personalInfo, or: $value.personalInfo));

  @override
  UserRegisterCopyWith<$R2, UserRegister, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserRegisterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PersonalInfoMapper extends ClassMapperBase<PersonalInfo> {
  PersonalInfoMapper._();

  static PersonalInfoMapper? _instance;
  static PersonalInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonalInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PersonalInfo';

  static String _$nationality(PersonalInfo v) => v.nationality;
  static const Field<PersonalInfo, String> _f$nationality =
      Field('nationality', _$nationality);
  static String _$gender(PersonalInfo v) => v.gender;
  static const Field<PersonalInfo, String> _f$gender =
      Field('gender', _$gender);
  static String _$dateOfBirth(PersonalInfo v) => v.dateOfBirth;
  static const Field<PersonalInfo, String> _f$dateOfBirth =
      Field('dateOfBirth', _$dateOfBirth);
  static String _$socialStatus(PersonalInfo v) => v.socialStatus;
  static const Field<PersonalInfo, String> _f$socialStatus =
      Field('socialStatus', _$socialStatus);
  static String? _$instagram(PersonalInfo v) => v.instagram;
  static const Field<PersonalInfo, String> _f$instagram =
      Field('instagram', _$instagram, opt: true);
  static String? _$facebook(PersonalInfo v) => v.facebook;
  static const Field<PersonalInfo, String> _f$facebook =
      Field('facebook', _$facebook, opt: true);

  @override
  final MappableFields<PersonalInfo> fields = const {
    #nationality: _f$nationality,
    #gender: _f$gender,
    #dateOfBirth: _f$dateOfBirth,
    #socialStatus: _f$socialStatus,
    #instagram: _f$instagram,
    #facebook: _f$facebook,
  };

  static PersonalInfo _instantiate(DecodingData data) {
    return PersonalInfo(
        nationality: data.dec(_f$nationality),
        gender: data.dec(_f$gender),
        dateOfBirth: data.dec(_f$dateOfBirth),
        socialStatus: data.dec(_f$socialStatus),
        instagram: data.dec(_f$instagram),
        facebook: data.dec(_f$facebook));
  }

  @override
  final Function instantiate = _instantiate;

  static PersonalInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PersonalInfo>(map);
  }

  static PersonalInfo fromJson(String json) {
    return ensureInitialized().decodeJson<PersonalInfo>(json);
  }
}

mixin PersonalInfoMappable {
  String toJson() {
    return PersonalInfoMapper.ensureInitialized()
        .encodeJson<PersonalInfo>(this as PersonalInfo);
  }

  Map<String, dynamic> toMap() {
    return PersonalInfoMapper.ensureInitialized()
        .encodeMap<PersonalInfo>(this as PersonalInfo);
  }

  PersonalInfoCopyWith<PersonalInfo, PersonalInfo, PersonalInfo> get copyWith =>
      _PersonalInfoCopyWithImpl<PersonalInfo, PersonalInfo>(
          this as PersonalInfo, $identity, $identity);
  @override
  String toString() {
    return PersonalInfoMapper.ensureInitialized()
        .stringifyValue(this as PersonalInfo);
  }

  @override
  bool operator ==(Object other) {
    return PersonalInfoMapper.ensureInitialized()
        .equalsValue(this as PersonalInfo, other);
  }

  @override
  int get hashCode {
    return PersonalInfoMapper.ensureInitialized()
        .hashValue(this as PersonalInfo);
  }
}

extension PersonalInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersonalInfo, $Out> {
  PersonalInfoCopyWith<$R, PersonalInfo, $Out> get $asPersonalInfo =>
      $base.as((v, t, t2) => _PersonalInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PersonalInfoCopyWith<$R, $In extends PersonalInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? nationality,
      String? gender,
      String? dateOfBirth,
      String? socialStatus,
      String? instagram,
      String? facebook});
  PersonalInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PersonalInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersonalInfo, $Out>
    implements PersonalInfoCopyWith<$R, PersonalInfo, $Out> {
  _PersonalInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersonalInfo> $mapper =
      PersonalInfoMapper.ensureInitialized();
  @override
  $R call(
          {String? nationality,
          String? gender,
          String? dateOfBirth,
          String? socialStatus,
          Object? instagram = $none,
          Object? facebook = $none}) =>
      $apply(FieldCopyWithData({
        if (nationality != null) #nationality: nationality,
        if (gender != null) #gender: gender,
        if (dateOfBirth != null) #dateOfBirth: dateOfBirth,
        if (socialStatus != null) #socialStatus: socialStatus,
        if (instagram != $none) #instagram: instagram,
        if (facebook != $none) #facebook: facebook
      }));
  @override
  PersonalInfo $make(CopyWithData data) => PersonalInfo(
      nationality: data.get(#nationality, or: $value.nationality),
      gender: data.get(#gender, or: $value.gender),
      dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
      socialStatus: data.get(#socialStatus, or: $value.socialStatus),
      instagram: data.get(#instagram, or: $value.instagram),
      facebook: data.get(#facebook, or: $value.facebook));

  @override
  PersonalInfoCopyWith<$R2, PersonalInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersonalInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
