// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'owner_event.dart';

class OwnerEventMapper extends ClassMapperBase<OwnerEvent> {
  OwnerEventMapper._();

  static OwnerEventMapper? _instance;
  static OwnerEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerEventMapper._());
      EventStatusMapper.ensureInitialized();
      OwnerEventSalesMapper.ensureInitialized();
      OwnerEventRevenueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OwnerEvent';

  static String _$id(OwnerEvent v) => v.id;
  static const Field<OwnerEvent, String> _f$id = Field('id', _$id);
  static String _$displayCode(OwnerEvent v) => v.displayCode;
  static const Field<OwnerEvent, String> _f$displayCode = Field(
    'displayCode',
    _$displayCode,
  );
  static String _$name(OwnerEvent v) => v.name;
  static const Field<OwnerEvent, String> _f$name = Field('name', _$name);
  static DateTime _$startTime(OwnerEvent v) => v.startTime;
  static const Field<OwnerEvent, DateTime> _f$startTime = Field(
    'startTime',
    _$startTime,
  );
  static DateTime _$endTime(OwnerEvent v) => v.endTime;
  static const Field<OwnerEvent, DateTime> _f$endTime = Field(
    'endTime',
    _$endTime,
  );
  static String? _$timeLabel(OwnerEvent v) => v.timeLabel;
  static const Field<OwnerEvent, String> _f$timeLabel = Field(
    'timeLabel',
    _$timeLabel,
    opt: true,
  );
  static EventStatus _$status(OwnerEvent v) => v.status;
  static const Field<OwnerEvent, EventStatus> _f$status = Field(
    'status',
    _$status,
    key: r'uiStatus',
  );
  static OwnerEventSales _$sales(OwnerEvent v) => v.sales;
  static const Field<OwnerEvent, OwnerEventSales> _f$sales = Field(
    'sales',
    _$sales,
  );
  static OwnerEventRevenue _$revenue(OwnerEvent v) => v.revenue;
  static const Field<OwnerEvent, OwnerEventRevenue> _f$revenue = Field(
    'revenue',
    _$revenue,
  );

  @override
  final MappableFields<OwnerEvent> fields = const {
    #id: _f$id,
    #displayCode: _f$displayCode,
    #name: _f$name,
    #startTime: _f$startTime,
    #endTime: _f$endTime,
    #timeLabel: _f$timeLabel,
    #status: _f$status,
    #sales: _f$sales,
    #revenue: _f$revenue,
  };

  static OwnerEvent _instantiate(DecodingData data) {
    return OwnerEvent(
      id: data.dec(_f$id),
      displayCode: data.dec(_f$displayCode),
      name: data.dec(_f$name),
      startTime: data.dec(_f$startTime),
      endTime: data.dec(_f$endTime),
      timeLabel: data.dec(_f$timeLabel),
      status: data.dec(_f$status),
      sales: data.dec(_f$sales),
      revenue: data.dec(_f$revenue),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OwnerEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OwnerEvent>(map);
  }

  static OwnerEvent fromJson(String json) {
    return ensureInitialized().decodeJson<OwnerEvent>(json);
  }
}

