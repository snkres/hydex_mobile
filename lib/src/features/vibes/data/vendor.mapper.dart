// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vendor.dart';

class VendorMapper extends ClassMapperBase<Vendor> {
  VendorMapper._();

  static VendorMapper? _instance;
  static VendorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorMapper._());
      LocationMapper.ensureInitialized();
      OperatingHoursMapper.ensureInitialized();
      DetailMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Vendor';

  static String _$id(Vendor v) => v.id;
  static const Field<Vendor, String> _f$id = Field('id', _$id);
  static String _$ownerId(Vendor v) => v.ownerId;
  static const Field<Vendor, String> _f$ownerId = Field('ownerId', _$ownerId);
  static String? _$logo(Vendor v) => v.logo;
  static const Field<Vendor, String> _f$logo = Field('logo', _$logo, opt: true);
  static String _$name(Vendor v) => v.name;
  static const Field<Vendor, String> _f$name = Field('name', _$name);
  static String _$headline(Vendor v) => v.headline;
  static const Field<Vendor, String> _f$headline = Field(
    'headline',
    _$headline,
  );
  static String _$website(Vendor v) => v.website;
  static const Field<Vendor, String> _f$website = Field('website', _$website);
  static String _$description(Vendor v) => v.description;
  static const Field<Vendor, String> _f$description = Field(
    'description',
    _$description,
  );
  static Location _$location(Vendor v) => v.location;
  static const Field<Vendor, Location> _f$location = Field(
    'location',
    _$location,
  );
  static String _$priceType(Vendor v) => v.priceType;
  static const Field<Vendor, String> _f$priceType = Field(
    'priceType',
    _$priceType,
  );
  static Map<String, OperatingHours> _$operatingHours(Vendor v) =>
      v.operatingHours;
  static const Field<Vendor, Map<String, OperatingHours>> _f$operatingHours =
      Field('operatingHours', _$operatingHours);
  static List<String> _$experiences(Vendor v) => v.experiences;
  static const Field<Vendor, List<String>> _f$experiences = Field(
    'experiences',
    _$experiences,
  );
  static List<String> _$media(Vendor v) => v.media;
  static const Field<Vendor, List<String>> _f$media = Field('media', _$media);
  static List<String> _$gallery(Vendor v) => v.gallery;
  static const Field<Vendor, List<String>> _f$gallery = Field(
    'gallery',
    _$gallery,
  );
  static List<Detail> _$details(Vendor v) => v.details;
  static const Field<Vendor, List<Detail>> _f$details = Field(
    'details',
    _$details,
  );
  static String? _$detailsDescription(Vendor v) => v.detailsDescription;
  static const Field<Vendor, String> _f$detailsDescription = Field(
    'detailsDescription',
    _$detailsDescription,
    opt: true,
  );
  static List<String> _$tags(Vendor v) => v.tags;
  static const Field<Vendor, List<String>> _f$tags = Field('tags', _$tags);
  static List<String> _$thingsToKnow(Vendor v) => v.thingsToKnow;
  static const Field<Vendor, List<String>> _f$thingsToKnow = Field(
    'thingsToKnow',
    _$thingsToKnow,
  );

  @override
  final MappableFields<Vendor> fields = const {
    #id: _f$id,
    #ownerId: _f$ownerId,
    #logo: _f$logo,
    #name: _f$name,
    #headline: _f$headline,
    #website: _f$website,
    #description: _f$description,
    #location: _f$location,
    #priceType: _f$priceType,
    #operatingHours: _f$operatingHours,
    #experiences: _f$experiences,
    #media: _f$media,
    #gallery: _f$gallery,
    #details: _f$details,
    #detailsDescription: _f$detailsDescription,
    #tags: _f$tags,
    #thingsToKnow: _f$thingsToKnow,
  };

  static Vendor _instantiate(DecodingData data) {
    return Vendor(
      id: data.dec(_f$id),
      ownerId: data.dec(_f$ownerId),
      logo: data.dec(_f$logo),
      name: data.dec(_f$name),
      headline: data.dec(_f$headline),
      website: data.dec(_f$website),
      description: data.dec(_f$description),
      location: data.dec(_f$location),
      priceType: data.dec(_f$priceType),
      operatingHours: data.dec(_f$operatingHours),
      experiences: data.dec(_f$experiences),
      media: data.dec(_f$media),
      gallery: data.dec(_f$gallery),
      details: data.dec(_f$details),
      detailsDescription: data.dec(_f$detailsDescription),
      tags: data.dec(_f$tags),
      thingsToKnow: data.dec(_f$thingsToKnow),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Vendor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Vendor>(map);
  }

  static Vendor fromJson(String json) {
    return ensureInitialized().decodeJson<Vendor>(json);
  }
}

