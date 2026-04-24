// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'scan_response.dart';

class ScanResponseMapper extends ClassMapperBase<ScanResponse> {
  ScanResponseMapper._();

  static ScanResponseMapper? _instance;
  static ScanResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanResponseMapper._());
      ScanPassMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanResponse';

  static String _$id(ScanResponse v) => v.id;
  static const Field<ScanResponse, String> _f$id = Field('id', _$id);
  static DateTime _$bookingDate(ScanResponse v) => v.bookingDate;
  static const Field<ScanResponse, DateTime> _f$bookingDate = Field(
    'bookingDate',
    _$bookingDate,
  );
  static String _$fullName(ScanResponse v) => v.fullName;
  static const Field<ScanResponse, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static String _$email(ScanResponse v) => v.email;
  static const Field<ScanResponse, String> _f$email = Field('email', _$email);
  static String? _$phone(ScanResponse v) => v.phone;
  static const Field<ScanResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$gender(ScanResponse v) => v.gender;
  static const Field<ScanResponse, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
  );
  static String? _$qrCodeUrl(ScanResponse v) => v.qrCodeUrl;
  static const Field<ScanResponse, String> _f$qrCodeUrl = Field(
    'qrCodeUrl',
    _$qrCodeUrl,
    opt: true,
  );
  static String _$status(ScanResponse v) => v.status;
  static const Field<ScanResponse, String> _f$status = Field(
    'status',
    _$status,
  );
  static ScanPass _$pass(ScanResponse v) => v.pass;
  static const Field<ScanResponse, ScanPass> _f$pass = Field('pass', _$pass);

  @override
  final MappableFields<ScanResponse> fields = const {
    #id: _f$id,
    #bookingDate: _f$bookingDate,
    #fullName: _f$fullName,
    #email: _f$email,
    #phone: _f$phone,
    #gender: _f$gender,
    #qrCodeUrl: _f$qrCodeUrl,
    #status: _f$status,
    #pass: _f$pass,
  };

  static ScanResponse _instantiate(DecodingData data) {
    return ScanResponse(
      id: data.dec(_f$id),
      bookingDate: data.dec(_f$bookingDate),
      fullName: data.dec(_f$fullName),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      gender: data.dec(_f$gender),
      qrCodeUrl: data.dec(_f$qrCodeUrl),
      status: data.dec(_f$status),
      pass: data.dec(_f$pass),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanResponse>(map);
  }

  static ScanResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ScanResponse>(json);
  }
}

