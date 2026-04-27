// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
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
      case 'REJECTED':
        return UserStatus.rejected;
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
      case UserStatus.rejected:
        return 'REJECTED';
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
      UserStatusMapper.ensureInitialized();
      RoleMapper.ensureInitialized();
      SocialLinksMapper.ensureInitialized();
      OwnerProfileMapper.ensureInitialized();
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
  static const Field<User, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$fullName(User v) => v.fullName;
  static const Field<User, String> _f$fullName = Field(
    'fullName',
    _$fullName,
    opt: true,
  );
  static String? _$avatar(User v) => v.avatar;
  static const Field<User, String> _f$avatar = Field(
    'avatar',
    _$avatar,
    opt: true,
  );
  static UserStatus _$status(User v) => v.status;
  static const Field<User, UserStatus> _f$status = Field('status', _$status);
  static String? _$gender(User v) => v.gender;
  static const Field<User, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
  );
  static String? _$nationality(User v) => v.nationality;
  static const Field<User, String> _f$nationality = Field(
    'nationality',
    _$nationality,
    opt: true,
  );
  static DateTime? _$dateOfBirth(User v) => v.dateOfBirth;
  static const Field<User, DateTime> _f$dateOfBirth = Field(
    'dateOfBirth',
    _$dateOfBirth,
    opt: true,
  );
  static String? _$audienceSizeRange(User v) => v.audienceSizeRange;
  static const Field<User, String> _f$audienceSizeRange = Field(
    'audienceSizeRange',
    _$audienceSizeRange,
    opt: true,
  );
  static Role _$role(User v) => v.role;
  static const Field<User, Role> _f$role = Field('role', _$role);
  static String? _$referralCode(User v) => v.referralCode;
  static const Field<User, String> _f$referralCode = Field(
    'referralCode',
    _$referralCode,
    opt: true,
  );
  static DateTime _$createdAt(User v) => v.createdAt;
  static const Field<User, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static List<String>? _$interests(User v) => v.interests;
  static const Field<User, List<String>> _f$interests = Field(
    'interests',
    _$interests,
    opt: true,
  );
  static List<String>? _$contentNiches(User v) => v.contentNiches;
  static const Field<User, List<String>> _f$contentNiches = Field(
    'contentNiches',
    _$contentNiches,
    opt: true,
  );
  static String? _$businessName(User v) => v.businessName;
  static const Field<User, String> _f$businessName = Field(
    'businessName',
    _$businessName,
    opt: true,
  );
  static List<String>? _$areas(User v) => v.areas;
  static const Field<User, List<String>> _f$areas = Field(
    'areas',
    _$areas,
    opt: true,
  );
  static String? _$groupSize(User v) => v.groupSize;
  static const Field<User, String> _f$groupSize = Field(
    'groupSize',
    _$groupSize,
    opt: true,
  );
  static String? _$preferredCountry(User v) => v.preferredCountry;
  static const Field<User, String> _f$preferredCountry = Field(
    'preferredCountry',
    _$preferredCountry,
    opt: true,
  );
  static SocialLinks? _$socialLinks(User v) => v.socialLinks;
  static const Field<User, SocialLinks> _f$socialLinks = Field(
    'socialLinks',
    _$socialLinks,
    opt: true,
  );
  static String? _$password(User v) => v.password;
  static const Field<User, String> _f$password = Field(
    'password',
    _$password,
    opt: true,
  );
  static String? _$businessCategory(User v) => v.businessCategory;
  static const Field<User, String> _f$businessCategory = Field(
    'businessCategory',
    _$businessCategory,
    opt: true,
  );
  static OwnerProfile? _$ownerProfile(User v) => v.ownerProfile;
  static const Field<User, OwnerProfile> _f$ownerProfile = Field(
    'ownerProfile',
    _$ownerProfile,
    opt: true,
  );

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #email: _f$email,
    #phone: _f$phone,
    #fullName: _f$fullName,
    #avatar: _f$avatar,
    #status: _f$status,
    #gender: _f$gender,
    #nationality: _f$nationality,
    #dateOfBirth: _f$dateOfBirth,
    #audienceSizeRange: _f$audienceSizeRange,
    #role: _f$role,
    #referralCode: _f$referralCode,
    #createdAt: _f$createdAt,
    #interests: _f$interests,
    #contentNiches: _f$contentNiches,
    #businessName: _f$businessName,
    #areas: _f$areas,
    #groupSize: _f$groupSize,
    #preferredCountry: _f$preferredCountry,
    #socialLinks: _f$socialLinks,
    #password: _f$password,
    #businessCategory: _f$businessCategory,
    #ownerProfile: _f$ownerProfile,
  };

  static User _instantiate(DecodingData data) {
    return User(
      id: data.dec(_f$id),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      fullName: data.dec(_f$fullName),
      avatar: data.dec(_f$avatar),
      status: data.dec(_f$status),
      gender: data.dec(_f$gender),
      nationality: data.dec(_f$nationality),
      dateOfBirth: data.dec(_f$dateOfBirth),
      audienceSizeRange: data.dec(_f$audienceSizeRange),
      role: data.dec(_f$role),
      referralCode: data.dec(_f$referralCode),
      createdAt: data.dec(_f$createdAt),
      interests: data.dec(_f$interests),
      contentNiches: data.dec(_f$contentNiches),
      businessName: data.dec(_f$businessName),
      areas: data.dec(_f$areas),
      groupSize: data.dec(_f$groupSize),
      preferredCountry: data.dec(_f$preferredCountry),
      socialLinks: data.dec(_f$socialLinks),
      password: data.dec(_f$password),
      businessCategory: data.dec(_f$businessCategory),
      ownerProfile: data.dec(_f$ownerProfile),
    );
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get interests;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get contentNiches;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get areas;
  SocialLinksCopyWith<$R, SocialLinks, SocialLinks>? get socialLinks;
  OwnerProfileCopyWith<$R, OwnerProfile, OwnerProfile>? get ownerProfile;
  $R call({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    String? avatar,
    UserStatus? status,
    String? gender,
    String? nationality,
    DateTime? dateOfBirth,
    String? audienceSizeRange,
    Role? role,
    String? referralCode,
    DateTime? createdAt,
    List<String>? interests,
    List<String>? contentNiches,
    String? businessName,
    List<String>? areas,
    String? groupSize,
    String? preferredCountry,
    SocialLinks? socialLinks,
    String? password,
    String? businessCategory,
    OwnerProfile? ownerProfile,
  });
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get interests =>
      $value.interests != null
      ? ListCopyWith(
          $value.interests!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(interests: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get contentNiches => $value.contentNiches != null
      ? ListCopyWith(
          $value.contentNiches!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(contentNiches: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get areas =>
      $value.areas != null
      ? ListCopyWith(
          $value.areas!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(areas: v),
        )
      : null;
  @override
  SocialLinksCopyWith<$R, SocialLinks, SocialLinks>? get socialLinks =>
      $value.socialLinks?.copyWith.$chain((v) => call(socialLinks: v));
  @override
  OwnerProfileCopyWith<$R, OwnerProfile, OwnerProfile>? get ownerProfile =>
      $value.ownerProfile?.copyWith.$chain((v) => call(ownerProfile: v));
  @override
  $R call({
    Object? id = $none,
    String? email,
    Object? phone = $none,
    Object? fullName = $none,
    Object? avatar = $none,
    UserStatus? status,
    Object? gender = $none,
    Object? nationality = $none,
    Object? dateOfBirth = $none,
    Object? audienceSizeRange = $none,
    Role? role,
    Object? referralCode = $none,
    DateTime? createdAt,
    Object? interests = $none,
    Object? contentNiches = $none,
    Object? businessName = $none,
    Object? areas = $none,
    Object? groupSize = $none,
    Object? preferredCountry = $none,
    Object? socialLinks = $none,
    Object? password = $none,
    Object? businessCategory = $none,
    Object? ownerProfile = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (email != null) #email: email,
      if (phone != $none) #phone: phone,
      if (fullName != $none) #fullName: fullName,
      if (avatar != $none) #avatar: avatar,
      if (status != null) #status: status,
      if (gender != $none) #gender: gender,
      if (nationality != $none) #nationality: nationality,
      if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
      if (audienceSizeRange != $none) #audienceSizeRange: audienceSizeRange,
      if (role != null) #role: role,
      if (referralCode != $none) #referralCode: referralCode,
      if (createdAt != null) #createdAt: createdAt,
      if (interests != $none) #interests: interests,
      if (contentNiches != $none) #contentNiches: contentNiches,
      if (businessName != $none) #businessName: businessName,
      if (areas != $none) #areas: areas,
      if (groupSize != $none) #groupSize: groupSize,
      if (preferredCountry != $none) #preferredCountry: preferredCountry,
      if (socialLinks != $none) #socialLinks: socialLinks,
      if (password != $none) #password: password,
      if (businessCategory != $none) #businessCategory: businessCategory,
      if (ownerProfile != $none) #ownerProfile: ownerProfile,
    }),
  );
  @override
  User $make(CopyWithData data) => User(
    id: data.get(#id, or: $value.id),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    fullName: data.get(#fullName, or: $value.fullName),
    avatar: data.get(#avatar, or: $value.avatar),
    status: data.get(#status, or: $value.status),
    gender: data.get(#gender, or: $value.gender),
    nationality: data.get(#nationality, or: $value.nationality),
    dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
    audienceSizeRange: data.get(
      #audienceSizeRange,
      or: $value.audienceSizeRange,
    ),
    role: data.get(#role, or: $value.role),
    referralCode: data.get(#referralCode, or: $value.referralCode),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    interests: data.get(#interests, or: $value.interests),
    contentNiches: data.get(#contentNiches, or: $value.contentNiches),
    businessName: data.get(#businessName, or: $value.businessName),
    areas: data.get(#areas, or: $value.areas),
    groupSize: data.get(#groupSize, or: $value.groupSize),
    preferredCountry: data.get(#preferredCountry, or: $value.preferredCountry),
    socialLinks: data.get(#socialLinks, or: $value.socialLinks),
    password: data.get(#password, or: $value.password),
    businessCategory: data.get(#businessCategory, or: $value.businessCategory),
    ownerProfile: data.get(#ownerProfile, or: $value.ownerProfile),
  );

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialLinksMapper extends ClassMapperBase<SocialLinks> {
  SocialLinksMapper._();

  static SocialLinksMapper? _instance;
  static SocialLinksMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialLinksMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocialLinks';

  static String? _$facebook(SocialLinks v) => v.facebook;
  static const Field<SocialLinks, String> _f$facebook = Field(
    'facebook',
    _$facebook,
    opt: true,
  );
  static String? _$instagram(SocialLinks v) => v.instagram;
  static const Field<SocialLinks, String> _f$instagram = Field(
    'instagram',
    _$instagram,
    opt: true,
  );
  static String? _$website(SocialLinks v) => v.website;
  static const Field<SocialLinks, String> _f$website = Field(
    'website',
    _$website,
    opt: true,
  );

  @override
  final MappableFields<SocialLinks> fields = const {
    #facebook: _f$facebook,
    #instagram: _f$instagram,
    #website: _f$website,
  };

  static SocialLinks _instantiate(DecodingData data) {
    return SocialLinks(
      facebook: data.dec(_f$facebook),
      instagram: data.dec(_f$instagram),
      website: data.dec(_f$website),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialLinks fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialLinks>(map);
  }

  static SocialLinks fromJson(String json) {
    return ensureInitialized().decodeJson<SocialLinks>(json);
  }
}

mixin SocialLinksMappable {
  String toJson() {
    return SocialLinksMapper.ensureInitialized().encodeJson<SocialLinks>(
      this as SocialLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialLinksMapper.ensureInitialized().encodeMap<SocialLinks>(
      this as SocialLinks,
    );
  }

  SocialLinksCopyWith<SocialLinks, SocialLinks, SocialLinks> get copyWith =>
      _SocialLinksCopyWithImpl<SocialLinks, SocialLinks>(
        this as SocialLinks,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SocialLinksMapper.ensureInitialized().stringifyValue(
      this as SocialLinks,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialLinksMapper.ensureInitialized().equalsValue(
      this as SocialLinks,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialLinksMapper.ensureInitialized().hashValue(this as SocialLinks);
  }
}

extension SocialLinksValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialLinks, $Out> {
  SocialLinksCopyWith<$R, SocialLinks, $Out> get $asSocialLinks =>
      $base.as((v, t, t2) => _SocialLinksCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialLinksCopyWith<$R, $In extends SocialLinks, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? facebook, String? instagram, String? website});
  SocialLinksCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialLinksCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialLinks, $Out>
    implements SocialLinksCopyWith<$R, SocialLinks, $Out> {
  _SocialLinksCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialLinks> $mapper =
      SocialLinksMapper.ensureInitialized();
  @override
  $R call({
    Object? facebook = $none,
    Object? instagram = $none,
    Object? website = $none,
  }) => $apply(
    FieldCopyWithData({
      if (facebook != $none) #facebook: facebook,
      if (instagram != $none) #instagram: instagram,
      if (website != $none) #website: website,
    }),
  );
  @override
  SocialLinks $make(CopyWithData data) => SocialLinks(
    facebook: data.get(#facebook, or: $value.facebook),
    instagram: data.get(#instagram, or: $value.instagram),
    website: data.get(#website, or: $value.website),
  );

  @override
  SocialLinksCopyWith<$R2, SocialLinks, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialLinksCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OwnerProfileMapper extends ClassMapperBase<OwnerProfile> {
  OwnerProfileMapper._();

  static OwnerProfileMapper? _instance;
  static OwnerProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerProfileMapper._());
      VendorSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OwnerProfile';

  static List<VendorSummary>? _$vendors(OwnerProfile v) => v.vendors;
  static const Field<OwnerProfile, List<VendorSummary>> _f$vendors = Field(
    'vendors',
    _$vendors,
    opt: true,
  );

  @override
  final MappableFields<OwnerProfile> fields = const {#vendors: _f$vendors};

  static OwnerProfile _instantiate(DecodingData data) {
    return OwnerProfile(vendors: data.dec(_f$vendors));
  }

  @override
  final Function instantiate = _instantiate;

  static OwnerProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OwnerProfile>(map);
  }

  static OwnerProfile fromJson(String json) {
    return ensureInitialized().decodeJson<OwnerProfile>(json);
  }
}

mixin OwnerProfileMappable {
  String toJson() {
    return OwnerProfileMapper.ensureInitialized().encodeJson<OwnerProfile>(
      this as OwnerProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return OwnerProfileMapper.ensureInitialized().encodeMap<OwnerProfile>(
      this as OwnerProfile,
    );
  }

  OwnerProfileCopyWith<OwnerProfile, OwnerProfile, OwnerProfile> get copyWith =>
      _OwnerProfileCopyWithImpl<OwnerProfile, OwnerProfile>(
        this as OwnerProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OwnerProfileMapper.ensureInitialized().stringifyValue(
      this as OwnerProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return OwnerProfileMapper.ensureInitialized().equalsValue(
      this as OwnerProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return OwnerProfileMapper.ensureInitialized().hashValue(
      this as OwnerProfile,
    );
  }
}

extension OwnerProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OwnerProfile, $Out> {
  OwnerProfileCopyWith<$R, OwnerProfile, $Out> get $asOwnerProfile =>
      $base.as((v, t, t2) => _OwnerProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OwnerProfileCopyWith<$R, $In extends OwnerProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    VendorSummary,
    VendorSummaryCopyWith<$R, VendorSummary, VendorSummary>
  >?
  get vendors;
  $R call({List<VendorSummary>? vendors});
  OwnerProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OwnerProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OwnerProfile, $Out>
    implements OwnerProfileCopyWith<$R, OwnerProfile, $Out> {
  _OwnerProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OwnerProfile> $mapper =
      OwnerProfileMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    VendorSummary,
    VendorSummaryCopyWith<$R, VendorSummary, VendorSummary>
  >?
  get vendors => $value.vendors != null
      ? ListCopyWith(
          $value.vendors!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(vendors: v),
        )
      : null;
  @override
  $R call({Object? vendors = $none}) =>
      $apply(FieldCopyWithData({if (vendors != $none) #vendors: vendors}));
  @override
  OwnerProfile $make(CopyWithData data) =>
      OwnerProfile(vendors: data.get(#vendors, or: $value.vendors));

  @override
  OwnerProfileCopyWith<$R2, OwnerProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OwnerProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VendorSummaryMapper extends ClassMapperBase<VendorSummary> {
  VendorSummaryMapper._();

  static VendorSummaryMapper? _instance;
  static VendorSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorSummaryMapper._());
      CategoryNoDescMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VendorSummary';

  static String _$id(VendorSummary v) => v.id;
  static const Field<VendorSummary, String> _f$id = Field('id', _$id);
  static String _$name(VendorSummary v) => v.name;
  static const Field<VendorSummary, String> _f$name = Field('name', _$name);
  static String? _$image(VendorSummary v) => v.image;
  static const Field<VendorSummary, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static CategoryNoDesc? _$category(VendorSummary v) => v.category;
  static const Field<VendorSummary, CategoryNoDesc> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static Location? _$location(VendorSummary v) => v.location;
  static const Field<VendorSummary, Location> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );

  @override
  final MappableFields<VendorSummary> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #category: _f$category,
    #location: _f$location,
  };

  static VendorSummary _instantiate(DecodingData data) {
    return VendorSummary(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      category: data.dec(_f$category),
      location: data.dec(_f$location),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VendorSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorSummary>(map);
  }

  static VendorSummary fromJson(String json) {
    return ensureInitialized().decodeJson<VendorSummary>(json);
  }
}

mixin VendorSummaryMappable {
  String toJson() {
    return VendorSummaryMapper.ensureInitialized().encodeJson<VendorSummary>(
      this as VendorSummary,
    );
  }

  Map<String, dynamic> toMap() {
    return VendorSummaryMapper.ensureInitialized().encodeMap<VendorSummary>(
      this as VendorSummary,
    );
  }

  VendorSummaryCopyWith<VendorSummary, VendorSummary, VendorSummary>
  get copyWith => _VendorSummaryCopyWithImpl<VendorSummary, VendorSummary>(
    this as VendorSummary,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return VendorSummaryMapper.ensureInitialized().stringifyValue(
      this as VendorSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorSummaryMapper.ensureInitialized().equalsValue(
      this as VendorSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorSummaryMapper.ensureInitialized().hashValue(
      this as VendorSummary,
    );
  }
}

extension VendorSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorSummary, $Out> {
  VendorSummaryCopyWith<$R, VendorSummary, $Out> get $asVendorSummary =>
      $base.as((v, t, t2) => _VendorSummaryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VendorSummaryCopyWith<$R, $In extends VendorSummary, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc>? get category;
  LocationCopyWith<$R, Location, Location>? get location;
  $R call({
    String? id,
    String? name,
    String? image,
    CategoryNoDesc? category,
    Location? location,
  });
  VendorSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VendorSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorSummary, $Out>
    implements VendorSummaryCopyWith<$R, VendorSummary, $Out> {
  _VendorSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorSummary> $mapper =
      VendorSummaryMapper.ensureInitialized();
  @override
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  LocationCopyWith<$R, Location, Location>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  $R call({
    String? id,
    String? name,
    Object? image = $none,
    Object? category = $none,
    Object? location = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (image != $none) #image: image,
      if (category != $none) #category: category,
      if (location != $none) #location: location,
    }),
  );
  @override
  VendorSummary $make(CopyWithData data) => VendorSummary(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    category: data.get(#category, or: $value.category),
    location: data.get(#location, or: $value.location),
  );

  @override
  VendorSummaryCopyWith<$R2, VendorSummary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VendorSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

