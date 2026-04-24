// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vendor_booking_response.dart';

class VendorBookingResponseMapper
    extends ClassMapperBase<VendorBookingResponse> {
  VendorBookingResponseMapper._();

  static VendorBookingResponseMapper? _instance;
  static VendorBookingResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorBookingResponseMapper._());
      VendorBookingItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VendorBookingResponse';

  static List<VendorBookingItem> _$items(VendorBookingResponse v) => v.items;
  static const Field<VendorBookingResponse, List<VendorBookingItem>> _f$items =
      Field('items', _$items);

  @override
  final MappableFields<VendorBookingResponse> fields = const {#items: _f$items};

  static VendorBookingResponse _instantiate(DecodingData data) {
    return VendorBookingResponse(items: data.dec(_f$items));
  }

  @override
  final Function instantiate = _instantiate;

  static VendorBookingResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorBookingResponse>(map);
  }

  static VendorBookingResponse fromJson(String json) {
    return ensureInitialized().decodeJson<VendorBookingResponse>(json);
  }
}

mixin VendorBookingResponseMappable {
  String toJson() {
    return VendorBookingResponseMapper.ensureInitialized()
        .encodeJson<VendorBookingResponse>(this as VendorBookingResponse);
  }

  Map<String, dynamic> toMap() {
    return VendorBookingResponseMapper.ensureInitialized()
        .encodeMap<VendorBookingResponse>(this as VendorBookingResponse);
  }

  VendorBookingResponseCopyWith<
    VendorBookingResponse,
    VendorBookingResponse,
    VendorBookingResponse
  >
  get copyWith =>
      _VendorBookingResponseCopyWithImpl<
        VendorBookingResponse,
        VendorBookingResponse
      >(this as VendorBookingResponse, $identity, $identity);
  @override
  String toString() {
    return VendorBookingResponseMapper.ensureInitialized().stringifyValue(
      this as VendorBookingResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorBookingResponseMapper.ensureInitialized().equalsValue(
      this as VendorBookingResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorBookingResponseMapper.ensureInitialized().hashValue(
      this as VendorBookingResponse,
    );
  }
}

extension VendorBookingResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorBookingResponse, $Out> {
  VendorBookingResponseCopyWith<$R, VendorBookingResponse, $Out>
  get $asVendorBookingResponse => $base.as(
    (v, t, t2) => _VendorBookingResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VendorBookingResponseCopyWith<
  $R,
  $In extends VendorBookingResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    VendorBookingItem,
    VendorBookingItemCopyWith<$R, VendorBookingItem, VendorBookingItem>
  >
  get items;
  $R call({List<VendorBookingItem>? items});
  VendorBookingResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VendorBookingResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorBookingResponse, $Out>
    implements VendorBookingResponseCopyWith<$R, VendorBookingResponse, $Out> {
  _VendorBookingResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorBookingResponse> $mapper =
      VendorBookingResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    VendorBookingItem,
    VendorBookingItemCopyWith<$R, VendorBookingItem, VendorBookingItem>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<VendorBookingItem>? items}) =>
      $apply(FieldCopyWithData({if (items != null) #items: items}));
  @override
  VendorBookingResponse $make(CopyWithData data) =>
      VendorBookingResponse(items: data.get(#items, or: $value.items));

  @override
  VendorBookingResponseCopyWith<$R2, VendorBookingResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VendorBookingResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VendorBookingItemMapper extends ClassMapperBase<VendorBookingItem> {
  VendorBookingItemMapper._();

  static VendorBookingItemMapper? _instance;
  static VendorBookingItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorBookingItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VendorBookingItem';

  static String _$id(VendorBookingItem v) => v.id;
  static const Field<VendorBookingItem, String> _f$id = Field('id', _$id);
  static String _$displayCode(VendorBookingItem v) => v.displayCode;
  static const Field<VendorBookingItem, String> _f$displayCode = Field(
    'displayCode',
    _$displayCode,
  );
  static String _$fullName(VendorBookingItem v) => v.fullName;
  static const Field<VendorBookingItem, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static DateTime _$bookingDate(VendorBookingItem v) => v.bookingDate;
  static const Field<VendorBookingItem, DateTime> _f$bookingDate = Field(
    'bookingDate',
    _$bookingDate,
  );
  static RsvStatus _$uiStatus(VendorBookingItem v) => v.uiStatus;
  static const Field<VendorBookingItem, RsvStatus> _f$uiStatus = Field(
    'uiStatus',
    _$uiStatus,
    hook: RsvStatusHook(),
  );

  @override
  final MappableFields<VendorBookingItem> fields = const {
    #id: _f$id,
    #displayCode: _f$displayCode,
    #fullName: _f$fullName,
    #bookingDate: _f$bookingDate,
    #uiStatus: _f$uiStatus,
  };

  static VendorBookingItem _instantiate(DecodingData data) {
    return VendorBookingItem(
      id: data.dec(_f$id),
      displayCode: data.dec(_f$displayCode),
      fullName: data.dec(_f$fullName),
      bookingDate: data.dec(_f$bookingDate),
      uiStatus: data.dec(_f$uiStatus),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VendorBookingItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorBookingItem>(map);
  }

  static VendorBookingItem fromJson(String json) {
    return ensureInitialized().decodeJson<VendorBookingItem>(json);
  }
}

mixin VendorBookingItemMappable {
  String toJson() {
    return VendorBookingItemMapper.ensureInitialized()
        .encodeJson<VendorBookingItem>(this as VendorBookingItem);
  }

  Map<String, dynamic> toMap() {
    return VendorBookingItemMapper.ensureInitialized()
        .encodeMap<VendorBookingItem>(this as VendorBookingItem);
  }

  VendorBookingItemCopyWith<
    VendorBookingItem,
    VendorBookingItem,
    VendorBookingItem
  >
  get copyWith =>
      _VendorBookingItemCopyWithImpl<VendorBookingItem, VendorBookingItem>(
        this as VendorBookingItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VendorBookingItemMapper.ensureInitialized().stringifyValue(
      this as VendorBookingItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorBookingItemMapper.ensureInitialized().equalsValue(
      this as VendorBookingItem,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorBookingItemMapper.ensureInitialized().hashValue(
      this as VendorBookingItem,
    );
  }
}

extension VendorBookingItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorBookingItem, $Out> {
  VendorBookingItemCopyWith<$R, VendorBookingItem, $Out>
  get $asVendorBookingItem => $base.as(
    (v, t, t2) => _VendorBookingItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VendorBookingItemCopyWith<
  $R,
  $In extends VendorBookingItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? displayCode,
    String? fullName,
    DateTime? bookingDate,
    RsvStatus? uiStatus,
  });
  VendorBookingItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VendorBookingItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorBookingItem, $Out>
    implements VendorBookingItemCopyWith<$R, VendorBookingItem, $Out> {
  _VendorBookingItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorBookingItem> $mapper =
      VendorBookingItemMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? displayCode,
    String? fullName,
    DateTime? bookingDate,
    RsvStatus? uiStatus,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (displayCode != null) #displayCode: displayCode,
      if (fullName != null) #fullName: fullName,
      if (bookingDate != null) #bookingDate: bookingDate,
      if (uiStatus != null) #uiStatus: uiStatus,
    }),
  );
  @override
  VendorBookingItem $make(CopyWithData data) => VendorBookingItem(
    id: data.get(#id, or: $value.id),
    displayCode: data.get(#displayCode, or: $value.displayCode),
    fullName: data.get(#fullName, or: $value.fullName),
    bookingDate: data.get(#bookingDate, or: $value.bookingDate),
    uiStatus: data.get(#uiStatus, or: $value.uiStatus),
  );

  @override
  VendorBookingItemCopyWith<$R2, VendorBookingItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VendorBookingItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

