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
      SubCategoriesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventCategory';

  static String? _$id(EventCategory v) => v.id;
  static const Field<EventCategory, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
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
  static List<SubCategories>? _$subCategories(EventCategory v) =>
      v.subCategories;
  static const Field<EventCategory, List<SubCategories>> _f$subCategories =
      Field('subCategories', _$subCategories, opt: true, def: const []);

  @override
  final MappableFields<EventCategory> fields = const {
    #id: _f$id,
    #description: _f$description,
    #image: _f$image,
    #name: _f$name,
    #subCategories: _f$subCategories,
  };

  static EventCategory _instantiate(DecodingData data) {
    return EventCategory(
      id: data.dec(_f$id),
      description: data.dec(_f$description),
      image: data.dec(_f$image),
      name: data.dec(_f$name),
      subCategories: data.dec(_f$subCategories),
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
  ListCopyWith<
    $R,
    SubCategories,
    SubCategoriesCopyWith<$R, SubCategories, SubCategories>
  >?
  get subCategories;
  $R call({
    String? id,
    String? description,
    String? image,
    String? name,
    List<SubCategories>? subCategories,
  });
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
  ListCopyWith<
    $R,
    SubCategories,
    SubCategoriesCopyWith<$R, SubCategories, SubCategories>
  >?
  get subCategories => $value.subCategories != null
      ? ListCopyWith(
          $value.subCategories!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(subCategories: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    String? description,
    Object? image = $none,
    String? name,
    Object? subCategories = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (description != null) #description: description,
      if (image != $none) #image: image,
      if (name != null) #name: name,
      if (subCategories != $none) #subCategories: subCategories,
    }),
  );
  @override
  EventCategory $make(CopyWithData data) => EventCategory(
    id: data.get(#id, or: $value.id),
    description: data.get(#description, or: $value.description),
    image: data.get(#image, or: $value.image),
    name: data.get(#name, or: $value.name),
    subCategories: data.get(#subCategories, or: $value.subCategories),
  );

  @override
  EventCategoryCopyWith<$R2, EventCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SubCategoriesMapper extends ClassMapperBase<SubCategories> {
  SubCategoriesMapper._();

  static SubCategoriesMapper? _instance;
  static SubCategoriesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubCategoriesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SubCategories';

  static String _$id(SubCategories v) => v.id;
  static const Field<SubCategories, String> _f$id = Field('id', _$id);
  static String? _$title(SubCategories v) => v.title;
  static const Field<SubCategories, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$description(SubCategories v) => v.description;
  static const Field<SubCategories, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$imageUrl(SubCategories v) => v.imageUrl;
  static const Field<SubCategories, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    opt: true,
  );

  @override
  final MappableFields<SubCategories> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #imageUrl: _f$imageUrl,
  };

  static SubCategories _instantiate(DecodingData data) {
    return SubCategories(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      imageUrl: data.dec(_f$imageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SubCategories fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubCategories>(map);
  }

  static SubCategories fromJson(String json) {
    return ensureInitialized().decodeJson<SubCategories>(json);
  }
}

mixin SubCategoriesMappable {
  String toJson() {
    return SubCategoriesMapper.ensureInitialized().encodeJson<SubCategories>(
      this as SubCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return SubCategoriesMapper.ensureInitialized().encodeMap<SubCategories>(
      this as SubCategories,
    );
  }

  SubCategoriesCopyWith<SubCategories, SubCategories, SubCategories>
  get copyWith => _SubCategoriesCopyWithImpl<SubCategories, SubCategories>(
    this as SubCategories,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SubCategoriesMapper.ensureInitialized().stringifyValue(
      this as SubCategories,
    );
  }

  @override
  bool operator ==(Object other) {
    return SubCategoriesMapper.ensureInitialized().equalsValue(
      this as SubCategories,
      other,
    );
  }

  @override
  int get hashCode {
    return SubCategoriesMapper.ensureInitialized().hashValue(
      this as SubCategories,
    );
  }
}

extension SubCategoriesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SubCategories, $Out> {
  SubCategoriesCopyWith<$R, SubCategories, $Out> get $asSubCategories =>
      $base.as((v, t, t2) => _SubCategoriesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SubCategoriesCopyWith<$R, $In extends SubCategories, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? description, String? imageUrl});
  SubCategoriesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SubCategoriesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SubCategories, $Out>
    implements SubCategoriesCopyWith<$R, SubCategories, $Out> {
  _SubCategoriesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SubCategories> $mapper =
      SubCategoriesMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? title = $none,
    Object? description = $none,
    Object? imageUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != $none) #title: title,
      if (description != $none) #description: description,
      if (imageUrl != $none) #imageUrl: imageUrl,
    }),
  );
  @override
  SubCategories $make(CopyWithData data) => SubCategories(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
  );

  @override
  SubCategoriesCopyWith<$R2, SubCategories, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SubCategoriesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VendorCategoryMapper extends ClassMapperBase<VendorCategory> {
  VendorCategoryMapper._();

  static VendorCategoryMapper? _instance;
  static VendorCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorCategoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VendorCategory';

  static String _$name(VendorCategory v) => v.name;
  static const Field<VendorCategory, String> _f$name = Field('name', _$name);
  static String? _$image(VendorCategory v) => v.image;
  static const Field<VendorCategory, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );

  @override
  final MappableFields<VendorCategory> fields = const {
    #name: _f$name,
    #image: _f$image,
  };

  static VendorCategory _instantiate(DecodingData data) {
    return VendorCategory(name: data.dec(_f$name), image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static VendorCategory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorCategory>(map);
  }

  static VendorCategory fromJson(String json) {
    return ensureInitialized().decodeJson<VendorCategory>(json);
  }
}

mixin VendorCategoryMappable {
  String toJson() {
    return VendorCategoryMapper.ensureInitialized().encodeJson<VendorCategory>(
      this as VendorCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return VendorCategoryMapper.ensureInitialized().encodeMap<VendorCategory>(
      this as VendorCategory,
    );
  }

  VendorCategoryCopyWith<VendorCategory, VendorCategory, VendorCategory>
  get copyWith => _VendorCategoryCopyWithImpl<VendorCategory, VendorCategory>(
    this as VendorCategory,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return VendorCategoryMapper.ensureInitialized().stringifyValue(
      this as VendorCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorCategoryMapper.ensureInitialized().equalsValue(
      this as VendorCategory,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorCategoryMapper.ensureInitialized().hashValue(
      this as VendorCategory,
    );
  }
}

extension VendorCategoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorCategory, $Out> {
  VendorCategoryCopyWith<$R, VendorCategory, $Out> get $asVendorCategory =>
      $base.as((v, t, t2) => _VendorCategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VendorCategoryCopyWith<$R, $In extends VendorCategory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? image});
  VendorCategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VendorCategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorCategory, $Out>
    implements VendorCategoryCopyWith<$R, VendorCategory, $Out> {
  _VendorCategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorCategory> $mapper =
      VendorCategoryMapper.ensureInitialized();
  @override
  $R call({String? name, Object? image = $none}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (image != $none) #image: image,
    }),
  );
  @override
  VendorCategory $make(CopyWithData data) => VendorCategory(
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
  );

  @override
  VendorCategoryCopyWith<$R2, VendorCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VendorCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

