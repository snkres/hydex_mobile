// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location.dart';

class LocationMapper extends ClassMapperBase<Location> {
  LocationMapper._();

  static LocationMapper? _instance;
  static LocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationMapper._());
      CoordinatesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Location';

  static Coordinates _$coordinates(Location v) => v.coordinates;
  static const Field<Location, Coordinates> _f$coordinates = Field(
    'coordinates',
    _$coordinates,
  );
  static String? _$city(Location v) => v.city;
  static const Field<Location, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
  );
  static String? _$street(Location v) => v.street;
  static const Field<Location, String> _f$street = Field(
    'street',
    _$street,
    opt: true,
  );
  static String? _$country(Location v) => v.country;
  static const Field<Location, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
  );
  static String? _$address(Location v) => v.address;
  static const Field<Location, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );

  @override
  final MappableFields<Location> fields = const {
    #coordinates: _f$coordinates,
    #city: _f$city,
    #street: _f$street,
    #country: _f$country,
    #address: _f$address,
  };

  static Location _instantiate(DecodingData data) {
    return Location(
      coordinates: data.dec(_f$coordinates),
      city: data.dec(_f$city),
      street: data.dec(_f$street),
      country: data.dec(_f$country),
      address: data.dec(_f$address),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Location fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Location>(map);
  }

  static Location fromJson(String json) {
    return ensureInitialized().decodeJson<Location>(json);
  }
}

mixin LocationMappable {
  String toJson() {
    return LocationMapper.ensureInitialized().encodeJson<Location>(
      this as Location,
    );
  }

  Map<String, dynamic> toMap() {
    return LocationMapper.ensureInitialized().encodeMap<Location>(
      this as Location,
    );
  }

  LocationCopyWith<Location, Location, Location> get copyWith =>
      _LocationCopyWithImpl<Location, Location>(
        this as Location,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocationMapper.ensureInitialized().stringifyValue(this as Location);
  }

  @override
  bool operator ==(Object other) {
    return LocationMapper.ensureInitialized().equalsValue(
      this as Location,
      other,
    );
  }

  @override
  int get hashCode {
    return LocationMapper.ensureInitialized().hashValue(this as Location);
  }
}

extension LocationValueCopy<$R, $Out> on ObjectCopyWith<$R, Location, $Out> {
  LocationCopyWith<$R, Location, $Out> get $asLocation =>
      $base.as((v, t, t2) => _LocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocationCopyWith<$R, $In extends Location, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CoordinatesCopyWith<$R, Coordinates, Coordinates> get coordinates;
  $R call({
    Coordinates? coordinates,
    String? city,
    String? street,
    String? country,
    String? address,
  });
  LocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Location, $Out>
    implements LocationCopyWith<$R, Location, $Out> {
  _LocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Location> $mapper =
      LocationMapper.ensureInitialized();
  @override
  CoordinatesCopyWith<$R, Coordinates, Coordinates> get coordinates =>
      $value.coordinates.copyWith.$chain((v) => call(coordinates: v));
  @override
  $R call({
    Coordinates? coordinates,
    Object? city = $none,
    Object? street = $none,
    Object? country = $none,
    Object? address = $none,
  }) => $apply(
    FieldCopyWithData({
      if (coordinates != null) #coordinates: coordinates,
      if (city != $none) #city: city,
      if (street != $none) #street: street,
      if (country != $none) #country: country,
      if (address != $none) #address: address,
    }),
  );
  @override
  Location $make(CopyWithData data) => Location(
    coordinates: data.get(#coordinates, or: $value.coordinates),
    city: data.get(#city, or: $value.city),
    street: data.get(#street, or: $value.street),
    country: data.get(#country, or: $value.country),
    address: data.get(#address, or: $value.address),
  );

  @override
  LocationCopyWith<$R2, Location, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