mixin OwnerEventMappable {
  String toJson() {
    return OwnerEventMapper.ensureInitialized().encodeJson<OwnerEvent>(
      this as OwnerEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return OwnerEventMapper.ensureInitialized().encodeMap<OwnerEvent>(
      this as OwnerEvent,
    );
  }

  OwnerEventCopyWith<OwnerEvent, OwnerEvent, OwnerEvent> get copyWith =>
      _OwnerEventCopyWithImpl<OwnerEvent, OwnerEvent>(
        this as OwnerEvent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OwnerEventMapper.ensureInitialized().stringifyValue(
      this as OwnerEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return OwnerEventMapper.ensureInitialized().equalsValue(
      this as OwnerEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return OwnerEventMapper.ensureInitialized().hashValue(this as OwnerEvent);
  }
}

extension OwnerEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OwnerEvent, $Out> {
  OwnerEventCopyWith<$R, OwnerEvent, $Out> get $asOwnerEvent =>
      $base.as((v, t, t2) => _OwnerEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OwnerEventCopyWith<$R, $In extends OwnerEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  OwnerEventSalesCopyWith<$R, OwnerEventSales, OwnerEventSales> get sales;
  OwnerEventRevenueCopyWith<$R, OwnerEventRevenue, OwnerEventRevenue>
  get revenue;
  $R call({
    String? id,
    String? displayCode,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
    String? timeLabel,
    EventStatus? status,
    OwnerEventSales? sales,
    OwnerEventRevenue? revenue,
  });
  OwnerEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OwnerEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OwnerEvent, $Out>
    implements OwnerEventCopyWith<$R, OwnerEvent, $Out> {
  _OwnerEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OwnerEvent> $mapper =
      OwnerEventMapper.ensureInitialized();
  @override
  OwnerEventSalesCopyWith<$R, OwnerEventSales, OwnerEventSales> get sales =>
      $value.sales.copyWith.$chain((v) => call(sales: v));
  @override
  OwnerEventRevenueCopyWith<$R, OwnerEventRevenue, OwnerEventRevenue>
  get revenue => $value.revenue.copyWith.$chain((v) => call(revenue: v));
  @override
  $R call({
    String? id,
    String? displayCode,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
    Object? timeLabel = $none,
    EventStatus? status,
    OwnerEventSales? sales,
    OwnerEventRevenue? revenue,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (displayCode != null) #displayCode: displayCode,
      if (name != null) #name: name,
      if (startTime != null) #startTime: startTime,
      if (endTime != null) #endTime: endTime,
      if (timeLabel != $none) #timeLabel: timeLabel,
      if (status != null) #status: status,
      if (sales != null) #sales: sales,
      if (revenue != null) #revenue: revenue,
    }),
  );
  @override
  OwnerEvent $make(CopyWithData data) => OwnerEvent(
    id: data.get(#id, or: $value.id),
    displayCode: data.get(#displayCode, or: $value.displayCode),
    name: data.get(#name, or: $value.name),
    startTime: data.get(#startTime, or: $value.startTime),
    endTime: data.get(#endTime, or: $value.endTime),
    timeLabel: data.get(#timeLabel, or: $value.timeLabel),
    status: data.get(#status, or: $value.status),
    sales: data.get(#sales, or: $value.sales),
    revenue: data.get(#revenue, or: $value.revenue),
  );

  @override
  OwnerEventCopyWith<$R2, OwnerEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OwnerEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OwnerEventSalesMapper extends ClassMapperBase<OwnerEventSales> {
  OwnerEventSalesMapper._();

  static OwnerEventSalesMapper? _instance;
  static OwnerEventSalesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerEventSalesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OwnerEventSales';

  static int _$sold(OwnerEventSales v) => v.sold;
  static const Field<OwnerEventSales, int> _f$sold = Field('sold', _$sold);
  static int _$capacity(OwnerEventSales v) => v.capacity;
  static const Field<OwnerEventSales, int> _f$capacity = Field(
    'capacity',
    _$capacity,
  );

  @override
  final MappableFields<OwnerEventSales> fields = const {
    #sold: _f$sold,
    #capacity: _f$capacity,
  };

  static OwnerEventSales _instantiate(DecodingData data) {
    return OwnerEventSales(
      sold: data.dec(_f$sold),
      capacity: data.dec(_f$capacity),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OwnerEventSales fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OwnerEventSales>(map);
  }

  static OwnerEventSales fromJson(String json) {
    return ensureInitialized().decodeJson<OwnerEventSales>(json);
  }
}

mixin OwnerEventSalesMappable {
  String toJson() {
    return OwnerEventSalesMapper.ensureInitialized()
        .encodeJson<OwnerEventSales>(this as OwnerEventSales);
  }

  Map<String, dynamic> toMap() {
    return OwnerEventSalesMapper.ensureInitialized().encodeMap<OwnerEventSales>(
      this as OwnerEventSales,
    );
  }

  OwnerEventSalesCopyWith<OwnerEventSales, OwnerEventSales, OwnerEventSales>
  get copyWith =>
      _OwnerEventSalesCopyWithImpl<OwnerEventSales, OwnerEventSales>(
        this as OwnerEventSales,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OwnerEventSalesMapper.ensureInitialized().stringifyValue(
      this as OwnerEventSales,
    );
  }

  @override
  bool operator ==(Object other) {
    return OwnerEventSalesMapper.ensureInitialized().equalsValue(
      this as OwnerEventSales,
      other,
    );
  }

  @override
  int get hashCode {
    return OwnerEventSalesMapper.ensureInitialized().hashValue(
      this as OwnerEventSales,
    );
  }
}

extension OwnerEventSalesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OwnerEventSales, $Out> {
  OwnerEventSalesCopyWith<$R, OwnerEventSales, $Out> get $asOwnerEventSales =>
      $base.as((v, t, t2) => _OwnerEventSalesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OwnerEventSalesCopyWith<$R, $In extends OwnerEventSales, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? sold, int? capacity});
  OwnerEventSalesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OwnerEventSalesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OwnerEventSales, $Out>
    implements OwnerEventSalesCopyWith<$R, OwnerEventSales, $Out> {
  _OwnerEventSalesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OwnerEventSales> $mapper =
      OwnerEventSalesMapper.ensureInitialized();
  @override
  $R call({int? sold, int? capacity}) => $apply(
    FieldCopyWithData({
      if (sold != null) #sold: sold,
      if (capacity != null) #capacity: capacity,
    }),
  );
  @override
  OwnerEventSales $make(CopyWithData data) => OwnerEventSales(
    sold: data.get(#sold, or: $value.sold),
    capacity: data.get(#capacity, or: $value.capacity),
  );

  @override
  OwnerEventSalesCopyWith<$R2, OwnerEventSales, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OwnerEventSalesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OwnerEventRevenueMapper extends ClassMapperBase<OwnerEventRevenue> {
  OwnerEventRevenueMapper._();

  static OwnerEventRevenueMapper? _instance;
  static OwnerEventRevenueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerEventRevenueMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OwnerEventRevenue';

  static double _$amount(OwnerEventRevenue v) => v.amount;
  static const Field<OwnerEventRevenue, double> _f$amount = Field(
    'amount',
    _$amount,
  );
  static String _$currency(OwnerEventRevenue v) => v.currency;
  static const Field<OwnerEventRevenue, String> _f$currency = Field(
    'currency',
    _$currency,
  );

  @override
  final MappableFields<OwnerEventRevenue> fields = const {
    #amount: _f$amount,
    #currency: _f$currency,
  };

  static OwnerEventRevenue _instantiate(DecodingData data) {
    return OwnerEventRevenue(
      amount: data.dec(_f$amount),
      currency: data.dec(_f$currency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OwnerEventRevenue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OwnerEventRevenue>(map);
  }

  static OwnerEventRevenue fromJson(String json) {
    return ensureInitialized().decodeJson<OwnerEventRevenue>(json);
  }
}

mixin OwnerEventRevenueMappable {
  String toJson() {
    return OwnerEventRevenueMapper.ensureInitialized()
        .encodeJson<OwnerEventRevenue>(this as OwnerEventRevenue);
  }

  Map<String, dynamic> toMap() {
    return OwnerEventRevenueMapper.ensureInitialized()
        .encodeMap<OwnerEventRevenue>(this as OwnerEventRevenue);
  }

  OwnerEventRevenueCopyWith<
    OwnerEventRevenue,
    OwnerEventRevenue,
    OwnerEventRevenue
  >
  get copyWith =>
      _OwnerEventRevenueCopyWithImpl<OwnerEventRevenue, OwnerEventRevenue>(
        this as OwnerEventRevenue,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OwnerEventRevenueMapper.ensureInitialized().stringifyValue(
      this as OwnerEventRevenue,
    );
  }

  @override
  bool operator ==(Object other) {
    return OwnerEventRevenueMapper.ensureInitialized().equalsValue(
      this as OwnerEventRevenue,
      other,
    );
  }

  @override
  int get hashCode {
    return OwnerEventRevenueMapper.ensureInitialized().hashValue(
      this as OwnerEventRevenue,
    );
  }
}

extension OwnerEventRevenueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OwnerEventRevenue, $Out> {
  OwnerEventRevenueCopyWith<$R, OwnerEventRevenue, $Out>
  get $asOwnerEventRevenue => $base.as(
    (v, t, t2) => _OwnerEventRevenueCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class OwnerEventRevenueCopyWith<
  $R,
  $In extends OwnerEventRevenue,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? amount, String? currency});
  OwnerEventRevenueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OwnerEventRevenueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OwnerEventRevenue, $Out>
    implements OwnerEventRevenueCopyWith<$R, OwnerEventRevenue, $Out> {
  _OwnerEventRevenueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OwnerEventRevenue> $mapper =
      OwnerEventRevenueMapper.ensureInitialized();
  @override
  $R call({double? amount, String? currency}) => $apply(
    FieldCopyWithData({
      if (amount != null) #amount: amount,
      if (currency != null) #currency: currency,
    }),
  );
  @override
  OwnerEventRevenue $make(CopyWithData data) => OwnerEventRevenue(
    amount: data.get(#amount, or: $value.amount),
    currency: data.get(#currency, or: $value.currency),
  );

  @override
  OwnerEventRevenueCopyWith<$R2, OwnerEventRevenue, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OwnerEventRevenueCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

