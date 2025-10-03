// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class EventTypeMapper extends EnumMapper<EventType> {
  EventTypeMapper._();

  static EventTypeMapper? _instance;
  static EventTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventTypeMapper._());
    }
    return _instance!;
  }

  static EventType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventType decode(dynamic value) {
    switch (value) {
      case 'FEATURED':
        return EventType.featured;
      case 'PROMOTIONAL':
        return EventType.promotional;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventType self) {
    switch (self) {
      case EventType.featured:
        return 'FEATURED';
      case EventType.promotional:
        return 'PROMOTIONAL';
    }
  }
}

extension EventTypeMapperExtension on EventType {
  dynamic toValue() {
    EventTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventType>(this);
  }
}

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
      EventTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Event';

  static String _$id(Event v) => v.id;
  static const Field<Event, String> _f$id = Field('id', _$id);
  static EventType _$type(Event v) => v.type;
  static const Field<Event, EventType> _f$type = Field('type', _$type);
  static String _$headline(Event v) => v.headline;
  static const Field<Event, String> _f$headline = Field('headline', _$headline);
  static String _$subtitle(Event v) => v.subtitle;
  static const Field<Event, String> _f$subtitle = Field('subtitle', _$subtitle);
  static String? _$image(Event v) => v.image;
  static const Field<Event, String> _f$image =
      Field('image', _$image, opt: true);
  static String? _$video(Event v) => v.video;
  static const Field<Event, String> _f$video =
      Field('video', _$video, opt: true);
  static DateTime _$campaignStartDate(Event v) => v.campaignStartDate;
  static const Field<Event, DateTime> _f$campaignStartDate =
      Field('campaignStartDate', _$campaignStartDate);
  static DateTime _$campaignEndDate(Event v) => v.campaignEndDate;
  static const Field<Event, DateTime> _f$campaignEndDate =
      Field('campaignEndDate', _$campaignEndDate);

  @override
  final MappableFields<Event> fields = const {
    #id: _f$id,
    #type: _f$type,
    #headline: _f$headline,
    #subtitle: _f$subtitle,
    #image: _f$image,
    #video: _f$video,
    #campaignStartDate: _f$campaignStartDate,
    #campaignEndDate: _f$campaignEndDate,
  };

  static Event _instantiate(DecodingData data) {
    return Event(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        headline: data.dec(_f$headline),
        subtitle: data.dec(_f$subtitle),
        image: data.dec(_f$image),
        video: data.dec(_f$video),
        campaignStartDate: data.dec(_f$campaignStartDate),
        campaignEndDate: data.dec(_f$campaignEndDate));
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
      EventType? type,
      String? headline,
      String? subtitle,
      String? image,
      String? video,
      DateTime? campaignStartDate,
      DateTime? campaignEndDate});
  EventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Event, $Out>
    implements EventCopyWith<$R, Event, $Out> {
  _EventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Event> $mapper = EventMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          EventType? type,
          String? headline,
          String? subtitle,
          Object? image = $none,
          Object? video = $none,
          DateTime? campaignStartDate,
          DateTime? campaignEndDate}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (headline != null) #headline: headline,
        if (subtitle != null) #subtitle: subtitle,
        if (image != $none) #image: image,
        if (video != $none) #video: video,
        if (campaignStartDate != null) #campaignStartDate: campaignStartDate,
        if (campaignEndDate != null) #campaignEndDate: campaignEndDate
      }));
  @override
  Event $make(CopyWithData data) => Event(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      headline: data.get(#headline, or: $value.headline),
      subtitle: data.get(#subtitle, or: $value.subtitle),
      image: data.get(#image, or: $value.image),
      video: data.get(#video, or: $value.video),
      campaignStartDate:
          data.get(#campaignStartDate, or: $value.campaignStartDate),
      campaignEndDate: data.get(#campaignEndDate, or: $value.campaignEndDate));

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
