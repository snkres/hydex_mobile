// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class BannerTypeMapper extends EnumMapper<BannerType> {
  BannerTypeMapper._();

  static BannerTypeMapper? _instance;
  static BannerTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BannerTypeMapper._());
    }
    return _instance!;
  }

  static BannerType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BannerType decode(dynamic value) {
    switch (value) {
      case 'FEATURED':
        return BannerType.featured;
      case 'PROMOTIONAL':
        return BannerType.promotional;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BannerType self) {
    switch (self) {
      case BannerType.featured:
        return 'FEATURED';
      case BannerType.promotional:
        return 'PROMOTIONAL';
    }
  }
}

extension BannerTypeMapperExtension on BannerType {
  dynamic toValue() {
    BannerTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BannerType>(this);
  }
}

class AssignmentStatusMapper extends EnumMapper<AssignmentStatus> {
  AssignmentStatusMapper._();

  static AssignmentStatusMapper? _instance;
  static AssignmentStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentStatusMapper._());
    }
    return _instance!;
  }

  static AssignmentStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssignmentStatus decode(dynamic value) {
    switch (value) {
      case 'VENDOR':
        return AssignmentStatus.vendor;
      case 'EVENT':
        return AssignmentStatus.event;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssignmentStatus self) {
    switch (self) {
      case AssignmentStatus.vendor:
        return 'VENDOR';
      case AssignmentStatus.event:
        return 'EVENT';
    }
  }
}

extension AssignmentStatusMapperExtension on AssignmentStatus {
  dynamic toValue() {
    AssignmentStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssignmentStatus>(this);
  }
}

class PriceTypeMapper extends EnumMapper<PriceType> {
  PriceTypeMapper._();

  static PriceTypeMapper? _instance;
  static PriceTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PriceTypeMapper._());
    }
    return _instance!;
  }

  static PriceType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PriceType decode(dynamic value) {
    switch (value) {
      case 'CASUAL':
        return PriceType.casual;
      case 'MODERATE':
        return PriceType.moderate;
      case 'PREMIUM':
        return PriceType.premium;
      case 'LUXURY':
        return PriceType.luxury;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PriceType self) {
    switch (self) {
      case PriceType.casual:
        return 'CASUAL';
      case PriceType.moderate:
        return 'MODERATE';
      case PriceType.premium:
        return 'PREMIUM';
      case PriceType.luxury:
        return 'LUXURY';
    }
  }
}

extension PriceTypeMapperExtension on PriceType {
  dynamic toValue() {
    PriceTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PriceType>(this);
  }
}

class BannerMapper extends ClassMapperBase<Banner> {
  BannerMapper._();

  static BannerMapper? _instance;
  static BannerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BannerMapper._());
      BannerTypeMapper.ensureInitialized();
      AssignmentMapper.ensureInitialized();
      EventCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Banner';

  static String _$id(Banner v) => v.id;
  static const Field<Banner, String> _f$id = Field('id', _$id);
  static BannerType _$type(Banner v) => v.type;
  static const Field<Banner, BannerType> _f$type = Field('type', _$type);
  static String _$headline(Banner v) => v.headline;
  static const Field<Banner, String> _f$headline = Field(
    'headline',
    _$headline,
  );
  static String _$subtitle(Banner v) => v.subtitle;
  static const Field<Banner, String> _f$subtitle = Field(
    'subtitle',
    _$subtitle,
  );
  static String? _$image(Banner v) => v.image;
  static const Field<Banner, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static String? _$video(Banner v) => v.video;
  static const Field<Banner, String> _f$video = Field(
    'video',
    _$video,
    opt: true,
  );
  static Assignment _$assignment(Banner v) => v.assignment;
  static const Field<Banner, Assignment> _f$assignment = Field(
    'assignment',
    _$assignment,
  );
  static EventCategory? _$category(Banner v) => v.category;
  static const Field<Banner, EventCategory> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );

  @override
  final MappableFields<Banner> fields = const {
    #id: _f$id,
    #type: _f$type,
    #headline: _f$headline,
    #subtitle: _f$subtitle,
    #image: _f$image,
    #video: _f$video,
    #assignment: _f$assignment,
    #category: _f$category,
  };

  static Banner _instantiate(DecodingData data) {
    return Banner(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      headline: data.dec(_f$headline),
      subtitle: data.dec(_f$subtitle),
      image: data.dec(_f$image),
      video: data.dec(_f$video),
      assignment: data.dec(_f$assignment),
      category: data.dec(_f$category),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Banner fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Banner>(map);
  }

  static Banner fromJson(String json) {
    return ensureInitialized().decodeJson<Banner>(json);
  }
}

mixin BannerMappable {
  String toJson() {
    return BannerMapper.ensureInitialized().encodeJson<Banner>(this as Banner);
  }

  Map<String, dynamic> toMap() {
    return BannerMapper.ensureInitialized().encodeMap<Banner>(this as Banner);
  }

  BannerCopyWith<Banner, Banner, Banner> get copyWith =>
      _BannerCopyWithImpl<Banner, Banner>(this as Banner, $identity, $identity);
  @override
  String toString() {
    return BannerMapper.ensureInitialized().stringifyValue(this as Banner);
  }

  @override
  bool operator ==(Object other) {
    return BannerMapper.ensureInitialized().equalsValue(this as Banner, other);
  }

  @override
  int get hashCode {
    return BannerMapper.ensureInitialized().hashValue(this as Banner);
  }
}

