// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Event';

  static String? _$id(Event v) => v.id;
  static const Field<Event, String> _f$id = Field('id', _$id, opt: true);
  static String _$title(Event v) => v.title;
  static const Field<Event, String> _f$title = Field('title', _$title);
  static String _$description(Event v) => v.description;
  static const Field<Event, String> _f$description =
      Field('description', _$description);
  static DateTime _$startDate(Event v) => v.startDate;
  static const Field<Event, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static DateTime _$endDate(Event v) => v.endDate;
  static const Field<Event, DateTime> _f$endDate = Field('endDate', _$endDate);
  static String _$location(Event v) => v.location;
  static const Field<Event, String> _f$location = Field('location', _$location);
  static String _$imageUrl(Event v) => v.imageUrl;
  static const Field<Event, String> _f$imageUrl = Field('imageUrl', _$imageUrl);

  @override
  final MappableFields<Event> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #location: _f$location,
    #imageUrl: _f$imageUrl,
  };

  static Event _instantiate(DecodingData data) {
    return Event(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate),
        location: data.dec(_f$location),
        imageUrl: data.dec(_f$imageUrl));
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
  $R call(
      {String? id,
      String? title,
      String? description,
      DateTime? startDate,
      DateTime? endDate,
      String? location,
      String? imageUrl});
  EventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Event, $Out>
    implements EventCopyWith<$R, Event, $Out> {
  _EventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Event> $mapper = EventMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? title,
          String? description,
          DateTime? startDate,
          DateTime? endDate,
          String? location,
          String? imageUrl}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (startDate != null) #startDate: startDate,
        if (endDate != null) #endDate: endDate,
        if (location != null) #location: location,
        if (imageUrl != null) #imageUrl: imageUrl
      }));
  @override
  Event $make(CopyWithData data) => Event(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate),
      location: data.get(#location, or: $value.location),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl));

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
