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
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static String? _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field('id', _$id, opt: true);
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email = Field('email', _$email);
  static String? _$phone(User v) => v.phone;
  static const Field<User, String> _f$phone =
      Field('phone', _$phone, opt: true);
  static String? _$fullName(User v) => v.fullName;
  static const Field<User, String> _f$fullName =
      Field('fullName', _$fullName, opt: true);
  static String? _$avatar(User v) => v.avatar;
  static const Field<User, String> _f$avatar =
      Field('avatar', _$avatar, opt: true);
  static String? _$gender(User v) => v.gender;
  static const Field<User, String> _f$gender =
      Field('gender', _$gender, opt: true);
  static String? _$nationality(User v) => v.nationality;
  static const Field<User, String> _f$nationality =
      Field('nationality', _$nationality, opt: true);
  static DateTime? _$dateOfBirth(User v) => v.dateOfBirth;
  static const Field<User, DateTime> _f$dateOfBirth =
      Field('dateOfBirth', _$dateOfBirth, opt: true);
  static String _$role(User v) => v.role;
  static const Field<User, String> _f$role = Field('role', _$role);
  static String? _$referralCode(User v) => v.referralCode;
  static const Field<User, String> _f$referralCode =
      Field('referralCode', _$referralCode, opt: true);
  static String? _$password(User v) => v.password;
  static const Field<User, String> _f$password =
      Field('password', _$password, opt: true);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #email: _f$email,
    #phone: _f$phone,
    #fullName: _f$fullName,
    #avatar: _f$avatar,
    #gender: _f$gender,
    #nationality: _f$nationality,
    #dateOfBirth: _f$dateOfBirth,
    #role: _f$role,
    #referralCode: _f$referralCode,
    #password: _f$password,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        email: data.dec(_f$email),
        phone: data.dec(_f$phone),
        fullName: data.dec(_f$fullName),
        avatar: data.dec(_f$avatar),
        gender: data.dec(_f$gender),
        nationality: data.dec(_f$nationality),
        dateOfBirth: data.dec(_f$dateOfBirth),
        role: data.dec(_f$role),
        referralCode: data.dec(_f$referralCode),
        password: data.dec(_f$password));
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
  $R call(
      {String? id,
      String? email,
      String? phone,
      String? fullName,
      String? avatar,
      String? gender,
      String? nationality,
      DateTime? dateOfBirth,
      String? role,
      String? referralCode,
      String? password});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? email,
          Object? phone = $none,
          Object? fullName = $none,
          Object? avatar = $none,
          Object? gender = $none,
          Object? nationality = $none,
          Object? dateOfBirth = $none,
          String? role,
          Object? referralCode = $none,
          Object? password = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (email != null) #email: email,
        if (phone != $none) #phone: phone,
        if (fullName != $none) #fullName: fullName,
        if (avatar != $none) #avatar: avatar,
        if (gender != $none) #gender: gender,
        if (nationality != $none) #nationality: nationality,
        if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
        if (role != null) #role: role,
        if (referralCode != $none) #referralCode: referralCode,
        if (password != $none) #password: password
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      email: data.get(#email, or: $value.email),
      phone: data.get(#phone, or: $value.phone),
      fullName: data.get(#fullName, or: $value.fullName),
      avatar: data.get(#avatar, or: $value.avatar),
      gender: data.get(#gender, or: $value.gender),
      nationality: data.get(#nationality, or: $value.nationality),
      dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
      role: data.get(#role, or: $value.role),
      referralCode: data.get(#referralCode, or: $value.referralCode),
      password: data.get(#password, or: $value.password));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
