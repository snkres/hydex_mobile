// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_filters.dart';

class SearchFiltersMapper extends ClassMapperBase<SearchFilters> {
  SearchFiltersMapper._();

  static SearchFiltersMapper? _instance;
  static SearchFiltersMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchFiltersMapper._());
      PriceTypeMapper.ensureInitialized();
      CoordinatesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchFilters';

  static String? _$categoryId(SearchFilters v) => v.categoryId;
  static const Field<SearchFilters, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    opt: true,
  );
  static PriceType? _$priceType(SearchFilters v) => v.priceType;
  static const Field<SearchFilters, PriceType> _f$priceType = Field(
    'priceType',
    _$priceType,
    opt: true,
  );
  static bool? _$openNow(SearchFilters v) => v.openNow;
  static const Field<SearchFilters, bool> _f$openNow = Field(
    'openNow',
    _$openNow,
    opt: true,
  );
  static String? _$query(SearchFilters v) => v.query;
  static const Field<SearchFilters, String> _f$query = Field(
    'query',
    _$query,
    opt: true,
  );
  static Coordinates? _$coordinates(SearchFilters v) => v.coordinates;
  static const Field<SearchFilters, Coordinates> _f$coordinates = Field(
    'coordinates',
    _$coordinates,
    opt: true,
  );
  static int? _$distance(SearchFilters v) => v.distance;
  static const Field<SearchFilters, int> _f$distance = Field(
    'distance',
    _$distance,
    opt: true,
  );

  @override
  final MappableFields<SearchFilters> fields = const {
    #categoryId: _f$categoryId,
    #priceType: _f$priceType,
    #openNow: _f$openNow,
    #query: _f$query,
    #coordinates: _f$coordinates,
    #distance: _f$distance,
  };

  static SearchFilters _instantiate(DecodingData data) {
    return SearchFilters(
      categoryId: data.dec(_f$categoryId),
      priceType: data.dec(_f$priceType),
      openNow: data.dec(_f$openNow),
      query: data.dec(_f$query),
      coordinates: data.dec(_f$coordinates),
      distance: data.dec(_f$distance),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SearchFilters fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchFilters>(map);
  }

  static SearchFilters fromJson(String json) {
    return ensureInitialized().decodeJson<SearchFilters>(json);
  }
}

mixin SearchFiltersMappable {
  String toJson() {
    return SearchFiltersMapper.ensureInitialized().encodeJson<SearchFilters>(
      this as SearchFilters,
    );
  }

  Map<String, dynamic> toMap() {
    return SearchFiltersMapper.ensureInitialized().encodeMap<SearchFilters>(
      this as SearchFilters,
    );
  }

  SearchFiltersCopyWith<SearchFilters, SearchFilters, SearchFilters>
  get copyWith => _SearchFiltersCopyWithImpl<SearchFilters, SearchFilters>(
    this as SearchFilters,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SearchFiltersMapper.ensureInitialized().stringifyValue(
      this as SearchFilters,
    );
  }

  @override
  bool operator ==(Object other) {
    return SearchFiltersMapper.ensureInitialized().equalsValue(
      this as SearchFilters,
      other,
    );
  }

  @override
  int get hashCode {
    return SearchFiltersMapper.ensureInitialized().hashValue(
      this as SearchFilters,
    );
  }
}

extension SearchFiltersValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchFilters, $Out> {
  SearchFiltersCopyWith<$R, SearchFilters, $Out> get $asSearchFilters =>
      $base.as((v, t, t2) => _SearchFiltersCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SearchFiltersCopyWith<$R, $In extends SearchFilters, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CoordinatesCopyWith<$R, Coordinates, Coordinates>? get coordinates;
  $R call({
    String? categoryId,
    PriceType? priceType,
    bool? openNow,
    String? query,
    Coordinates? coordinates,
    int? distance,
  });
  SearchFiltersCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchFiltersCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchFilters, $Out>
    implements SearchFiltersCopyWith<$R, SearchFilters, $Out> {
  _SearchFiltersCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchFilters> $mapper =
      SearchFiltersMapper.ensureInitialized();
  @override
  CoordinatesCopyWith<$R, Coordinates, Coordinates>? get coordinates =>
      $value.coordinates?.copyWith.$chain((v) => call(coordinates: v));
  @override
  $R call({
    Object? categoryId = $none,
    Object? priceType = $none,
    Object? openNow = $none,
    Object? query = $none,
    Object? coordinates = $none,
    Object? distance = $none,
  }) => $apply(
    FieldCopyWithData({
      if (categoryId != $none) #categoryId: categoryId,
      if (priceType != $none) #priceType: priceType,
      if (openNow != $none) #openNow: openNow,
      if (query != $none) #query: query,
      if (coordinates != $none) #coordinates: coordinates,
      if (distance != $none) #distance: distance,
    }),
  );
  @override
  SearchFilters $make(CopyWithData data) => SearchFilters(
    categoryId: data.get(#categoryId, or: $value.categoryId),
    priceType: data.get(#priceType, or: $value.priceType),
    openNow: data.get(#openNow, or: $value.openNow),
    query: data.get(#query, or: $value.query),
    coordinates: data.get(#coordinates, or: $value.coordinates),
    distance: data.get(#distance, or: $value.distance),
  );

  @override
  SearchFiltersCopyWith<$R2, SearchFilters, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SearchFiltersCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

