// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vendor_sales.dart';

class VendorSalesMapper extends ClassMapperBase<VendorSales> {
  VendorSalesMapper._();

  static VendorSalesMapper? _instance;
  static VendorSalesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorSalesMapper._());
      VendorSalesRevenueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VendorSales';

  static VendorSalesRevenue _$venueRevenue(VendorSales v) => v.venueRevenue;
  static const Field<VendorSales, VendorSalesRevenue> _f$venueRevenue = Field(
    'venueRevenue',
    _$venueRevenue,
  );
  static VendorSalesRevenue _$eventTicketRevenue(VendorSales v) =>
      v.eventTicketRevenue;
  static const Field<VendorSales, VendorSalesRevenue> _f$eventTicketRevenue =
      Field('eventTicketRevenue', _$eventTicketRevenue);
  static int _$totalGuests(VendorSales v) => v.totalGuests;
  static const Field<VendorSales, int> _f$totalGuests = Field(
    'totalGuests',
    _$totalGuests,
  );
  static double _$averageRevenuePerGuest(VendorSales v) =>
      v.averageRevenuePerGuest;
  static const Field<VendorSales, double> _f$averageRevenuePerGuest = Field(
    'averageRevenuePerGuest',
    _$averageRevenuePerGuest,
  );
  static List<dynamic> _$dailyRevenue(VendorSales v) => v.dailyRevenue;
  static const Field<VendorSales, List<dynamic>> _f$dailyRevenue = Field(
    'dailyRevenue',
    _$dailyRevenue,
  );

  @override
  final MappableFields<VendorSales> fields = const {
    #venueRevenue: _f$venueRevenue,
    #eventTicketRevenue: _f$eventTicketRevenue,
    #totalGuests: _f$totalGuests,
    #averageRevenuePerGuest: _f$averageRevenuePerGuest,
    #dailyRevenue: _f$dailyRevenue,
  };

  static VendorSales _instantiate(DecodingData data) {
    return VendorSales(
      venueRevenue: data.dec(_f$venueRevenue),
      eventTicketRevenue: data.dec(_f$eventTicketRevenue),
      totalGuests: data.dec(_f$totalGuests),
      averageRevenuePerGuest: data.dec(_f$averageRevenuePerGuest),
      dailyRevenue: data.dec(_f$dailyRevenue),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VendorSales fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorSales>(map);
  }

  static VendorSales fromJson(String json) {
    return ensureInitialized().decodeJson<VendorSales>(json);
  }
}

