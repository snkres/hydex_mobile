// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'upcoming_event.dart';

class UpcomingEventStatusMapper extends EnumMapper<UpcomingEventStatus> {
  UpcomingEventStatusMapper._();

  static UpcomingEventStatusMapper? _instance;
  static UpcomingEventStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpcomingEventStatusMapper._());
    }
    return _instance!;
  }

  static UpcomingEventStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  UpcomingEventStatus decode(dynamic value) {
    switch (value) {
      case 'Pending':
        return UpcomingEventStatus.pending;
      case 'Confirmed':
        return UpcomingEventStatus.confirmed;
      case 'Invitation':
        return UpcomingEventStatus.invitation;
      case 'Cancelled':
        return UpcomingEventStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(UpcomingEventStatus self) {
    switch (self) {
      case UpcomingEventStatus.pending:
        return 'Pending';
      case UpcomingEventStatus.confirmed:
        return 'Confirmed';
      case UpcomingEventStatus.invitation:
        return 'Invitation';
      case UpcomingEventStatus.cancelled:
        return 'Cancelled';
    }
  }
}

extension UpcomingEventStatusMapperExtension on UpcomingEventStatus {
  dynamic toValue() {
    UpcomingEventStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<UpcomingEventStatus>(this);
  }
}

class UpcomingEventMapper extends ClassMapperBase<UpcomingEvent> {
  UpcomingEventMapper._();

  static UpcomingEventMapper? _instance;
  static UpcomingEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpcomingEventMapper._());
      LocationMapper.ensureInitialized();
      UpcomingEventStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpcomingEvent';

  static String _$id(UpcomingEvent v) => v.id;
  static const Field<UpcomingEvent, String> _f$id = Field('id', _$id);
  static String _$name(UpcomingEvent v) => v.name;
  static const Field<UpcomingEvent, String> _f$name = Field('name', _$name);
  static DateTime _$date(UpcomingEvent v) => v.date;
  static const Field<UpcomingEvent, DateTime> _f$date = Field('date', _$date);
  static String _$time(UpcomingEvent v) => v.time;
  static const Field<UpcomingEvent, String> _f$time = Field('time', _$time);
  static Location _$location(UpcomingEvent v) => v.location;
  static const Field<UpcomingEvent, Location> _f$location = Field(
    'location',
    _$location,
  );
  static UpcomingEventStatus _$status(UpcomingEvent v) => v.status;
  static const Field<UpcomingEvent, UpcomingEventStatus> _f$status = Field(
    'status',
    _$status,
  );
  static int _$numberOfGuests(UpcomingEvent v) => v.numberOfGuests;
  static const Field<UpcomingEvent, int> _f$numberOfGuests = Field(
    'numberOfGuests',
    _$numberOfGuests,
  );

  @override
  final MappableFields<UpcomingEvent> fields = const {
    #id: _f$id,
    #name: _f$name,
    #date: _f$date,
    #time: _f$time,
    #location: _f$location,
    #status: _f$status,
    #numberOfGuests: _f$numberOfGuests,
  };

  static UpcomingEvent _instantiate(DecodingData data) {
    return UpcomingEvent(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      date: data.dec(_f$date),
      time: data.dec(_f$time),
      location: data.dec(_f$location),
      status: data.dec(_f$status),
      numberOfGuests: data.dec(_f$numberOfGuests),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UpcomingEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpcomingEvent>(map);
  }

  static UpcomingEvent fromJson(String json) {
    return ensureInitialized().decodeJson<UpcomingEvent>(json);
  }
}

mixin UpcomingEventMappable {
  String toJson() {
    return UpcomingEventMapper.ensureInitialized().encodeJson<UpcomingEvent>(
      this as UpcomingEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return UpcomingEventMapper.ensureInitialized().encodeMap<UpcomingEvent>(
      this as UpcomingEvent,
    );
  }

  UpcomingEventCopyWith<UpcomingEvent, UpcomingEvent, UpcomingEvent>
  get copyWith => _UpcomingEventCopyWithImpl<UpcomingEvent, UpcomingEvent>(
    this as UpcomingEvent,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UpcomingEventMapper.ensureInitialized().stringifyValue(
      this as UpcomingEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return UpcomingEventMapper.ensureInitialized().equalsValue(
      this as UpcomingEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return UpcomingEventMapper.ensureInitialized().hashValue(
      this as UpcomingEvent,
    );
  }
}

extension UpcomingEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpcomingEvent, $Out> {
  UpcomingEventCopyWith<$R, UpcomingEvent, $Out> get $asUpcomingEvent =>
      $base.as((v, t, t2) => _UpcomingEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpcomingEventCopyWith<$R, $In extends UpcomingEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  LocationCopyWith<$R, Location, Location> get location;
  $R call({
    String? id,
    String? name,
    DateTime? date,
    String? time,
    Location? location,
    UpcomingEventStatus? status,
    int? numberOfGuests,
  });
  UpcomingEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpcomingEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpcomingEvent, $Out>
    implements UpcomingEventCopyWith<$R, UpcomingEvent, $Out> {
  _UpcomingEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpcomingEvent> $mapper =
      UpcomingEventMapper.ensureInitialized();
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  $R call({
    String? id,
    String? name,
    DateTime? date,
    String? time,
    Location? location,
    UpcomingEventStatus? status,
    int? numberOfGuests,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (date != null) #date: date,
      if (time != null) #time: time,
      if (location != null) #location: location,
      if (status != null) #status: status,
      if (numberOfGuests != null) #numberOfGuests: numberOfGuests,
    }),
  );
  @override
  UpcomingEvent $make(CopyWithData data) => UpcomingEvent(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    date: data.get(#date, or: $value.date),
    time: data.get(#time, or: $value.time),
    location: data.get(#location, or: $value.location),
    status: data.get(#status, or: $value.status),
    numberOfGuests: data.get(#numberOfGuests, or: $value.numberOfGuests),
  );

  @override
  UpcomingEventCopyWith<$R2, UpcomingEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UpcomingEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