extension BannerValueCopy<$R, $Out> on ObjectCopyWith<$R, Banner, $Out> {
  BannerCopyWith<$R, Banner, $Out> get $asBanner =>
      $base.as((v, t, t2) => _BannerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BannerCopyWith<$R, $In extends Banner, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssignmentCopyWith<$R, Assignment, Assignment> get assignment;
  EventCategoryCopyWith<$R, EventCategory, EventCategory>? get category;
  $R call({
    String? id,
    BannerType? type,
    String? headline,
    String? subtitle,
    String? image,
    String? video,
    Assignment? assignment,
    EventCategory? category,
  });
  BannerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BannerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Banner, $Out>
    implements BannerCopyWith<$R, Banner, $Out> {
  _BannerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Banner> $mapper = BannerMapper.ensureInitialized();
  @override
  AssignmentCopyWith<$R, Assignment, Assignment> get assignment =>
      $value.assignment.copyWith.$chain((v) => call(assignment: v));
  @override
  EventCategoryCopyWith<$R, EventCategory, EventCategory>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  $R call({
    String? id,
    BannerType? type,
    String? headline,
    String? subtitle,
    Object? image = $none,
    Object? video = $none,
    Assignment? assignment,
    Object? category = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (headline != null) #headline: headline,
      if (subtitle != null) #subtitle: subtitle,
      if (image != $none) #image: image,
      if (video != $none) #video: video,
      if (assignment != null) #assignment: assignment,
      if (category != $none) #category: category,
    }),
  );
  @override
  Banner $make(CopyWithData data) => Banner(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    headline: data.get(#headline, or: $value.headline),
    subtitle: data.get(#subtitle, or: $value.subtitle),
    image: data.get(#image, or: $value.image),
    video: data.get(#video, or: $value.video),
    assignment: data.get(#assignment, or: $value.assignment),
    category: data.get(#category, or: $value.category),
  );

  @override
  BannerCopyWith<$R2, Banner, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BannerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AssignmentMapper extends ClassMapperBase<Assignment> {
  AssignmentMapper._();

  static AssignmentMapper? _instance;
  static AssignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentMapper._());
      AssignmentStatusMapper.ensureInitialized();
      AssignmentVendorMapper.ensureInitialized();
      AssignmentEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Assignment';

  static String _$id(Assignment v) => v.id;
  static const Field<Assignment, String> _f$id = Field('id', _$id);
  static AssignmentStatus _$targetType(Assignment v) => v.targetType;
  static const Field<Assignment, AssignmentStatus> _f$targetType = Field(
    'targetType',
    _$targetType,
  );
  static AssignmentVendor? _$vendor(Assignment v) => v.vendor;
  static const Field<Assignment, AssignmentVendor> _f$vendor = Field(
    'vendor',
    _$vendor,
    opt: true,
  );
  static AssignmentEvent? _$event(Assignment v) => v.event;
  static const Field<Assignment, AssignmentEvent> _f$event = Field(
    'event',
    _$event,
    opt: true,
  );

  @override
  final MappableFields<Assignment> fields = const {
    #id: _f$id,
    #targetType: _f$targetType,
    #vendor: _f$vendor,
    #event: _f$event,
  };

  static Assignment _instantiate(DecodingData data) {
    return Assignment(
      id: data.dec(_f$id),
      targetType: data.dec(_f$targetType),
      vendor: data.dec(_f$vendor),
      event: data.dec(_f$event),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Assignment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Assignment>(map);
  }

  static Assignment fromJson(String json) {
    return ensureInitialized().decodeJson<Assignment>(json);
  }
}

mixin AssignmentMappable {
  String toJson() {
    return AssignmentMapper.ensureInitialized().encodeJson<Assignment>(
      this as Assignment,
    );
  }

  Map<String, dynamic> toMap() {
    return AssignmentMapper.ensureInitialized().encodeMap<Assignment>(
      this as Assignment,
    );
  }

  AssignmentCopyWith<Assignment, Assignment, Assignment> get copyWith =>
      _AssignmentCopyWithImpl<Assignment, Assignment>(
        this as Assignment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentMapper.ensureInitialized().stringifyValue(
      this as Assignment,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentMapper.ensureInitialized().equalsValue(
      this as Assignment,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentMapper.ensureInitialized().hashValue(this as Assignment);
  }
}

extension AssignmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Assignment, $Out> {
  AssignmentCopyWith<$R, Assignment, $Out> get $asAssignment =>
      $base.as((v, t, t2) => _AssignmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentCopyWith<$R, $In extends Assignment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssignmentVendorCopyWith<$R, AssignmentVendor, AssignmentVendor>? get vendor;
  AssignmentEventCopyWith<$R, AssignmentEvent, AssignmentEvent>? get event;
  $R call({
    String? id,
    AssignmentStatus? targetType,
    AssignmentVendor? vendor,
    AssignmentEvent? event,
  });
  AssignmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssignmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Assignment, $Out>
    implements AssignmentCopyWith<$R, Assignment, $Out> {
  _AssignmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Assignment> $mapper =
      AssignmentMapper.ensureInitialized();
  @override
  AssignmentVendorCopyWith<$R, AssignmentVendor, AssignmentVendor>?
  get vendor => $value.vendor?.copyWith.$chain((v) => call(vendor: v));
  @override
  AssignmentEventCopyWith<$R, AssignmentEvent, AssignmentEvent>? get event =>
      $value.event?.copyWith.$chain((v) => call(event: v));
  @override
  $R call({
    String? id,
    AssignmentStatus? targetType,
    Object? vendor = $none,
    Object? event = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (targetType != null) #targetType: targetType,
      if (vendor != $none) #vendor: vendor,
      if (event != $none) #event: event,
    }),
  );
  @override
  Assignment $make(CopyWithData data) => Assignment(
    id: data.get(#id, or: $value.id),
    targetType: data.get(#targetType, or: $value.targetType),
    vendor: data.get(#vendor, or: $value.vendor),
    event: data.get(#event, or: $value.event),
  );

  @override
  AssignmentCopyWith<$R2, Assignment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AssignmentVendorMapper extends ClassMapperBase<AssignmentVendor> {
  AssignmentVendorMapper._();

  static AssignmentVendorMapper? _instance;
  static AssignmentVendorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentVendorMapper._());
      PriceTypeMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
      OperatingHoursMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssignmentVendor';

  static String _$id(AssignmentVendor v) => v.id;
  static const Field<AssignmentVendor, String> _f$id = Field('id', _$id);
  static PriceType? _$priceType(AssignmentVendor v) => v.priceType;
  static const Field<AssignmentVendor, PriceType> _f$priceType = Field(
    'priceType',
    _$priceType,
    opt: true,
  );
  static String _$name(AssignmentVendor v) => v.name;
  static const Field<AssignmentVendor, String> _f$name = Field('name', _$name);
  static String _$description(AssignmentVendor v) => v.description;
  static const Field<AssignmentVendor, String> _f$description = Field(
    'description',
    _$description,
  );
  static List<String> _$media(AssignmentVendor v) => v.media;
  static const Field<AssignmentVendor, List<String>> _f$media = Field(
    'media',
    _$media,
  );
  static Location _$location(AssignmentVendor v) => v.location;
  static const Field<AssignmentVendor, Location> _f$location = Field(
    'location',
    _$location,
  );
  static Map<String, OperatingHours> _$operatingHours(AssignmentVendor v) =>
      v.operatingHours;
  static const Field<AssignmentVendor, Map<String, OperatingHours>>
  _f$operatingHours = Field('operatingHours', _$operatingHours);

  @override
  final MappableFields<AssignmentVendor> fields = const {
    #id: _f$id,
    #priceType: _f$priceType,
    #name: _f$name,
    #description: _f$description,
    #media: _f$media,
    #location: _f$location,
    #operatingHours: _f$operatingHours,
  };

  static AssignmentVendor _instantiate(DecodingData data) {
    return AssignmentVendor(
      id: data.dec(_f$id),
      priceType: data.dec(_f$priceType),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      media: data.dec(_f$media),
      location: data.dec(_f$location),
      operatingHours: data.dec(_f$operatingHours),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssignmentVendor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssignmentVendor>(map);
  }

  static AssignmentVendor fromJson(String json) {
    return ensureInitialized().decodeJson<AssignmentVendor>(json);
  }
}

mixin AssignmentVendorMappable {
  String toJson() {
    return AssignmentVendorMapper.ensureInitialized()
        .encodeJson<AssignmentVendor>(this as AssignmentVendor);
  }

  Map<String, dynamic> toMap() {
    return AssignmentVendorMapper.ensureInitialized()
        .encodeMap<AssignmentVendor>(this as AssignmentVendor);
  }

  AssignmentVendorCopyWith<AssignmentVendor, AssignmentVendor, AssignmentVendor>
  get copyWith =>
      _AssignmentVendorCopyWithImpl<AssignmentVendor, AssignmentVendor>(
        this as AssignmentVendor,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentVendorMapper.ensureInitialized().stringifyValue(
      this as AssignmentVendor,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentVendorMapper.ensureInitialized().equalsValue(
      this as AssignmentVendor,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentVendorMapper.ensureInitialized().hashValue(
      this as AssignmentVendor,
    );
  }
}

extension AssignmentVendorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssignmentVendor, $Out> {
  AssignmentVendorCopyWith<$R, AssignmentVendor, $Out>
  get $asAssignmentVendor =>
      $base.as((v, t, t2) => _AssignmentVendorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentVendorCopyWith<$R, $In extends AssignmentVendor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media;
  LocationCopyWith<$R, Location, Location> get location;
  MapCopyWith<
    $R,
    String,
    OperatingHours,
    OperatingHoursCopyWith<$R, OperatingHours, OperatingHours>
  >
  get operatingHours;
  $R call({
    String? id,
    PriceType? priceType,
    String? name,
    String? description,
    List<String>? media,
    Location? location,
    Map<String, OperatingHours>? operatingHours,
  });
  AssignmentVendorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssignmentVendorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssignmentVendor, $Out>
    implements AssignmentVendorCopyWith<$R, AssignmentVendor, $Out> {
  _AssignmentVendorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssignmentVendor> $mapper =
      AssignmentVendorMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media =>
      ListCopyWith(
        $value.media,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(media: v),
      );
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  MapCopyWith<
    $R,
    String,
    OperatingHours,
    OperatingHoursCopyWith<$R, OperatingHours, OperatingHours>
  >
  get operatingHours => MapCopyWith(
    $value.operatingHours,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(operatingHours: v),
  );
  @override
  $R call({
    String? id,
    Object? priceType = $none,
    String? name,
    String? description,
    List<String>? media,
    Location? location,
    Map<String, OperatingHours>? operatingHours,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (priceType != $none) #priceType: priceType,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (media != null) #media: media,
      if (location != null) #location: location,
      if (operatingHours != null) #operatingHours: operatingHours,
    }),
  );
  @override
  AssignmentVendor $make(CopyWithData data) => AssignmentVendor(
    id: data.get(#id, or: $value.id),
    priceType: data.get(#priceType, or: $value.priceType),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    media: data.get(#media, or: $value.media),
    location: data.get(#location, or: $value.location),
    operatingHours: data.get(#operatingHours, or: $value.operatingHours),
  );

  @override
  AssignmentVendorCopyWith<$R2, AssignmentVendor, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentVendorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OperatingHoursMapper extends ClassMapperBase<OperatingHours> {
  OperatingHoursMapper._();

  static OperatingHoursMapper? _instance;
  static OperatingHoursMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OperatingHoursMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OperatingHours';

  static String _$open(OperatingHours v) => v.open;
  static const Field<OperatingHours, String> _f$open = Field('open', _$open);
  static String _$close(OperatingHours v) => v.close;
  static const Field<OperatingHours, String> _f$close = Field('close', _$close);

  @override
  final MappableFields<OperatingHours> fields = const {
    #open: _f$open,
    #close: _f$close,
  };

  static OperatingHours _instantiate(DecodingData data) {
    return OperatingHours(open: data.dec(_f$open), close: data.dec(_f$close));
  }

  @override
  final Function instantiate = _instantiate;

  static OperatingHours fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OperatingHours>(map);
  }

  static OperatingHours fromJson(String json) {
    return ensureInitialized().decodeJson<OperatingHours>(json);
  }
}

mixin OperatingHoursMappable {
  String toJson() {
    return OperatingHoursMapper.ensureInitialized().encodeJson<OperatingHours>(
      this as OperatingHours,
    );
  }

  Map<String, dynamic> toMap() {
    return OperatingHoursMapper.ensureInitialized().encodeMap<OperatingHours>(
      this as OperatingHours,
    );
  }

  OperatingHoursCopyWith<OperatingHours, OperatingHours, OperatingHours>
  get copyWith => _OperatingHoursCopyWithImpl<OperatingHours, OperatingHours>(
    this as OperatingHours,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return OperatingHoursMapper.ensureInitialized().stringifyValue(
      this as OperatingHours,
    );
  }

  @override
  bool operator ==(Object other) {
    return OperatingHoursMapper.ensureInitialized().equalsValue(
      this as OperatingHours,
      other,
    );
  }

  @override
  int get hashCode {
    return OperatingHoursMapper.ensureInitialized().hashValue(
      this as OperatingHours,
    );
  }
}

extension OperatingHoursValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OperatingHours, $Out> {
  OperatingHoursCopyWith<$R, OperatingHours, $Out> get $asOperatingHours =>
      $base.as((v, t, t2) => _OperatingHoursCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OperatingHoursCopyWith<$R, $In extends OperatingHours, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? open, String? close});
  OperatingHoursCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OperatingHoursCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OperatingHours, $Out>
    implements OperatingHoursCopyWith<$R, OperatingHours, $Out> {
  _OperatingHoursCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OperatingHours> $mapper =
      OperatingHoursMapper.ensureInitialized();
  @override
  $R call({String? open, String? close}) => $apply(
    FieldCopyWithData({
      if (open != null) #open: open,
      if (close != null) #close: close,
    }),
  );
  @override
  OperatingHours $make(CopyWithData data) => OperatingHours(
    open: data.get(#open, or: $value.open),
    close: data.get(#close, or: $value.close),
  );

  @override
  OperatingHoursCopyWith<$R2, OperatingHours, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OperatingHoursCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AssignmentEventMapper extends ClassMapperBase<AssignmentEvent> {
  AssignmentEventMapper._();

  static AssignmentEventMapper? _instance;
  static AssignmentEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentEventMapper._());
      PriceTypeMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssignmentEvent';

  static String _$id(AssignmentEvent v) => v.id;
  static const Field<AssignmentEvent, String> _f$id = Field('id', _$id);
  static PriceType? _$priceType(AssignmentEvent v) => v.priceType;
  static const Field<AssignmentEvent, PriceType> _f$priceType = Field(
    'priceType',
    _$priceType,
    opt: true,
  );
  static String _$name(AssignmentEvent v) => v.name;
  static const Field<AssignmentEvent, String> _f$name = Field('name', _$name);
  static String _$description(AssignmentEvent v) => v.description;
  static const Field<AssignmentEvent, String> _f$description = Field(
    'description',
    _$description,
  );
  static List<String> _$media(AssignmentEvent v) => v.media;
  static const Field<AssignmentEvent, List<String>> _f$media = Field(
    'media',
    _$media,
  );
  static Location _$location(AssignmentEvent v) => v.location;
  static const Field<AssignmentEvent, Location> _f$location = Field(
    'location',
    _$location,
  );
  static DateTime _$startTime(AssignmentEvent v) => v.startTime;
  static const Field<AssignmentEvent, DateTime> _f$startTime = Field(
    'startTime',
    _$startTime,
  );
  static DateTime _$endTime(AssignmentEvent v) => v.endTime;
  static const Field<AssignmentEvent, DateTime> _f$endTime = Field(
    'endTime',
    _$endTime,
  );

  @override
  final MappableFields<AssignmentEvent> fields = const {
    #id: _f$id,
    #priceType: _f$priceType,
    #name: _f$name,
    #description: _f$description,
    #media: _f$media,
    #location: _f$location,
    #startTime: _f$startTime,
    #endTime: _f$endTime,
  };

  static AssignmentEvent _instantiate(DecodingData data) {
    return AssignmentEvent(
      id: data.dec(_f$id),
      priceType: data.dec(_f$priceType),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      media: data.dec(_f$media),
      location: data.dec(_f$location),
      startTime: data.dec(_f$startTime),
      endTime: data.dec(_f$endTime),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssignmentEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssignmentEvent>(map);
  }

  static AssignmentEvent fromJson(String json) {
    return ensureInitialized().decodeJson<AssignmentEvent>(json);
  }
}

mixin AssignmentEventMappable {
  String toJson() {
    return AssignmentEventMapper.ensureInitialized()
        .encodeJson<AssignmentEvent>(this as AssignmentEvent);
  }

  Map<String, dynamic> toMap() {
    return AssignmentEventMapper.ensureInitialized().encodeMap<AssignmentEvent>(
      this as AssignmentEvent,
    );
  }

  AssignmentEventCopyWith<AssignmentEvent, AssignmentEvent, AssignmentEvent>
  get copyWith =>
      _AssignmentEventCopyWithImpl<AssignmentEvent, AssignmentEvent>(
        this as AssignmentEvent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentEventMapper.ensureInitialized().stringifyValue(
      this as AssignmentEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentEventMapper.ensureInitialized().equalsValue(
      this as AssignmentEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentEventMapper.ensureInitialized().hashValue(
      this as AssignmentEvent,
    );
  }
}

extension AssignmentEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssignmentEvent, $Out> {
  AssignmentEventCopyWith<$R, AssignmentEvent, $Out> get $asAssignmentEvent =>
      $base.as((v, t, t2) => _AssignmentEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentEventCopyWith<$R, $In extends AssignmentEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media;
  LocationCopyWith<$R, Location, Location> get location;
  $R call({
    String? id,
    PriceType? priceType,
    String? name,
    String? description,
    List<String>? media,
    Location? location,
    DateTime? startTime,
    DateTime? endTime,
  });
  AssignmentEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssignmentEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssignmentEvent, $Out>
    implements AssignmentEventCopyWith<$R, AssignmentEvent, $Out> {
  _AssignmentEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssignmentEvent> $mapper =
      AssignmentEventMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media =>
      ListCopyWith(
        $value.media,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(media: v),
      );
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  $R call({
    String? id,
    Object? priceType = $none,
    String? name,
    String? description,
    List<String>? media,
    Location? location,
    DateTime? startTime,
    DateTime? endTime,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (priceType != $none) #priceType: priceType,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (media != null) #media: media,
      if (location != null) #location: location,
      if (startTime != null) #startTime: startTime,
      if (endTime != null) #endTime: endTime,
    }),
  );
  @override
  AssignmentEvent $make(CopyWithData data) => AssignmentEvent(
    id: data.get(#id, or: $value.id),
    priceType: data.get(#priceType, or: $value.priceType),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    media: data.get(#media, or: $value.media),
    location: data.get(#location, or: $value.location),
    startTime: data.get(#startTime, or: $value.startTime),
    endTime: data.get(#endTime, or: $value.endTime),
  );

  @override
  AssignmentEventCopyWith<$R2, AssignmentEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailMapper extends ClassMapperBase<Detail> {
  DetailMapper._();

  static DetailMapper? _instance;
  static DetailMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Detail';

  static String _$image(Detail v) => v.image;
  static const Field<Detail, String> _f$image = Field('image', _$image);
  static String _$title(Detail v) => v.title;
  static const Field<Detail, String> _f$title = Field('title', _$title);

  @override
  final MappableFields<Detail> fields = const {
    #image: _f$image,
    #title: _f$title,
  };

  static Detail _instantiate(DecodingData data) {
    return Detail(image: data.dec(_f$image), title: data.dec(_f$title));
  }

  @override
  final Function instantiate = _instantiate;

  static Detail fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Detail>(map);
  }

  static Detail fromJson(String json) {
    return ensureInitialized().decodeJson<Detail>(json);
  }
}

mixin DetailMappable {
  String toJson() {
    return DetailMapper.ensureInitialized().encodeJson<Detail>(this as Detail);
  }

  Map<String, dynamic> toMap() {
    return DetailMapper.ensureInitialized().encodeMap<Detail>(this as Detail);
  }

  DetailCopyWith<Detail, Detail, Detail> get copyWith =>
      _DetailCopyWithImpl<Detail, Detail>(this as Detail, $identity, $identity);
  @override
  String toString() {
    return DetailMapper.ensureInitialized().stringifyValue(this as Detail);
  }

  @override
  bool operator ==(Object other) {
    return DetailMapper.ensureInitialized().equalsValue(this as Detail, other);
  }

  @override
  int get hashCode {
    return DetailMapper.ensureInitialized().hashValue(this as Detail);
  }
}

extension DetailValueCopy<$R, $Out> on ObjectCopyWith<$R, Detail, $Out> {
  DetailCopyWith<$R, Detail, $Out> get $asDetail =>
      $base.as((v, t, t2) => _DetailCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailCopyWith<$R, $In extends Detail, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? image, String? title});
  DetailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Detail, $Out>
    implements DetailCopyWith<$R, Detail, $Out> {
  _DetailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Detail> $mapper = DetailMapper.ensureInitialized();
  @override
  $R call({String? image, String? title}) => $apply(
    FieldCopyWithData({
      if (image != null) #image: image,
      if (title != null) #title: title,
    }),
  );
  @override
  Detail $make(CopyWithData data) => Detail(
    image: data.get(#image, or: $value.image),
    title: data.get(#title, or: $value.title),
  );

  @override
  DetailCopyWith<$R2, Detail, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DetailCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ExperiencesMapper extends ClassMapperBase<Experiences> {
  ExperiencesMapper._();

  static ExperiencesMapper? _instance;
  static ExperiencesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExperiencesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Experiences';

  static String _$description(Experiences v) => v.description;
  static const Field<Experiences, String> _f$description = Field(
    'description',
    _$description,
  );
  static String? _$title(Experiences v) => v.title;
  static const Field<Experiences, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );

  @override
  final MappableFields<Experiences> fields = const {
    #description: _f$description,
    #title: _f$title,
  };

  static Experiences _instantiate(DecodingData data) {
    return Experiences(
      description: data.dec(_f$description),
      title: data.dec(_f$title),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Experiences fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Experiences>(map);
  }

  static Experiences fromJson(String json) {
    return ensureInitialized().decodeJson<Experiences>(json);
  }
}

mixin ExperiencesMappable {
  String toJson() {
    return ExperiencesMapper.ensureInitialized().encodeJson<Experiences>(
      this as Experiences,
    );
  }

  Map<String, dynamic> toMap() {
    return ExperiencesMapper.ensureInitialized().encodeMap<Experiences>(
      this as Experiences,
    );
  }

  ExperiencesCopyWith<Experiences, Experiences, Experiences> get copyWith =>
      _ExperiencesCopyWithImpl<Experiences, Experiences>(
        this as Experiences,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ExperiencesMapper.ensureInitialized().stringifyValue(
      this as Experiences,
    );
  }

  @override
  bool operator ==(Object other) {
    return ExperiencesMapper.ensureInitialized().equalsValue(
      this as Experiences,
      other,
    );
  }

  @override
  int get hashCode {
    return ExperiencesMapper.ensureInitialized().hashValue(this as Experiences);
  }
}

extension ExperiencesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Experiences, $Out> {
  ExperiencesCopyWith<$R, Experiences, $Out> get $asExperiences =>
      $base.as((v, t, t2) => _ExperiencesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExperiencesCopyWith<$R, $In extends Experiences, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? description, String? title});
  ExperiencesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExperiencesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Experiences, $Out>
    implements ExperiencesCopyWith<$R, Experiences, $Out> {
  _ExperiencesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Experiences> $mapper =
      ExperiencesMapper.ensureInitialized();
  @override
  $R call({String? description, Object? title = $none}) => $apply(
    FieldCopyWithData({
      if (description != null) #description: description,
      if (title != $none) #title: title,
    }),
  );
  @override
  Experiences $make(CopyWithData data) => Experiences(
    description: data.get(#description, or: $value.description),
    title: data.get(#title, or: $value.title),
  );

  @override
  ExperiencesCopyWith<$R2, Experiences, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ExperiencesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CategoryNoDescMapper extends ClassMapperBase<CategoryNoDesc> {
  CategoryNoDescMapper._();

  static CategoryNoDescMapper? _instance;
  static CategoryNoDescMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryNoDescMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CategoryNoDesc';

  static String _$id(CategoryNoDesc v) => v.id;
  static const Field<CategoryNoDesc, String> _f$id = Field('id', _$id);
  static String _$name(CategoryNoDesc v) => v.name;
  static const Field<CategoryNoDesc, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<CategoryNoDesc> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static CategoryNoDesc _instantiate(DecodingData data) {
    return CategoryNoDesc(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static CategoryNoDesc fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CategoryNoDesc>(map);
  }

  static CategoryNoDesc fromJson(String json) {
    return ensureInitialized().decodeJson<CategoryNoDesc>(json);
  }
}

mixin CategoryNoDescMappable {
  String toJson() {
    return CategoryNoDescMapper.ensureInitialized().encodeJson<CategoryNoDesc>(
      this as CategoryNoDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return CategoryNoDescMapper.ensureInitialized().encodeMap<CategoryNoDesc>(
      this as CategoryNoDesc,
    );
  }

  CategoryNoDescCopyWith<CategoryNoDesc, CategoryNoDesc, CategoryNoDesc>
  get copyWith => _CategoryNoDescCopyWithImpl<CategoryNoDesc, CategoryNoDesc>(
    this as CategoryNoDesc,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CategoryNoDescMapper.ensureInitialized().stringifyValue(
      this as CategoryNoDesc,
    );
  }

  @override
  bool operator ==(Object other) {
    return CategoryNoDescMapper.ensureInitialized().equalsValue(
      this as CategoryNoDesc,
      other,
    );
  }

  @override
  int get hashCode {
    return CategoryNoDescMapper.ensureInitialized().hashValue(
      this as CategoryNoDesc,
    );
  }
}

extension CategoryNoDescValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CategoryNoDesc, $Out> {
  CategoryNoDescCopyWith<$R, CategoryNoDesc, $Out> get $asCategoryNoDesc =>
      $base.as((v, t, t2) => _CategoryNoDescCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryNoDescCopyWith<$R, $In extends CategoryNoDesc, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  CategoryNoDescCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CategoryNoDescCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CategoryNoDesc, $Out>
    implements CategoryNoDescCopyWith<$R, CategoryNoDesc, $Out> {
  _CategoryNoDescCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CategoryNoDesc> $mapper =
      CategoryNoDescMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  CategoryNoDesc $make(CopyWithData data) => CategoryNoDesc(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  CategoryNoDescCopyWith<$R2, CategoryNoDesc, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CategoryNoDescCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
      LocationMapper.ensureInitialized();
      DetailMapper.ensureInitialized();
      PriceTypeMapper.ensureInitialized();
      CategoryNoDescMapper.ensureInitialized();
      ExperiencesMapper.ensureInitialized();
      VendorMapper.ensureInitialized();
      BookingExperienceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Event';

  static String _$id(Event v) => v.id;
  static const Field<Event, String> _f$id = Field('id', _$id);
  static String _$name(Event v) => v.name;
  static const Field<Event, String> _f$name = Field('name', _$name);
  static String _$description(Event v) => v.description;
  static const Field<Event, String> _f$description = Field(
    'description',
    _$description,
  );
  static DateTime _$startTime(Event v) => v.startTime;
  static const Field<Event, DateTime> _f$startTime = Field(
    'startTime',
    _$startTime,
  );
  static DateTime _$endTime(Event v) => v.endTime;
  static const Field<Event, DateTime> _f$endTime = Field('endTime', _$endTime);
  static List<String> _$media(Event v) => v.media;
  static const Field<Event, List<String>> _f$media = Field('media', _$media);
  static Location _$location(Event v) => v.location;
  static const Field<Event, Location> _f$location = Field(
    'location',
    _$location,
  );
  static List<Detail> _$details(Event v) => v.details;
  static const Field<Event, List<Detail>> _f$details = Field(
    'details',
    _$details,
  );
  static PriceType? _$priceType(Event v) => v.priceType;
  static const Field<Event, PriceType> _f$priceType = Field(
    'priceType',
    _$priceType,
    opt: true,
  );
  static List<String> _$tags(Event v) => v.tags;
  static const Field<Event, List<String>> _f$tags = Field('tags', _$tags);
  static CategoryNoDesc? _$category(Event v) => v.category;
  static const Field<Event, CategoryNoDesc> _f$category = Field(
    'category',
    _$category,
  );
  static List<Experiences> _$experiences(Event v) => v.experiences;
  static const Field<Event, List<Experiences>> _f$experiences = Field(
    'experiences',
    _$experiences,
  );
  static Vendor _$vendor(Event v) => v.vendor;
  static const Field<Event, Vendor> _f$vendor = Field('vendor', _$vendor);
  static DateTime _$createdAt(Event v) => v.createdAt;
  static const Field<Event, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static List<String>? _$thingsToKnow(Event v) => v.thingsToKnow;
  static const Field<Event, List<String>> _f$thingsToKnow = Field(
    'thingsToKnow',
    _$thingsToKnow,
    opt: true,
  );
  static BookingExperience? _$bookingExperience(Event v) => v.bookingExperience;
  static const Field<Event, BookingExperience> _f$bookingExperience = Field(
    'bookingExperience',
    _$bookingExperience,
    opt: true,
  );
  static bool _$isFavorited(Event v) => v.isFavorited;
  static const Field<Event, bool> _f$isFavorited = Field(
    'isFavorited',
    _$isFavorited,
    opt: true,
    def: false,
  );
  static String? _$detailsTitle(Event v) => v.detailsTitle;
  static const Field<Event, String> _f$detailsTitle = Field(
    'detailsTitle',
    _$detailsTitle,
    opt: true,
  );
  static String? _$termsAndConditions(Event v) => v.termsAndConditions;
  static const Field<Event, String> _f$termsAndConditions = Field(
    'termsAndConditions',
    _$termsAndConditions,
    opt: true,
  );

  @override
  final MappableFields<Event> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #startTime: _f$startTime,
    #endTime: _f$endTime,
    #media: _f$media,
    #location: _f$location,
    #details: _f$details,
    #priceType: _f$priceType,
    #tags: _f$tags,
    #category: _f$category,
    #experiences: _f$experiences,
    #vendor: _f$vendor,
    #createdAt: _f$createdAt,
    #thingsToKnow: _f$thingsToKnow,
    #bookingExperience: _f$bookingExperience,
    #isFavorited: _f$isFavorited,
    #detailsTitle: _f$detailsTitle,
    #termsAndConditions: _f$termsAndConditions,
  };

  static Event _instantiate(DecodingData data) {
    return Event(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      startTime: data.dec(_f$startTime),
      endTime: data.dec(_f$endTime),
      media: data.dec(_f$media),
      location: data.dec(_f$location),
      details: data.dec(_f$details),
      priceType: data.dec(_f$priceType),
      tags: data.dec(_f$tags),
      category: data.dec(_f$category),
      experiences: data.dec(_f$experiences),
      vendor: data.dec(_f$vendor),
      createdAt: data.dec(_f$createdAt),
      thingsToKnow: data.dec(_f$thingsToKnow),
      bookingExperience: data.dec(_f$bookingExperience),
      isFavorited: data.dec(_f$isFavorited),
      detailsTitle: data.dec(_f$detailsTitle),
      termsAndConditions: data.dec(_f$termsAndConditions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Event fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Event>(map);
  }

  static Event fromJson(String json) {
    return ensureInitialized().decodeJson<Event>(json);
  }
}

mixin EventMappable {
  String toJson() {
    return EventMapper.ensureInitialized().encodeJson<Event>(this as Event);
  }

  Map<String, dynamic> toMap() {
    return EventMapper.ensureInitialized().encodeMap<Event>(this as Event);
  }

  EventCopyWith<Event, Event, Event> get copyWith =>
      _EventCopyWithImpl<Event, Event>(this as Event, $identity, $identity);
  @override
  String toString() {
    return EventMapper.ensureInitialized().stringifyValue(this as Event);
  }

  @override
  bool operator ==(Object other) {
    return EventMapper.ensureInitialized().equalsValue(this as Event, other);
  }

  @override
  int get hashCode {
    return EventMapper.ensureInitialized().hashValue(this as Event);
  }
}

extension EventValueCopy<$R, $Out> on ObjectCopyWith<$R, Event, $Out> {
  EventCopyWith<$R, Event, $Out> get $asEvent =>
      $base.as((v, t, t2) => _EventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventCopyWith<$R, $In extends Event, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media;
  LocationCopyWith<$R, Location, Location> get location;
  ListCopyWith<$R, Detail, DetailCopyWith<$R, Detail, Detail>> get details;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc>? get category;
  ListCopyWith<
    $R,
    Experiences,
    ExperiencesCopyWith<$R, Experiences, Experiences>
  >
  get experiences;
  VendorCopyWith<$R, Vendor, Vendor> get vendor;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get thingsToKnow;
  BookingExperienceCopyWith<$R, BookingExperience, BookingExperience>?
  get bookingExperience;
  $R call({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? media,
    Location? location,
    List<Detail>? details,
    PriceType? priceType,
    List<String>? tags,
    CategoryNoDesc? category,
    List<Experiences>? experiences,
    Vendor? vendor,
    DateTime? createdAt,
    List<String>? thingsToKnow,
    BookingExperience? bookingExperience,
    bool? isFavorited,
    String? detailsTitle,
    String? termsAndConditions,
  });
  EventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Event, $Out>
    implements EventCopyWith<$R, Event, $Out> {
  _EventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Event> $mapper = EventMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media =>
      ListCopyWith(
        $value.media,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(media: v),
      );
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  ListCopyWith<$R, Detail, DetailCopyWith<$R, Detail, Detail>> get details =>
      ListCopyWith(
        $value.details,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(details: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith(
        $value.tags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tags: v),
      );
  @override
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  ListCopyWith<
    $R,
    Experiences,
    ExperiencesCopyWith<$R, Experiences, Experiences>
  >
  get experiences => ListCopyWith(
    $value.experiences,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(experiences: v),
  );
  @override
  VendorCopyWith<$R, Vendor, Vendor> get vendor =>
      $value.vendor.copyWith.$chain((v) => call(vendor: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get thingsToKnow => $value.thingsToKnow != null
      ? ListCopyWith(
          $value.thingsToKnow!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(thingsToKnow: v),
        )
      : null;
  @override
  BookingExperienceCopyWith<$R, BookingExperience, BookingExperience>?
  get bookingExperience => $value.bookingExperience?.copyWith.$chain(
    (v) => call(bookingExperience: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? media,
    Location? location,
    List<Detail>? details,
    Object? priceType = $none,
    List<String>? tags,
    Object? category = $none,
    List<Experiences>? experiences,
    Vendor? vendor,
    DateTime? createdAt,
    Object? thingsToKnow = $none,
    Object? bookingExperience = $none,
    bool? isFavorited,
    Object? detailsTitle = $none,
    Object? termsAndConditions = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (startTime != null) #startTime: startTime,
      if (endTime != null) #endTime: endTime,
      if (media != null) #media: media,
      if (location != null) #location: location,
      if (details != null) #details: details,
      if (priceType != $none) #priceType: priceType,
      if (tags != null) #tags: tags,
      if (category != $none) #category: category,
      if (experiences != null) #experiences: experiences,
      if (vendor != null) #vendor: vendor,
      if (createdAt != null) #createdAt: createdAt,
      if (thingsToKnow != $none) #thingsToKnow: thingsToKnow,
      if (bookingExperience != $none) #bookingExperience: bookingExperience,
      if (isFavorited != null) #isFavorited: isFavorited,
      if (detailsTitle != $none) #detailsTitle: detailsTitle,
      if (termsAndConditions != $none) #termsAndConditions: termsAndConditions,
    }),
  );
  @override
  Event $make(CopyWithData data) => Event(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    startTime: data.get(#startTime, or: $value.startTime),
    endTime: data.get(#endTime, or: $value.endTime),
    media: data.get(#media, or: $value.media),
    location: data.get(#location, or: $value.location),
    details: data.get(#details, or: $value.details),
    priceType: data.get(#priceType, or: $value.priceType),
    tags: data.get(#tags, or: $value.tags),
    category: data.get(#category, or: $value.category),
    experiences: data.get(#experiences, or: $value.experiences),
    vendor: data.get(#vendor, or: $value.vendor),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    thingsToKnow: data.get(#thingsToKnow, or: $value.thingsToKnow),
    bookingExperience: data.get(
      #bookingExperience,
      or: $value.bookingExperience,
    ),
    isFavorited: data.get(#isFavorited, or: $value.isFavorited),
    detailsTitle: data.get(#detailsTitle, or: $value.detailsTitle),
    termsAndConditions: data.get(
      #termsAndConditions,
      or: $value.termsAndConditions,
    ),
  );

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BookingExperienceMapper extends ClassMapperBase<BookingExperience> {
  BookingExperienceMapper._();

  static BookingExperienceMapper? _instance;
  static BookingExperienceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingExperienceMapper._());
      PassesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookingExperience';

  static String _$id(BookingExperience v) => v.id;
  static const Field<BookingExperience, String> _f$id = Field('id', _$id);
  static List<Passes> _$passes(BookingExperience v) => v.passes;
  static const Field<BookingExperience, List<Passes>> _f$passes = Field(
    'passes',
    _$passes,
  );
  static bool _$requireReservationApproval(BookingExperience v) =>
      v.requireReservationApproval;
  static const Field<BookingExperience, bool> _f$requireReservationApproval =
      Field(
        'requireReservationApproval',
        _$requireReservationApproval,
        opt: true,
        def: false,
      );

  @override
  final MappableFields<BookingExperience> fields = const {
    #id: _f$id,
    #passes: _f$passes,
    #requireReservationApproval: _f$requireReservationApproval,
  };

  static BookingExperience _instantiate(DecodingData data) {
    return BookingExperience(
      id: data.dec(_f$id),
      passes: data.dec(_f$passes),
      requireReservationApproval: data.dec(_f$requireReservationApproval),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingExperience fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingExperience>(map);
  }

  static BookingExperience fromJson(String json) {
    return ensureInitialized().decodeJson<BookingExperience>(json);
  }
}

mixin BookingExperienceMappable {
  String toJson() {
    return BookingExperienceMapper.ensureInitialized()
        .encodeJson<BookingExperience>(this as BookingExperience);
  }

  Map<String, dynamic> toMap() {
    return BookingExperienceMapper.ensureInitialized()
        .encodeMap<BookingExperience>(this as BookingExperience);
  }

  BookingExperienceCopyWith<
    BookingExperience,
    BookingExperience,
    BookingExperience
  >
  get copyWith =>
      _BookingExperienceCopyWithImpl<BookingExperience, BookingExperience>(
        this as BookingExperience,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookingExperienceMapper.ensureInitialized().stringifyValue(
      this as BookingExperience,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingExperienceMapper.ensureInitialized().equalsValue(
      this as BookingExperience,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingExperienceMapper.ensureInitialized().hashValue(
      this as BookingExperience,
    );
  }
}

extension BookingExperienceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingExperience, $Out> {
  BookingExperienceCopyWith<$R, BookingExperience, $Out>
  get $asBookingExperience => $base.as(
    (v, t, t2) => _BookingExperienceCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BookingExperienceCopyWith<
  $R,
  $In extends BookingExperience,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Passes, PassesCopyWith<$R, Passes, Passes>> get passes;
  $R call({String? id, List<Passes>? passes, bool? requireReservationApproval});
  BookingExperienceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BookingExperienceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingExperience, $Out>
    implements BookingExperienceCopyWith<$R, BookingExperience, $Out> {
  _BookingExperienceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingExperience> $mapper =
      BookingExperienceMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Passes, PassesCopyWith<$R, Passes, Passes>> get passes =>
      ListCopyWith(
        $value.passes,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(passes: v),
      );
  @override
  $R call({
    String? id,
    List<Passes>? passes,
    bool? requireReservationApproval,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (passes != null) #passes: passes,
      if (requireReservationApproval != null)
        #requireReservationApproval: requireReservationApproval,
    }),
  );
  @override
  BookingExperience $make(CopyWithData data) => BookingExperience(
    id: data.get(#id, or: $value.id),
    passes: data.get(#passes, or: $value.passes),
    requireReservationApproval: data.get(
      #requireReservationApproval,
      or: $value.requireReservationApproval,
    ),
  );

  @override
  BookingExperienceCopyWith<$R2, BookingExperience, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookingExperienceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PassesMapper extends ClassMapperBase<Passes> {
  PassesMapper._();

  static PassesMapper? _instance;
  static PassesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PassesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Passes';

  static String _$id(Passes v) => v.id;
  static const Field<Passes, String> _f$id = Field('id', _$id);
  static String _$name(Passes v) => v.name;
  static const Field<Passes, String> _f$name = Field('name', _$name);
  static String? _$benefits(Passes v) => v.benefits;
  static const Field<Passes, String> _f$benefits = Field(
    'benefits',
    _$benefits,
  );
  static double _$price(Passes v) => v.price;
  static const Field<Passes, double> _f$price = Field('price', _$price);
  static int _$maximumAmount(Passes v) => v.maximumAmount;
  static const Field<Passes, int> _f$maximumAmount = Field(
    'maximumAmount',
    _$maximumAmount,
  );
  static int _$currentBookings(Passes v) => v.currentBookings;
  static const Field<Passes, int> _f$currentBookings = Field(
    'currentBookings',
    _$currentBookings,
  );
  static bool _$isActive(Passes v) => v.isActive;
  static const Field<Passes, bool> _f$isActive = Field('isActive', _$isActive);
  static int? _$rouletteRemainingWins(Passes v) => v.rouletteRemainingWins;
  static const Field<Passes, int> _f$rouletteRemainingWins = Field(
    'rouletteRemainingWins',
    _$rouletteRemainingWins,
    opt: true,
  );
  static int? _$rouletteMaxWins(Passes v) => v.rouletteMaxWins;
  static const Field<Passes, int> _f$rouletteMaxWins = Field(
    'rouletteMaxWins',
    _$rouletteMaxWins,
    opt: true,
  );
  static int? _$discountPercentage(Passes v) => v.discountPercentage;
  static const Field<Passes, int> _f$discountPercentage = Field(
    'discountPercentage',
    _$discountPercentage,
  );

  @override
  final MappableFields<Passes> fields = const {
    #id: _f$id,
    #name: _f$name,
    #benefits: _f$benefits,
    #price: _f$price,
    #maximumAmount: _f$maximumAmount,
    #currentBookings: _f$currentBookings,
    #isActive: _f$isActive,
    #rouletteRemainingWins: _f$rouletteRemainingWins,
    #rouletteMaxWins: _f$rouletteMaxWins,
    #discountPercentage: _f$discountPercentage,
  };

  static Passes _instantiate(DecodingData data) {
    return Passes(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      benefits: data.dec(_f$benefits),
      price: data.dec(_f$price),
      maximumAmount: data.dec(_f$maximumAmount),
      currentBookings: data.dec(_f$currentBookings),
      isActive: data.dec(_f$isActive),
      rouletteRemainingWins: data.dec(_f$rouletteRemainingWins),
      rouletteMaxWins: data.dec(_f$rouletteMaxWins),
      discountPercentage: data.dec(_f$discountPercentage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Passes fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Passes>(map);
  }

  static Passes fromJson(String json) {
    return ensureInitialized().decodeJson<Passes>(json);
  }
}

mixin PassesMappable {
  String toJson() {
    return PassesMapper.ensureInitialized().encodeJson<Passes>(this as Passes);
  }

  Map<String, dynamic> toMap() {
    return PassesMapper.ensureInitialized().encodeMap<Passes>(this as Passes);
  }

  PassesCopyWith<Passes, Passes, Passes> get copyWith =>
      _PassesCopyWithImpl<Passes, Passes>(this as Passes, $identity, $identity);
  @override
  String toString() {
    return PassesMapper.ensureInitialized().stringifyValue(this as Passes);
  }

  @override
  bool operator ==(Object other) {
    return PassesMapper.ensureInitialized().equalsValue(this as Passes, other);
  }

  @override
  int get hashCode {
    return PassesMapper.ensureInitialized().hashValue(this as Passes);
  }
}

extension PassesValueCopy<$R, $Out> on ObjectCopyWith<$R, Passes, $Out> {
  PassesCopyWith<$R, Passes, $Out> get $asPasses =>
      $base.as((v, t, t2) => _PassesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PassesCopyWith<$R, $In extends Passes, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? benefits,
    double? price,
    int? maximumAmount,
    int? currentBookings,
    bool? isActive,
    int? rouletteRemainingWins,
    int? rouletteMaxWins,
    int? discountPercentage,
  });
  PassesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PassesCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Passes, $Out>
    implements PassesCopyWith<$R, Passes, $Out> {
  _PassesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Passes> $mapper = PassesMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    Object? benefits = $none,
    double? price,
    int? maximumAmount,
    int? currentBookings,
    bool? isActive,
    Object? rouletteRemainingWins = $none,
    Object? rouletteMaxWins = $none,
    Object? discountPercentage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (benefits != $none) #benefits: benefits,
      if (price != null) #price: price,
      if (maximumAmount != null) #maximumAmount: maximumAmount,
      if (currentBookings != null) #currentBookings: currentBookings,
      if (isActive != null) #isActive: isActive,
      if (rouletteRemainingWins != $none)
        #rouletteRemainingWins: rouletteRemainingWins,
      if (rouletteMaxWins != $none) #rouletteMaxWins: rouletteMaxWins,
      if (discountPercentage != $none) #discountPercentage: discountPercentage,
    }),
  );
  @override
  Passes $make(CopyWithData data) => Passes(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    benefits: data.get(#benefits, or: $value.benefits),
    price: data.get(#price, or: $value.price),
    maximumAmount: data.get(#maximumAmount, or: $value.maximumAmount),
    currentBookings: data.get(#currentBookings, or: $value.currentBookings),
    isActive: data.get(#isActive, or: $value.isActive),
    rouletteRemainingWins: data.get(
      #rouletteRemainingWins,
      or: $value.rouletteRemainingWins,
    ),
    rouletteMaxWins: data.get(#rouletteMaxWins, or: $value.rouletteMaxWins),
    discountPercentage: data.get(
      #discountPercentage,
      or: $value.discountPercentage,
    ),
  );

  @override
  PassesCopyWith<$R2, Passes, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PassesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