mixin VendorMappable {
  String toJson() {
    return VendorMapper.ensureInitialized().encodeJson<Vendor>(this as Vendor);
  }

  Map<String, dynamic> toMap() {
    return VendorMapper.ensureInitialized().encodeMap<Vendor>(this as Vendor);
  }

  VendorCopyWith<Vendor, Vendor, Vendor> get copyWith =>
      _VendorCopyWithImpl<Vendor, Vendor>(this as Vendor, $identity, $identity);
  @override
  String toString() {
    return VendorMapper.ensureInitialized().stringifyValue(this as Vendor);
  }

  @override
  bool operator ==(Object other) {
    return VendorMapper.ensureInitialized().equalsValue(this as Vendor, other);
  }

  @override
  int get hashCode {
    return VendorMapper.ensureInitialized().hashValue(this as Vendor);
  }
}

extension VendorValueCopy<$R, $Out> on ObjectCopyWith<$R, Vendor, $Out> {
  VendorCopyWith<$R, Vendor, $Out> get $asVendor =>
      $base.as((v, t, t2) => _VendorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VendorCopyWith<$R, $In extends Vendor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  LocationCopyWith<$R, Location, Location> get location;
  MapCopyWith<
    $R,
    String,
    OperatingHours,
    OperatingHoursCopyWith<$R, OperatingHours, OperatingHours>
  >
  get operatingHours;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get experiences;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get gallery;
  ListCopyWith<$R, Detail, DetailCopyWith<$R, Detail, Detail>> get details;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get thingsToKnow;
  $R call({
    String? id,
    String? ownerId,
    String? logo,
    String? name,
    String? headline,
    String? website,
    String? description,
    Location? location,
    String? priceType,
    Map<String, OperatingHours>? operatingHours,
    List<String>? experiences,
    List<String>? media,
    List<String>? gallery,
    List<Detail>? details,
    String? detailsDescription,
    List<String>? tags,
    List<String>? thingsToKnow,
  });
  VendorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VendorCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Vendor, $Out>
    implements VendorCopyWith<$R, Vendor, $Out> {
  _VendorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Vendor> $mapper = VendorMapper.ensureInitialized();
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get experiences => ListCopyWith(
    $value.experiences,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(experiences: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media =>
      ListCopyWith(
        $value.media,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(media: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get gallery =>
      ListCopyWith(
        $value.gallery,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(gallery: v),
      );
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get thingsToKnow => ListCopyWith(
    $value.thingsToKnow,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(thingsToKnow: v),
  );
  @override
  $R call({
    String? id,
    String? ownerId,
    Object? logo = $none,
    String? name,
    String? headline,
    String? website,
    String? description,
    Location? location,
    String? priceType,
    Map<String, OperatingHours>? operatingHours,
    List<String>? experiences,
    List<String>? media,
    List<String>? gallery,
    List<Detail>? details,
    Object? detailsDescription = $none,
    List<String>? tags,
    List<String>? thingsToKnow,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (ownerId != null) #ownerId: ownerId,
      if (logo != $none) #logo: logo,
      if (name != null) #name: name,
      if (headline != null) #headline: headline,
      if (website != null) #website: website,
      if (description != null) #description: description,
      if (location != null) #location: location,
      if (priceType != null) #priceType: priceType,
      if (operatingHours != null) #operatingHours: operatingHours,
      if (experiences != null) #experiences: experiences,
      if (media != null) #media: media,
      if (gallery != null) #gallery: gallery,
      if (details != null) #details: details,
      if (detailsDescription != $none) #detailsDescription: detailsDescription,
      if (tags != null) #tags: tags,
      if (thingsToKnow != null) #thingsToKnow: thingsToKnow,
    }),
  );
  @override
  Vendor $make(CopyWithData data) => Vendor(
    id: data.get(#id, or: $value.id),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    logo: data.get(#logo, or: $value.logo),
    name: data.get(#name, or: $value.name),
    headline: data.get(#headline, or: $value.headline),
    website: data.get(#website, or: $value.website),
    description: data.get(#description, or: $value.description),
    location: data.get(#location, or: $value.location),
    priceType: data.get(#priceType, or: $value.priceType),
    operatingHours: data.get(#operatingHours, or: $value.operatingHours),
    experiences: data.get(#experiences, or: $value.experiences),
    media: data.get(#media, or: $value.media),
    gallery: data.get(#gallery, or: $value.gallery),
    details: data.get(#details, or: $value.details),
    detailsDescription: data.get(
      #detailsDescription,
      or: $value.detailsDescription,
    ),
    tags: data.get(#tags, or: $value.tags),
    thingsToKnow: data.get(#thingsToKnow, or: $value.thingsToKnow),
  );

  @override
  VendorCopyWith<$R2, Vendor, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VendorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

