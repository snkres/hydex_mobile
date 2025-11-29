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

class BannerMapper extends ClassMapperBase<Banner> {
  BannerMapper._();

  static BannerMapper? _instance;
  static BannerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BannerMapper._());
      BannerTypeMapper.ensureInitialized();
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
  static DateTime _$campaignStartDate(Banner v) => v.campaignStartDate;
  static const Field<Banner, DateTime> _f$campaignStartDate = Field(
    'campaignStartDate',
    _$campaignStartDate,
  );
  static DateTime _$campaignEndDate(Banner v) => v.campaignEndDate;
  static const Field<Banner, DateTime> _f$campaignEndDate = Field(
    'campaignEndDate',
    _$campaignEndDate,
  );

  @override
  final MappableFields<Banner> fields = const {
    #id: _f$id,
    #type: _f$type,
    #headline: _f$headline,
    #subtitle: _f$subtitle,
    #image: _f$image,
    #video: _f$video,
    #campaignStartDate: _f$campaignStartDate,
    #campaignEndDate: _f$campaignEndDate,
  };

  static Banner _instantiate(DecodingData data) {
    return Banner(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      headline: data.dec(_f$headline),
      subtitle: data.dec(_f$subtitle),
      image: data.dec(_f$image),
      video: data.dec(_f$video),
      campaignStartDate: data.dec(_f$campaignStartDate),
      campaignEndDate: data.dec(_f$campaignEndDate),
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
  $R call({
    String? id,
    BannerType? type,
    String? headline,
    String? subtitle,
    String? image,
    String? video,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
  });
  BannerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BannerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Banner, $Out>
    implements BannerCopyWith<$R, Banner, $Out> {
  _BannerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Banner> $mapper = BannerMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    BannerType? type,
    String? headline,
    String? subtitle,
    Object? image = $none,
    Object? video = $none,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (headline != null) #headline: headline,
      if (subtitle != null) #subtitle: subtitle,
      if (image != $none) #image: image,
      if (video != $none) #video: video,
      if (campaignStartDate != null) #campaignStartDate: campaignStartDate,
      if (campaignEndDate != null) #campaignEndDate: campaignEndDate,
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
    campaignStartDate: data.get(
      #campaignStartDate,
      or: $value.campaignStartDate,
    ),
    campaignEndDate: data.get(#campaignEndDate, or: $value.campaignEndDate),
  );

  @override
  BannerCopyWith<$R2, Banner, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BannerCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

  static String _$name(Experiences v) => v.name;
  static const Field<Experiences, String> _f$name = Field('name', _$name);
  static String _$description(Experiences v) => v.description;
  static const Field<Experiences, String> _f$description = Field(
    'description',
    _$description,
  );

  @override
  final MappableFields<Experiences> fields = const {
    #name: _f$name,
    #description: _f$description,
  };

  static Experiences _instantiate(DecodingData data) {
    return Experiences(
      name: data.dec(_f$name),
      description: data.dec(_f$description),
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
  $R call({String? name, String? description});
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
  $R call({String? name, String? description}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (description != null) #description: description,
    }),
  );
  @override
  Experiences $make(CopyWithData data) => Experiences(
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
  );

  @override
  ExperiencesCopyWith<$R2, Experiences, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ExperiencesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
      LocationMapper.ensureInitialized();
      DetailMapper.ensureInitialized();
      EventCategoryMapper.ensureInitialized();
      ExperiencesMapper.ensureInitialized();
      VendorMapper.ensureInitialized();
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
  static String _$priceType(Event v) => v.priceType;
  static const Field<Event, String> _f$priceType = Field(
    'priceType',
    _$priceType,
  );
  static List<String> _$tags(Event v) => v.tags;
  static const Field<Event, List<String>> _f$tags = Field('tags', _$tags);
  static EventCategory? _$category(Event v) => v.category;
  static const Field<Event, EventCategory> _f$category = Field(
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
  static bool _$isFavorited(Event v) => v.isFavorited;
  static const Field<Event, bool> _f$isFavorited = Field(
    'isFavorited',
    _$isFavorited,
    opt: true,
    def: false,
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
    #isFavorited: _f$isFavorited,
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
      isFavorited: data.dec(_f$isFavorited),
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
  EventCategoryCopyWith<$R, EventCategory, EventCategory>? get category;
  ListCopyWith<
    $R,
    Experiences,
    ExperiencesCopyWith<$R, Experiences, Experiences>
  >
  get experiences;
  VendorCopyWith<$R, Vendor, Vendor> get vendor;
  $R call({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? media,
    Location? location,
    List<Detail>? details,
    String? priceType,
    List<String>? tags,
    EventCategory? category,
    List<Experiences>? experiences,
    Vendor? vendor,
    DateTime? createdAt,
    bool? isFavorited,
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
  EventCategoryCopyWith<$R, EventCategory, EventCategory>? get category =>
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
  $R call({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? media,
    Location? location,
    List<Detail>? details,
    String? priceType,
    List<String>? tags,
    Object? category = $none,
    List<Experiences>? experiences,
    Vendor? vendor,
    DateTime? createdAt,
    bool? isFavorited,
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
      if (priceType != null) #priceType: priceType,
      if (tags != null) #tags: tags,
      if (category != $none) #category: category,
      if (experiences != null) #experiences: experiences,
      if (vendor != null) #vendor: vendor,
      if (createdAt != null) #createdAt: createdAt,
      if (isFavorited != null) #isFavorited: isFavorited,
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
    isFavorited: data.get(#isFavorited, or: $value.isFavorited),
  );

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

