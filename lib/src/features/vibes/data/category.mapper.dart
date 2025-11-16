// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'category.dart';

class EventCategoryMapper extends ClassMapperBase<EventCategory> {
  EventCategoryMapper._();

  static EventCategoryMapper? _instance;
  static EventCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventCategoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventCategory';

  static String _$id(EventCategory v) => v.id;
  static const Field<EventCategory, String> _f$id = Field('id', _$id);
  static String _$description(EventCategory v) => v.description;
  static const Field<EventCategory, String> _f$description = Field(
    'description',
    _$description,
  );
  static String? _$image(EventCategory v) => v.image;
  static const Field<EventCategory, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static String _$name(EventCategory v) => v.name;
  static const Field<EventCategory, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<EventCategory> fields = const {
    #id: _f$id,
    #description: _f$description,
    #image: _f$image,
    #name: _f$name,
  };

  static EventCategory _instantiate(DecodingData data) {
    return EventCategory(
      id: data.dec(_f$id),
      description: data.dec(_f$description),
      image: data.dec(_f$image),
      name: data.dec(_f$name),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventCategory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventCategory>(map);
  }

  static EventCategory fromJson(String json) {
    return ensureInitialized().decodeJson<EventCategory>(json);
  }
}

mixin EventCategoryMappable {
  String toJson() {
    return EventCategoryMapper.ensureInitialized().encodeJson<EventCategory>(
      this as EventCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return EventCategoryMapper.ensureInitialized().encodeMap<EventCategory>(
      this as EventCategory,
    );
  }

  EventCategoryCopyWith<EventCategory, EventCategory, EventCategory>
  get copyWith => _EventCategoryCopyWithImpl<EventCategory, EventCategory>(
    this as EventCategory,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return EventCategoryMapper.ensureInitialized().stringifyValue(
      this as EventCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventCategoryMapper.ensureInitialized().equalsValue(
      this as EventCategory,
      other,
    );
  }

  @override
  int get hashCode {
    return EventCategoryMapper.ensureInitialized().hashValue(
      this as EventCategory,
    );
  }
}

extension EventCategoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventCategory, $Out> {
  EventCategoryCopyWith<$R, EventCategory, $Out> get $asEventCategory =>
      $base.as((v, t, t2) => _EventCategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventCategoryCopyWith<$R, $In extends EventCategory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? description, String? image, String? name});
  EventCategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventCategory, $Out>
    implements EventCategoryCopyWith<$R, EventCategory, $Out> {
  _EventCategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventCategory> $mapper =
      EventCategoryMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? description,
    Object? image = $none,
    String? name,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (description != null) #description: description,
      if (image != $none) #image: image,
      if (name != null) #name: name,
    }),
  );
  @override
  EventCategory $make(CopyWithData data) => EventCategory(
    id: data.get(#id, or: $value.id),
    description: data.get(#description, or: $value.description),
    image: data.get(#image, or: $value.image),
    name: data.get(#name, or: $value.name),
  );

  @override
  EventCategoryCopyWith<$R2, EventCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