mixin ScanResponseMappable {
  String toJson() {
    return ScanResponseMapper.ensureInitialized().encodeJson<ScanResponse>(
      this as ScanResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanResponseMapper.ensureInitialized().encodeMap<ScanResponse>(
      this as ScanResponse,
    );
  }

  ScanResponseCopyWith<ScanResponse, ScanResponse, ScanResponse> get copyWith =>
      _ScanResponseCopyWithImpl<ScanResponse, ScanResponse>(
        this as ScanResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ScanResponseMapper.ensureInitialized().stringifyValue(
      this as ScanResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanResponseMapper.ensureInitialized().equalsValue(
      this as ScanResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanResponseMapper.ensureInitialized().hashValue(
      this as ScanResponse,
    );
  }
}

extension ScanResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanResponse, $Out> {
  ScanResponseCopyWith<$R, ScanResponse, $Out> get $asScanResponse =>
      $base.as((v, t, t2) => _ScanResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanResponseCopyWith<$R, $In extends ScanResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ScanPassCopyWith<$R, ScanPass, ScanPass> get pass;
  $R call({
    String? id,
    DateTime? bookingDate,
    String? fullName,
    String? email,
    String? phone,
    String? gender,
    String? qrCodeUrl,
    String? status,
    ScanPass? pass,
  });
  ScanResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanResponse, $Out>
    implements ScanResponseCopyWith<$R, ScanResponse, $Out> {
  _ScanResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanResponse> $mapper =
      ScanResponseMapper.ensureInitialized();
  @override
  ScanPassCopyWith<$R, ScanPass, ScanPass> get pass =>
      $value.pass.copyWith.$chain((v) => call(pass: v));
  @override
  $R call({
    String? id,
    DateTime? bookingDate,
    String? fullName,
    String? email,
    Object? phone = $none,
    Object? gender = $none,
    Object? qrCodeUrl = $none,
    String? status,
    ScanPass? pass,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (bookingDate != null) #bookingDate: bookingDate,
      if (fullName != null) #fullName: fullName,
      if (email != null) #email: email,
      if (phone != $none) #phone: phone,
      if (gender != $none) #gender: gender,
      if (qrCodeUrl != $none) #qrCodeUrl: qrCodeUrl,
      if (status != null) #status: status,
      if (pass != null) #pass: pass,
    }),
  );
  @override
  ScanResponse $make(CopyWithData data) => ScanResponse(
    id: data.get(#id, or: $value.id),
    bookingDate: data.get(#bookingDate, or: $value.bookingDate),
    fullName: data.get(#fullName, or: $value.fullName),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    gender: data.get(#gender, or: $value.gender),
    qrCodeUrl: data.get(#qrCodeUrl, or: $value.qrCodeUrl),
    status: data.get(#status, or: $value.status),
    pass: data.get(#pass, or: $value.pass),
  );

  @override
  ScanResponseCopyWith<$R2, ScanResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanPassMapper extends ClassMapperBase<ScanPass> {
  ScanPassMapper._();

  static ScanPassMapper? _instance;
  static ScanPassMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanPassMapper._());
      ScanBookingExperienceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanPass';

  static String _$name(ScanPass v) => v.name;
  static const Field<ScanPass, String> _f$name = Field('name', _$name);
  static ScanBookingExperience? _$bookingExperience(ScanPass v) =>
      v.bookingExperience;
  static const Field<ScanPass, ScanBookingExperience> _f$bookingExperience =
      Field('bookingExperience', _$bookingExperience, opt: true);

  @override
  final MappableFields<ScanPass> fields = const {
    #name: _f$name,
    #bookingExperience: _f$bookingExperience,
  };

  static ScanPass _instantiate(DecodingData data) {
    return ScanPass(
      name: data.dec(_f$name),
      bookingExperience: data.dec(_f$bookingExperience),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanPass fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanPass>(map);
  }

  static ScanPass fromJson(String json) {
    return ensureInitialized().decodeJson<ScanPass>(json);
  }
}

mixin ScanPassMappable {
  String toJson() {
    return ScanPassMapper.ensureInitialized().encodeJson<ScanPass>(
      this as ScanPass,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanPassMapper.ensureInitialized().encodeMap<ScanPass>(
      this as ScanPass,
    );
  }

  ScanPassCopyWith<ScanPass, ScanPass, ScanPass> get copyWith =>
      _ScanPassCopyWithImpl<ScanPass, ScanPass>(
        this as ScanPass,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ScanPassMapper.ensureInitialized().stringifyValue(this as ScanPass);
  }

  @override
  bool operator ==(Object other) {
    return ScanPassMapper.ensureInitialized().equalsValue(
      this as ScanPass,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanPassMapper.ensureInitialized().hashValue(this as ScanPass);
  }
}

extension ScanPassValueCopy<$R, $Out> on ObjectCopyWith<$R, ScanPass, $Out> {
  ScanPassCopyWith<$R, ScanPass, $Out> get $asScanPass =>
      $base.as((v, t, t2) => _ScanPassCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanPassCopyWith<$R, $In extends ScanPass, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ScanBookingExperienceCopyWith<
    $R,
    ScanBookingExperience,
    ScanBookingExperience
  >?
  get bookingExperience;
  $R call({String? name, ScanBookingExperience? bookingExperience});
  ScanPassCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanPassCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanPass, $Out>
    implements ScanPassCopyWith<$R, ScanPass, $Out> {
  _ScanPassCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanPass> $mapper =
      ScanPassMapper.ensureInitialized();
  @override
  ScanBookingExperienceCopyWith<
    $R,
    ScanBookingExperience,
    ScanBookingExperience
  >?
  get bookingExperience => $value.bookingExperience?.copyWith.$chain(
    (v) => call(bookingExperience: v),
  );
  @override
  $R call({String? name, Object? bookingExperience = $none}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (bookingExperience != $none) #bookingExperience: bookingExperience,
    }),
  );
  @override
  ScanPass $make(CopyWithData data) => ScanPass(
    name: data.get(#name, or: $value.name),
    bookingExperience: data.get(
      #bookingExperience,
      or: $value.bookingExperience,
    ),
  );

  @override
  ScanPassCopyWith<$R2, ScanPass, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanPassCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanBookingExperienceMapper
    extends ClassMapperBase<ScanBookingExperience> {
  ScanBookingExperienceMapper._();

  static ScanBookingExperienceMapper? _instance;
  static ScanBookingExperienceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanBookingExperienceMapper._());
      ScanVendorMapper.ensureInitialized();
      ScanEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanBookingExperience';

  static ScanVendor? _$vendor(ScanBookingExperience v) => v.vendor;
  static const Field<ScanBookingExperience, ScanVendor> _f$vendor = Field(
    'vendor',
    _$vendor,
    opt: true,
  );
  static ScanEvent? _$event(ScanBookingExperience v) => v.event;
  static const Field<ScanBookingExperience, ScanEvent> _f$event = Field(
    'event',
    _$event,
    opt: true,
  );

  @override
  final MappableFields<ScanBookingExperience> fields = const {
    #vendor: _f$vendor,
    #event: _f$event,
  };

  static ScanBookingExperience _instantiate(DecodingData data) {
    return ScanBookingExperience(
      vendor: data.dec(_f$vendor),
      event: data.dec(_f$event),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanBookingExperience fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanBookingExperience>(map);
  }

  static ScanBookingExperience fromJson(String json) {
    return ensureInitialized().decodeJson<ScanBookingExperience>(json);
  }
}

mixin ScanBookingExperienceMappable {
  String toJson() {
    return ScanBookingExperienceMapper.ensureInitialized()
        .encodeJson<ScanBookingExperience>(this as ScanBookingExperience);
  }

  Map<String, dynamic> toMap() {
    return ScanBookingExperienceMapper.ensureInitialized()
        .encodeMap<ScanBookingExperience>(this as ScanBookingExperience);
  }

  ScanBookingExperienceCopyWith<
    ScanBookingExperience,
    ScanBookingExperience,
    ScanBookingExperience
  >
  get copyWith =>
      _ScanBookingExperienceCopyWithImpl<
        ScanBookingExperience,
        ScanBookingExperience
      >(this as ScanBookingExperience, $identity, $identity);
  @override
  String toString() {
    return ScanBookingExperienceMapper.ensureInitialized().stringifyValue(
      this as ScanBookingExperience,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanBookingExperienceMapper.ensureInitialized().equalsValue(
      this as ScanBookingExperience,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanBookingExperienceMapper.ensureInitialized().hashValue(
      this as ScanBookingExperience,
    );
  }
}

extension ScanBookingExperienceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanBookingExperience, $Out> {
  ScanBookingExperienceCopyWith<$R, ScanBookingExperience, $Out>
  get $asScanBookingExperience => $base.as(
    (v, t, t2) => _ScanBookingExperienceCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ScanBookingExperienceCopyWith<
  $R,
  $In extends ScanBookingExperience,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ScanVendorCopyWith<$R, ScanVendor, ScanVendor>? get vendor;
  ScanEventCopyWith<$R, ScanEvent, ScanEvent>? get event;
  $R call({ScanVendor? vendor, ScanEvent? event});
  ScanBookingExperienceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScanBookingExperienceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanBookingExperience, $Out>
    implements ScanBookingExperienceCopyWith<$R, ScanBookingExperience, $Out> {
  _ScanBookingExperienceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanBookingExperience> $mapper =
      ScanBookingExperienceMapper.ensureInitialized();
  @override
  ScanVendorCopyWith<$R, ScanVendor, ScanVendor>? get vendor =>
      $value.vendor?.copyWith.$chain((v) => call(vendor: v));
  @override
  ScanEventCopyWith<$R, ScanEvent, ScanEvent>? get event =>
      $value.event?.copyWith.$chain((v) => call(event: v));
  @override
  $R call({Object? vendor = $none, Object? event = $none}) => $apply(
    FieldCopyWithData({
      if (vendor != $none) #vendor: vendor,
      if (event != $none) #event: event,
    }),
  );
  @override
  ScanBookingExperience $make(CopyWithData data) => ScanBookingExperience(
    vendor: data.get(#vendor, or: $value.vendor),
    event: data.get(#event, or: $value.event),
  );

  @override
  ScanBookingExperienceCopyWith<$R2, ScanBookingExperience, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ScanBookingExperienceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanVendorMapper extends ClassMapperBase<ScanVendor> {
  ScanVendorMapper._();

  static ScanVendorMapper? _instance;
  static ScanVendorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanVendorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ScanVendor';

  static String _$name(ScanVendor v) => v.name;
  static const Field<ScanVendor, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<ScanVendor> fields = const {#name: _f$name};

  static ScanVendor _instantiate(DecodingData data) {
    return ScanVendor(name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static ScanVendor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanVendor>(map);
  }

  static ScanVendor fromJson(String json) {
    return ensureInitialized().decodeJson<ScanVendor>(json);
  }
}

mixin ScanVendorMappable {
  String toJson() {
    return ScanVendorMapper.ensureInitialized().encodeJson<ScanVendor>(
      this as ScanVendor,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanVendorMapper.ensureInitialized().encodeMap<ScanVendor>(
      this as ScanVendor,
    );
  }

  ScanVendorCopyWith<ScanVendor, ScanVendor, ScanVendor> get copyWith =>
      _ScanVendorCopyWithImpl<ScanVendor, ScanVendor>(
        this as ScanVendor,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ScanVendorMapper.ensureInitialized().stringifyValue(
      this as ScanVendor,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanVendorMapper.ensureInitialized().equalsValue(
      this as ScanVendor,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanVendorMapper.ensureInitialized().hashValue(this as ScanVendor);
  }
}

extension ScanVendorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanVendor, $Out> {
  ScanVendorCopyWith<$R, ScanVendor, $Out> get $asScanVendor =>
      $base.as((v, t, t2) => _ScanVendorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanVendorCopyWith<$R, $In extends ScanVendor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name});
  ScanVendorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanVendorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanVendor, $Out>
    implements ScanVendorCopyWith<$R, ScanVendor, $Out> {
  _ScanVendorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanVendor> $mapper =
      ScanVendorMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  ScanVendor $make(CopyWithData data) =>
      ScanVendor(name: data.get(#name, or: $value.name));

  @override
  ScanVendorCopyWith<$R2, ScanVendor, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanVendorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanEventMapper extends ClassMapperBase<ScanEvent> {
  ScanEventMapper._();

  static ScanEventMapper? _instance;
  static ScanEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanEventMapper._());
      LocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanEvent';

  static String _$name(ScanEvent v) => v.name;
  static const Field<ScanEvent, String> _f$name = Field('name', _$name);
  static List<String>? _$media(ScanEvent v) => v.media;
  static const Field<ScanEvent, List<String>> _f$media = Field(
    'media',
    _$media,
    opt: true,
  );
  static Location _$location(ScanEvent v) => v.location;
  static const Field<ScanEvent, Location> _f$location = Field(
    'location',
    _$location,
  );

  @override
  final MappableFields<ScanEvent> fields = const {
    #name: _f$name,
    #media: _f$media,
    #location: _f$location,
  };

  static ScanEvent _instantiate(DecodingData data) {
    return ScanEvent(
      name: data.dec(_f$name),
      media: data.dec(_f$media),
      location: data.dec(_f$location),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanEvent>(map);
  }

  static ScanEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ScanEvent>(json);
  }
}

mixin ScanEventMappable {
  String toJson() {
    return ScanEventMapper.ensureInitialized().encodeJson<ScanEvent>(
      this as ScanEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanEventMapper.ensureInitialized().encodeMap<ScanEvent>(
      this as ScanEvent,
    );
  }

  ScanEventCopyWith<ScanEvent, ScanEvent, ScanEvent> get copyWith =>
      _ScanEventCopyWithImpl<ScanEvent, ScanEvent>(
        this as ScanEvent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ScanEventMapper.ensureInitialized().stringifyValue(
      this as ScanEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanEventMapper.ensureInitialized().equalsValue(
      this as ScanEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanEventMapper.ensureInitialized().hashValue(this as ScanEvent);
  }
}

extension ScanEventValueCopy<$R, $Out> on ObjectCopyWith<$R, ScanEvent, $Out> {
  ScanEventCopyWith<$R, ScanEvent, $Out> get $asScanEvent =>
      $base.as((v, t, t2) => _ScanEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanEventCopyWith<$R, $In extends ScanEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get media;
  LocationCopyWith<$R, Location, Location> get location;
  $R call({String? name, List<String>? media, Location? location});
  ScanEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanEvent, $Out>
    implements ScanEventCopyWith<$R, ScanEvent, $Out> {
  _ScanEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanEvent> $mapper =
      ScanEventMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get media =>
      $value.media != null
      ? ListCopyWith(
          $value.media!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(media: v),
        )
      : null;
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  $R call({String? name, Object? media = $none, Location? location}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (media != $none) #media: media,
      if (location != null) #location: location,
    }),
  );
  @override
  ScanEvent $make(CopyWithData data) => ScanEvent(
    name: data.get(#name, or: $value.name),
    media: data.get(#media, or: $value.media),
    location: data.get(#location, or: $value.location),
  );

  @override
  ScanEventCopyWith<$R2, ScanEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

