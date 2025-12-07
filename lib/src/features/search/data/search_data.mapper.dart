// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_data.dart';

class SearchDataMapper extends ClassMapperBase<SearchData> {
  SearchDataMapper._();

  static SearchDataMapper? _instance;
  static SearchDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchDataMapper._());
      VendorMapper.ensureInitialized();
      SearchEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchData';

  static List<Vendor>? _$vendors(SearchData v) => v.vendors;
  static const Field<SearchData, List<Vendor>> _f$vendors = Field(
    'vendors',
    _$vendors,
    opt: true,
  );
  static List<SearchEvent>? _$events(SearchData v) => v.events;
  static const Field<SearchData, List<SearchEvent>> _f$events = Field(
    'events',
    _$events,
    opt: true,
  );

  @override
  final MappableFields<SearchData> fields = const {
    #vendors: _f$vendors,
    #events: _f$events,
  };

  static SearchData _instantiate(DecodingData data) {
    return SearchData(
      vendors: data.dec(_f$vendors),
      events: data.dec(_f$events),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SearchData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchData>(map);
  }

  static SearchData fromJson(String json) {
    return ensureInitialized().decodeJson<SearchData>(json);
  }
}

mixin SearchDataMappable {
  String toJson() {
    return SearchDataMapper.ensureInitialized().encodeJson<SearchData>(
      this as SearchData,
    );
  }

  Map<String, dynamic> toMap() {
    return SearchDataMapper.ensureInitialized().encodeMap<SearchData>(
      this as SearchData,
    );
  }

  SearchDataCopyWith<SearchData, SearchData, SearchData> get copyWith =>
      _SearchDataCopyWithImpl<SearchData, SearchData>(
        this as SearchData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SearchDataMapper.ensureInitialized().stringifyValue(
      this as SearchData,
    );
  }

  @override
  bool operator ==(Object other) {
    return SearchDataMapper.ensureInitialized().equalsValue(
      this as SearchData,
      other,
    );
  }

  @override
  int get hashCode {
    return SearchDataMapper.ensureInitialized().hashValue(this as SearchData);
  }
}

