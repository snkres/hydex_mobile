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

class HistoryStatusMapper extends EnumMapper<HistoryStatus> {
  HistoryStatusMapper._();

  static HistoryStatusMapper? _instance;
  static HistoryStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistoryStatusMapper._());
    }
    return _instance!;
  }

  static HistoryStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HistoryStatus decode(dynamic value) {
    switch (value) {
      case 'Cancelled':
        return HistoryStatus.cancelled;
      case 'Rejected':
        return HistoryStatus.rejected;
      case 'Confirmed':
        return HistoryStatus.confirmed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HistoryStatus self) {
    switch (self) {
      case HistoryStatus.cancelled:
        return 'Cancelled';
      case HistoryStatus.rejected:
        return 'Rejected';
      case HistoryStatus.confirmed:
        return 'Confirmed';
    }
  }
}

extension HistoryStatusMapperExtension on HistoryStatus {
  dynamic toValue() {
    HistoryStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HistoryStatus>(this);
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

class HistoryDataMapper extends ClassMapperBase<HistoryData> {
  HistoryDataMapper._();

  static HistoryDataMapper? _instance;
  static HistoryDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistoryDataMapper._());
      LocationMapper.ensureInitialized();
      HistoryStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HistoryData';

  static String _$id(HistoryData v) => v.id;
  static const Field<HistoryData, String> _f$id = Field('id', _$id);
  static String _$name(HistoryData v) => v.name;
  static const Field<HistoryData, String> _f$name = Field('name', _$name);
  static DateTime _$date(HistoryData v) => v.date;
  static const Field<HistoryData, DateTime> _f$date = Field('date', _$date);
  static String _$time(HistoryData v) => v.time;
  static const Field<HistoryData, String> _f$time = Field('time', _$time);
  static Location _$location(HistoryData v) => v.location;
  static const Field<HistoryData, Location> _f$location = Field(
    'location',
    _$location,
  );
  static String? _$cancellationReason(HistoryData v) => v.cancellationReason;
  static const Field<HistoryData, String> _f$cancellationReason = Field(
    'cancellationReason',
    _$cancellationReason,
    opt: true,
  );
  static HistoryStatus _$status(HistoryData v) => v.status;
  static const Field<HistoryData, HistoryStatus> _f$status = Field(
    'status',
    _$status,
  );

  @override
  final MappableFields<HistoryData> fields = const {
    #id: _f$id,
    #name: _f$name,
    #date: _f$date,
    #time: _f$time,
    #location: _f$location,
    #cancellationReason: _f$cancellationReason,
    #status: _f$status,
  };

  static HistoryData _instantiate(DecodingData data) {
    return HistoryData(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      date: data.dec(_f$date),
      time: data.dec(_f$time),
      location: data.dec(_f$location),
      cancellationReason: data.dec(_f$cancellationReason),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HistoryData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HistoryData>(map);
  }

  static HistoryData fromJson(String json) {
    return ensureInitialized().decodeJson<HistoryData>(json);
  }
}

mixin HistoryDataMappable {
  String toJson() {
    return HistoryDataMapper.ensureInitialized().encodeJson<HistoryData>(
      this as HistoryData,
    );
  }

  Map<String, dynamic> toMap() {
    return HistoryDataMapper.ensureInitialized().encodeMap<HistoryData>(
      this as HistoryData,
    );
  }

  HistoryDataCopyWith<HistoryData, HistoryData, HistoryData> get copyWith =>
      _HistoryDataCopyWithImpl<HistoryData, HistoryData>(
        this as HistoryData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HistoryDataMapper.ensureInitialized().stringifyValue(
      this as HistoryData,
    );
  }

  @override
  bool operator ==(Object other) {
    return HistoryDataMapper.ensureInitialized().equalsValue(
      this as HistoryData,
      other,
    );
  }

  @override
  int get hashCode {
    return HistoryDataMapper.ensureInitialized().hashValue(this as HistoryData);
  }
}

extension HistoryDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HistoryData, $Out> {
  HistoryDataCopyWith<$R, HistoryData, $Out> get $asHistoryData =>
      $base.as((v, t, t2) => _HistoryDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HistoryDataCopyWith<$R, $In extends HistoryData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  LocationCopyWith<$R, Location, Location> get location;
  $R call({
    String? id,
    String? name,
    DateTime? date,
    String? time,
    Location? location,
    String? cancellationReason,
    HistoryStatus? status,
  });
  HistoryDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HistoryDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HistoryData, $Out>
    implements HistoryDataCopyWith<$R, HistoryData, $Out> {
  _HistoryDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HistoryData> $mapper =
      HistoryDataMapper.ensureInitialized();
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
    Object? cancellationReason = $none,
    HistoryStatus? status,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (date != null) #date: date,
      if (time != null) #time: time,
      if (location != null) #location: location,
      if (cancellationReason != $none) #cancellationReason: cancellationReason,
      if (status != null) #status: status,
    }),
  );
  @override
  HistoryData $make(CopyWithData data) => HistoryData(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    date: data.get(#date, or: $value.date),
    time: data.get(#time, or: $value.time),
    location: data.get(#location, or: $value.location),
    cancellationReason: data.get(
      #cancellationReason,
      or: $value.cancellationReason,
    ),
    status: data.get(#status, or: $value.status),
  );

  @override
  HistoryDataCopyWith<$R2, HistoryData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HistoryDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PassportDataMapper extends ClassMapperBase<PassportData> {
  PassportDataMapper._();

  static PassportDataMapper? _instance;
  static PassportDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PassportDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PassportData';

  static int _$totalExperiences(PassportData v) => v.totalExperiences;
  static const Field<PassportData, int> _f$totalExperiences = Field(
    'totalExperiences',
    _$totalExperiences,
  );

  @override
  final MappableFields<PassportData> fields = const {
    #totalExperiences: _f$totalExperiences,
  };

  static PassportData _instantiate(DecodingData data) {
    return PassportData(totalExperiences: data.dec(_f$totalExperiences));
  }

  @override
  final Function instantiate = _instantiate;

  static PassportData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PassportData>(map);
  }

  static PassportData fromJson(String json) {
    return ensureInitialized().decodeJson<PassportData>(json);
  }
}

mixin PassportDataMappable {
  String toJson() {
    return PassportDataMapper.ensureInitialized().encodeJson<PassportData>(
      this as PassportData,
    );
  }

  Map<String, dynamic> toMap() {
    return PassportDataMapper.ensureInitialized().encodeMap<PassportData>(
      this as PassportData,
    );
  }

  PassportDataCopyWith<PassportData, PassportData, PassportData> get copyWith =>
      _PassportDataCopyWithImpl<PassportData, PassportData>(
        this as PassportData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PassportDataMapper.ensureInitialized().stringifyValue(
      this as PassportData,
    );
  }

  @override
  bool operator ==(Object other) {
    return PassportDataMapper.ensureInitialized().equalsValue(
      this as PassportData,
      other,
    );
  }

  @override
  int get hashCode {
    return PassportDataMapper.ensureInitialized().hashValue(
      this as PassportData,
    );
  }
}

extension PassportDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PassportData, $Out> {
  PassportDataCopyWith<$R, PassportData, $Out> get $asPassportData =>
      $base.as((v, t, t2) => _PassportDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PassportDataCopyWith<$R, $In extends PassportData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? totalExperiences});
  PassportDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PassportDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PassportData, $Out>
    implements PassportDataCopyWith<$R, PassportData, $Out> {
  _PassportDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PassportData> $mapper =
      PassportDataMapper.ensureInitialized();
  @override
  $R call({int? totalExperiences}) => $apply(
    FieldCopyWithData({
      if (totalExperiences != null) #totalExperiences: totalExperiences,
    }),
  );
  @override
  PassportData $make(CopyWithData data) => PassportData(
    totalExperiences: data.get(#totalExperiences, or: $value.totalExperiences),
  );

  @override
  PassportDataCopyWith<$R2, PassportData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PassportDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