mixin VendorSalesMappable {
  String toJson() {
    return VendorSalesMapper.ensureInitialized().encodeJson<VendorSales>(
      this as VendorSales,
    );
  }

  Map<String, dynamic> toMap() {
    return VendorSalesMapper.ensureInitialized().encodeMap<VendorSales>(
      this as VendorSales,
    );
  }

  VendorSalesCopyWith<VendorSales, VendorSales, VendorSales> get copyWith =>
      _VendorSalesCopyWithImpl<VendorSales, VendorSales>(
        this as VendorSales,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VendorSalesMapper.ensureInitialized().stringifyValue(
      this as VendorSales,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorSalesMapper.ensureInitialized().equalsValue(
      this as VendorSales,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorSalesMapper.ensureInitialized().hashValue(this as VendorSales);
  }
}

extension VendorSalesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorSales, $Out> {
  VendorSalesCopyWith<$R, VendorSales, $Out> get $asVendorSales =>
      $base.as((v, t, t2) => _VendorSalesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VendorSalesCopyWith<$R, $In extends VendorSales, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, VendorSalesRevenue>
  get venueRevenue;
  VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, VendorSalesRevenue>
  get eventTicketRevenue;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
  get dailyRevenue;
  $R call({
    VendorSalesRevenue? venueRevenue,
    VendorSalesRevenue? eventTicketRevenue,
    int? totalGuests,
    double? averageRevenuePerGuest,
    List<dynamic>? dailyRevenue,
  });
  VendorSalesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VendorSalesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorSales, $Out>
    implements VendorSalesCopyWith<$R, VendorSales, $Out> {
  _VendorSalesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorSales> $mapper =
      VendorSalesMapper.ensureInitialized();
  @override
  VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, VendorSalesRevenue>
  get venueRevenue =>
      $value.venueRevenue.copyWith.$chain((v) => call(venueRevenue: v));
  @override
  VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, VendorSalesRevenue>
  get eventTicketRevenue => $value.eventTicketRevenue.copyWith.$chain(
    (v) => call(eventTicketRevenue: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
  get dailyRevenue => ListCopyWith(
    $value.dailyRevenue,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(dailyRevenue: v),
  );
  @override
  $R call({
    VendorSalesRevenue? venueRevenue,
    VendorSalesRevenue? eventTicketRevenue,
    int? totalGuests,
    double? averageRevenuePerGuest,
    List<dynamic>? dailyRevenue,
  }) => $apply(
    FieldCopyWithData({
      if (venueRevenue != null) #venueRevenue: venueRevenue,
      if (eventTicketRevenue != null) #eventTicketRevenue: eventTicketRevenue,
      if (totalGuests != null) #totalGuests: totalGuests,
      if (averageRevenuePerGuest != null)
        #averageRevenuePerGuest: averageRevenuePerGuest,
      if (dailyRevenue != null) #dailyRevenue: dailyRevenue,
    }),
  );
  @override
  VendorSales $make(CopyWithData data) => VendorSales(
    venueRevenue: data.get(#venueRevenue, or: $value.venueRevenue),
    eventTicketRevenue: data.get(
      #eventTicketRevenue,
      or: $value.eventTicketRevenue,
    ),
    totalGuests: data.get(#totalGuests, or: $value.totalGuests),
    averageRevenuePerGuest: data.get(
      #averageRevenuePerGuest,
      or: $value.averageRevenuePerGuest,
    ),
    dailyRevenue: data.get(#dailyRevenue, or: $value.dailyRevenue),
  );

  @override
  VendorSalesCopyWith<$R2, VendorSales, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VendorSalesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VendorSalesRevenueMapper extends ClassMapperBase<VendorSalesRevenue> {
  VendorSalesRevenueMapper._();

  static VendorSalesRevenueMapper? _instance;
  static VendorSalesRevenueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VendorSalesRevenueMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VendorSalesRevenue';

  static double _$amount(VendorSalesRevenue v) => v.amount;
  static const Field<VendorSalesRevenue, double> _f$amount = Field(
    'amount',
    _$amount,
  );
  static String _$currency(VendorSalesRevenue v) => v.currency;
  static const Field<VendorSalesRevenue, String> _f$currency = Field(
    'currency',
    _$currency,
  );

  @override
  final MappableFields<VendorSalesRevenue> fields = const {
    #amount: _f$amount,
    #currency: _f$currency,
  };

  static VendorSalesRevenue _instantiate(DecodingData data) {
    return VendorSalesRevenue(
      amount: data.dec(_f$amount),
      currency: data.dec(_f$currency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VendorSalesRevenue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VendorSalesRevenue>(map);
  }

  static VendorSalesRevenue fromJson(String json) {
    return ensureInitialized().decodeJson<VendorSalesRevenue>(json);
  }
}

mixin VendorSalesRevenueMappable {
  String toJson() {
    return VendorSalesRevenueMapper.ensureInitialized()
        .encodeJson<VendorSalesRevenue>(this as VendorSalesRevenue);
  }

  Map<String, dynamic> toMap() {
    return VendorSalesRevenueMapper.ensureInitialized()
        .encodeMap<VendorSalesRevenue>(this as VendorSalesRevenue);
  }

  VendorSalesRevenueCopyWith<
    VendorSalesRevenue,
    VendorSalesRevenue,
    VendorSalesRevenue
  >
  get copyWith =>
      _VendorSalesRevenueCopyWithImpl<VendorSalesRevenue, VendorSalesRevenue>(
        this as VendorSalesRevenue,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VendorSalesRevenueMapper.ensureInitialized().stringifyValue(
      this as VendorSalesRevenue,
    );
  }

  @override
  bool operator ==(Object other) {
    return VendorSalesRevenueMapper.ensureInitialized().equalsValue(
      this as VendorSalesRevenue,
      other,
    );
  }

  @override
  int get hashCode {
    return VendorSalesRevenueMapper.ensureInitialized().hashValue(
      this as VendorSalesRevenue,
    );
  }
}

extension VendorSalesRevenueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VendorSalesRevenue, $Out> {
  VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, $Out>
  get $asVendorSalesRevenue => $base.as(
    (v, t, t2) => _VendorSalesRevenueCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VendorSalesRevenueCopyWith<
  $R,
  $In extends VendorSalesRevenue,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? amount, String? currency});
  VendorSalesRevenueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VendorSalesRevenueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VendorSalesRevenue, $Out>
    implements VendorSalesRevenueCopyWith<$R, VendorSalesRevenue, $Out> {
  _VendorSalesRevenueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VendorSalesRevenue> $mapper =
      VendorSalesRevenueMapper.ensureInitialized();
  @override
  $R call({double? amount, String? currency}) => $apply(
    FieldCopyWithData({
      if (amount != null) #amount: amount,
      if (currency != null) #currency: currency,
    }),
  );
  @override
  VendorSalesRevenue $make(CopyWithData data) => VendorSalesRevenue(
    amount: data.get(#amount, or: $value.amount),
    currency: data.get(#currency, or: $value.currency),
  );

  @override
  VendorSalesRevenueCopyWith<$R2, VendorSalesRevenue, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VendorSalesRevenueCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