extension SearchDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchData, $Out> {
  SearchDataCopyWith<$R, SearchData, $Out> get $asSearchData =>
      $base.as((v, t, t2) => _SearchDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SearchDataCopyWith<$R, $In extends SearchData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Vendor, VendorCopyWith<$R, Vendor, Vendor>>? get vendors;
  ListCopyWith<
    $R,
    SearchEvent,
    SearchEventCopyWith<$R, SearchEvent, SearchEvent>
  >?
  get events;
  $R call({List<Vendor>? vendors, List<SearchEvent>? events});
  SearchDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchData, $Out>
    implements SearchDataCopyWith<$R, SearchData, $Out> {
  _SearchDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchData> $mapper =
      SearchDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Vendor, VendorCopyWith<$R, Vendor, Vendor>>? get vendors =>
      $value.vendors != null
      ? ListCopyWith(
          $value.vendors!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(vendors: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    SearchEvent,
    SearchEventCopyWith<$R, SearchEvent, SearchEvent>
  >?
  get events => $value.events != null
      ? ListCopyWith(
          $value.events!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(events: v),
        )
      : null;
  @override
  $R call({Object? vendors = $none, Object? events = $none}) => $apply(
    FieldCopyWithData({
      if (vendors != $none) #vendors: vendors,
      if (events != $none) #events: events,
    }),
  );
  @override
  SearchData $make(CopyWithData data) => SearchData(
    vendors: data.get(#vendors, or: $value.vendors),
    events: data.get(#events, or: $value.events),
  );

  @override
  SearchDataCopyWith<$R2, SearchData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SearchDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SearchEventMapper extends ClassMapperBase<SearchEvent> {
  SearchEventMapper._();

  static SearchEventMapper? _instance;
  static SearchEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchEventMapper._());
      CategoryNoDescMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchEvent';

  static String _$id(SearchEvent v) => v.id;
  static const Field<SearchEvent, String> _f$id = Field('id', _$id);
  static String _$name(SearchEvent v) => v.name;
  static const Field<SearchEvent, String> _f$name = Field('name', _$name);
  static String _$description(SearchEvent v) => v.description;
  static const Field<SearchEvent, String> _f$description = Field(
    'description',
    _$description,
  );
  static CategoryNoDesc _$category(SearchEvent v) => v.category;
  static const Field<SearchEvent, CategoryNoDesc> _f$category = Field(
    'category',
    _$category,
  );
  static String _$priceType(SearchEvent v) => v.priceType;
  static const Field<SearchEvent, String> _f$priceType = Field(
    'priceType',
    _$priceType,
  );
  static Location _$location(SearchEvent v) => v.location;
  static const Field<SearchEvent, Location> _f$location = Field(
    'location',
    _$location,
  );
  static List<String> _$media(SearchEvent v) => v.media;
  static const Field<SearchEvent, List<String>> _f$media = Field(
    'media',
    _$media,
  );

  @override
  final MappableFields<SearchEvent> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #category: _f$category,
    #priceType: _f$priceType,
    #location: _f$location,
    #media: _f$media,
  };

  static SearchEvent _instantiate(DecodingData data) {
    return SearchEvent(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      category: data.dec(_f$category),
      priceType: data.dec(_f$priceType),
      location: data.dec(_f$location),
      media: data.dec(_f$media),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SearchEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchEvent>(map);
  }

  static SearchEvent fromJson(String json) {
    return ensureInitialized().decodeJson<SearchEvent>(json);
  }
}

mixin SearchEventMappable {
  String toJson() {
    return SearchEventMapper.ensureInitialized().encodeJson<SearchEvent>(
      this as SearchEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return SearchEventMapper.ensureInitialized().encodeMap<SearchEvent>(
      this as SearchEvent,
    );
  }

  SearchEventCopyWith<SearchEvent, SearchEvent, SearchEvent> get copyWith =>
      _SearchEventCopyWithImpl<SearchEvent, SearchEvent>(
        this as SearchEvent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SearchEventMapper.ensureInitialized().stringifyValue(
      this as SearchEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return SearchEventMapper.ensureInitialized().equalsValue(
      this as SearchEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return SearchEventMapper.ensureInitialized().hashValue(this as SearchEvent);
  }
}

extension SearchEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchEvent, $Out> {
  SearchEventCopyWith<$R, SearchEvent, $Out> get $asSearchEvent =>
      $base.as((v, t, t2) => _SearchEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SearchEventCopyWith<$R, $In extends SearchEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc> get category;
  LocationCopyWith<$R, Location, Location> get location;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media;
  $R call({
    String? id,
    String? name,
    String? description,
    CategoryNoDesc? category,
    String? priceType,
    Location? location,
    List<String>? media,
  });
  SearchEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchEvent, $Out>
    implements SearchEventCopyWith<$R, SearchEvent, $Out> {
  _SearchEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchEvent> $mapper =
      SearchEventMapper.ensureInitialized();
  @override
  CategoryNoDescCopyWith<$R, CategoryNoDesc, CategoryNoDesc> get category =>
      $value.category.copyWith.$chain((v) => call(category: v));
  @override
  LocationCopyWith<$R, Location, Location> get location =>
      $value.location.copyWith.$chain((v) => call(location: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get media =>
      ListCopyWith(
        $value.media,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(media: v),
      );
  @override
  $R call({
    String? id,
    String? name,
    String? description,
    CategoryNoDesc? category,
    String? priceType,
    Location? location,
    List<String>? media,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (category != null) #category: category,
      if (priceType != null) #priceType: priceType,
      if (location != null) #location: location,
      if (media != null) #media: media,
    }),
  );
  @override
  SearchEvent $make(CopyWithData data) => SearchEvent(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    category: data.get(#category, or: $value.category),
    priceType: data.get(#priceType, or: $value.priceType),
    location: data.get(#location, or: $value.location),
    media: data.get(#media, or: $value.media),
  );

  @override
  SearchEventCopyWith<$R2, SearchEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SearchEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

