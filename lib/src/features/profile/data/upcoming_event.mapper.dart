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
    opt: true,
    def: 0,
  );
  static String? _$cancellationReason(UpcomingEvent v) => v.cancellationReason;
  static const Field<UpcomingEvent, String> _f$cancellationReason = Field(
    'cancellationReason',
    _$cancellationReason,
    opt: true,
  );
  static List<String>? _$guestsNames(UpcomingEvent v) => v.guestsNames;
  static const Field<UpcomingEvent, List<String>> _f$guestsNames = Field(
    'guestsNames',
    _$guestsNames,
    opt: true,
  );
  static List<String> _$thingsToKnow(UpcomingEvent v) => v.thingsToKnow;
  static const Field<UpcomingEvent, List<String>> _f$thingsToKnow = Field(
    'thingsToKnow',
    _$thingsToKnow,
  );
  static String _$passId(UpcomingEvent v) => v.passId;
  static const Field<UpcomingEvent, String> _f$passId = Field(
    'passId',
    _$passId,
  );
  static String? _$termsAndConditions(UpcomingEvent v) => v.termsAndConditions;
  static const Field<UpcomingEvent, String> _f$termsAndConditions = Field(
    'termsAndConditions',
    _$termsAndConditions,
    opt: true,
  );
  static int _$totalPrice(UpcomingEvent v) => v.totalPrice;
  static const Field<UpcomingEvent, int> _f$totalPrice = Field(
    'totalPrice',
    _$totalPrice,
  );
  static String _$vendorName(UpcomingEvent v) => v.vendorName;
  static const Field<UpcomingEvent, String> _f$vendorName = Field(
    'vendorName',
    _$vendorName,
  );
  static String _$bookingType(UpcomingEvent v) => v.bookingType;
  static const Field<UpcomingEvent, String> _f$bookingType = Field(
    'bookingType',
    _$bookingType,
  );
  static String _$passName(UpcomingEvent v) => v.passName;
  static const Field<UpcomingEvent, String> _f$passName = Field(
    'passName',
    _$passName,
  );
  static List<String>? _$media(UpcomingEvent v) => v.media;
  static const Field<UpcomingEvent, List<String>> _f$media = Field(
    'media',
    _$media,
    opt: true,
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
    #cancellationReason: _f$cancellationReason,
    #guestsNames: _f$guestsNames,
    #thingsToKnow: _f$thingsToKnow,
    #passId: _f$passId,
    #termsAndConditions: _f$termsAndConditions,
    #totalPrice: _f$totalPrice,
    #vendorName: _f$vendorName,
    #bookingType: _f$bookingType,
    #passName: _f$passName,
    #media: _f$media,
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
      cancellationReason: data.dec(_f$cancellationReason),
      guestsNames: data.dec(_f$guestsNames),
      thingsToKnow: data.dec(_f$thingsToKnow),
      passId: data.dec(_f$passId),
      termsAndConditions: data.dec(_f$termsAndConditions),
      totalPrice: data.dec(_f$totalPrice),
      vendorName: data.dec(_f$vendorName),
      bookingType: data.dec(_f$bookingType),
      passName: data.dec(_f$passName),
      media: data.dec(_f$media),
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get guestsNames;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get thingsToKnow;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get media;
  $R call({
    String? id,
    String? name,
    DateTime? date,
    String? time,
    Location? location,
    UpcomingEventStatus? status,
    int? numberOfGuests,
    String? cancellationReason,
    List<String>? guestsNames,
    List<String>? thingsToKnow,
    String? passId,
    String? termsAndConditions,
    int? totalPrice,
    String? vendorName,
    String? bookingType,
    String? passName,
    List<String>? media,
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get guestsNames => $value.guestsNames != null
      ? ListCopyWith(
          $value.guestsNames!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(guestsNames: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get thingsToKnow => ListCopyWith(
    $value.thingsToKnow,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(thingsToKnow: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get media =>
      $value.media != null
      ? ListCopyWith(
          $value.media!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(media: v),
        )
      : null;
  @override
  $R call({
    String? id,
    String? name,
    DateTime? date,
    String? time,
    Location? location,
    UpcomingEventStatus? status,
    int? numberOfGuests,
    Object? cancellationReason = $none,
    Object? guestsNames = $none,
    List<String>? thingsToKnow,
    String? passId,
    Object? termsAndConditions = $none,
    int? totalPrice,
    String? vendorName,
    String? bookingType,
    String? passName,
    Object? media = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (date != null) #date: date,
      if (time != null) #time: time,
      if (location != null) #location: location,
      if (status != null) #status: status,
      if (numberOfGuests != null) #numberOfGuests: numberOfGuests,
      if (cancellationReason != $none) #cancellationReason: cancellationReason,
      if (guestsNames != $none) #guestsNames: guestsNames,
      if (thingsToKnow != null) #thingsToKnow: thingsToKnow,
      if (passId != null) #passId: passId,
      if (termsAndConditions != $none) #termsAndConditions: termsAndConditions,
      if (totalPrice != null) #totalPrice: totalPrice,
      if (vendorName != null) #vendorName: vendorName,
      if (bookingType != null) #bookingType: bookingType,
      if (passName != null) #passName: passName,
      if (media != $none) #media: media,
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
    cancellationReason: data.get(
      #cancellationReason,
      or: $value.cancellationReason,
    ),
    guestsNames: data.get(#guestsNames, or: $value.guestsNames),
    thingsToKnow: data.get(#thingsToKnow, or: $value.thingsToKnow),
    passId: data.get(#passId, or: $value.passId),
    termsAndConditions: data.get(
      #termsAndConditions,
      or: $value.termsAndConditions,
    ),
    totalPrice: data.get(#totalPrice, or: $value.totalPrice),
    vendorName: data.get(#vendorName, or: $value.vendorName),
    bookingType: data.get(#bookingType, or: $value.bookingType),
    passName: data.get(#passName, or: $value.passName),
    media: data.get(#media, or: $value.media),
  );

  @override
  UpcomingEventCopyWith<$R2, UpcomingEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UpcomingEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PassportDataMapper extends ClassMapperBase<PassportData> {
  PassportDataMapper._();

  static PassportDataMapper? _instance;
  static PassportDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PassportDataMapper._());
      PassportCategoryMapper.ensureInitialized();
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
  static List<PassportCategory> _$categories(PassportData v) => v.categories;
  static const Field<PassportData, List<PassportCategory>> _f$categories =
      Field('categories', _$categories);

  @override
  final MappableFields<PassportData> fields = const {
    #totalExperiences: _f$totalExperiences,
    #categories: _f$categories,
  };

  static PassportData _instantiate(DecodingData data) {
    return PassportData(
      totalExperiences: data.dec(_f$totalExperiences),
      categories: data.dec(_f$categories),
    );
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
  ListCopyWith<
    $R,
    PassportCategory,
    PassportCategoryCopyWith<$R, PassportCategory, PassportCategory>
  >
  get categories;
  $R call({int? totalExperiences, List<PassportCategory>? categories});
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
  ListCopyWith<
    $R,
    PassportCategory,
    PassportCategoryCopyWith<$R, PassportCategory, PassportCategory>
  >
  get categories => ListCopyWith(
    $value.categories,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(categories: v),
  );
  @override
  $R call({int? totalExperiences, List<PassportCategory>? categories}) =>
      $apply(
        FieldCopyWithData({
          if (totalExperiences != null) #totalExperiences: totalExperiences,
          if (categories != null) #categories: categories,
        }),
      );
  @override
  PassportData $make(CopyWithData data) => PassportData(
    totalExperiences: data.get(#totalExperiences, or: $value.totalExperiences),
    categories: data.get(#categories, or: $value.categories),
  );

  @override
  PassportDataCopyWith<$R2, PassportData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PassportDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PassportCategoryMapper extends ClassMapperBase<PassportCategory> {
  PassportCategoryMapper._();

  static PassportCategoryMapper? _instance;
  static PassportCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PassportCategoryMapper._());
      PassportVendorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PassportCategory';

  static String? _$categoryId(PassportCategory v) => v.categoryId;
  static const Field<PassportCategory, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    opt: true,
  );
  static String _$categoryName(PassportCategory v) => v.categoryName;
  static const Field<PassportCategory, String> _f$categoryName = Field(
    'categoryName',
    _$categoryName,
  );
  static int? _$count(PassportCategory v) => v.count;
  static const Field<PassportCategory, int> _f$count = Field(
    'count',
    _$count,
    opt: true,
  );
  static List<PassportVendor>? _$vendors(PassportCategory v) => v.vendors;
  static const Field<PassportCategory, List<PassportVendor>> _f$vendors = Field(
    'vendors',
    _$vendors,
    opt: true,
  );

  @override
  final MappableFields<PassportCategory> fields = const {
    #categoryId: _f$categoryId,
    #categoryName: _f$categoryName,
    #count: _f$count,
    #vendors: _f$vendors,
  };

  static PassportCategory _instantiate(DecodingData data) {
    return PassportCategory(
      categoryId: data.dec(_f$categoryId),
      categoryName: data.dec(_f$categoryName),
      count: data.dec(_f$count),
      vendors: data.dec(_f$vendors),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PassportCategory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PassportCategory>(map);
  }

  static PassportCategory fromJson(String json) {
    return ensureInitialized().decodeJson<PassportCategory>(json);
  }
}

mixin PassportCategoryMappable {
  String toJson() {
    return PassportCategoryMapper.ensureInitialized()
        .encodeJson<PassportCategory>(this as PassportCategory);
  }

  Map<String, dynamic> toMap() {
    return PassportCategoryMapper.ensureInitialized()
        .encodeMap<PassportCategory>(this as PassportCategory);
  }

  PassportCategoryCopyWith<PassportCategory, PassportCategory, PassportCategory>
  get copyWith =>
      _PassportCategoryCopyWithImpl<PassportCategory, PassportCategory>(
        this as PassportCategory,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PassportCategoryMapper.ensureInitialized().stringifyValue(
      this as PassportCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    return PassportCategoryMapper.ensureInitialized().equalsValue(
      this as PassportCategory,
      other,
    );
  }

  @override
  int get hashCode {
    return PassportCategoryMapper.ensureInitialized().hashValue(
      this as PassportCategory,
    );
  }
}

extension PassportCategoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PassportCategory, $Out> {
  PassportCategoryCopyWith<$R, PassportCategory, $Out>
  get $asPassportCategory =>
      $base.as((v, t, t2) => _PassportCategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PassportCategoryCopyWith<$R, $In extends PassportCategory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PassportVendor,
    PassportVendorCopyWith<$R, PassportVendor, PassportVendor>
  >?
  get vendors;
  $R call({
    String? categoryId,
    String? categoryName,
    int? count,
    List<PassportVendor>? vendors,
  });
  PassportCategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PassportCategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PassportCategory, $Out>
    implements PassportCategoryCopyWith<$R, PassportCategory, $Out> {
  _PassportCategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PassportCategory> $mapper =
      PassportCategoryMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PassportVendor,
    PassportVendorCopyWith<$R, PassportVendor, PassportVendor>
  >?
  get vendors => $value.vendors != null
      ? ListCopyWith(
          $value.vendors!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(vendors: v),
        )
      : null;
  @override
  $R call({
    Object? categoryId = $none,
    String? categoryName,
    Object? count = $none,
    Object? vendors = $none,
  }) => $apply(
    FieldCopyWithData({
      if (categoryId != $none) #categoryId: categoryId,
      if (categoryName != null) #categoryName: categoryName,
      if (count != $none) #count: count,
      if (vendors != $none) #vendors: vendors,
    }),
  );
  @override
  PassportCategory $make(CopyWithData data) => PassportCategory(
    categoryId: data.get(#categoryId, or: $value.categoryId),
    categoryName: data.get(#categoryName, or: $value.categoryName),
    count: data.get(#count, or: $value.count),
    vendors: data.get(#vendors, or: $value.vendors),
  );

  @override
  PassportCategoryCopyWith<$R2, PassportCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PassportCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PassportVendorMapper extends ClassMapperBase<PassportVendor> {
  PassportVendorMapper._();

  static PassportVendorMapper? _instance;
  static PassportVendorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PassportVendorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PassportVendor';

  static String _$vendorId(PassportVendor v) => v.vendorId;
  static const Field<PassportVendor, String> _f$vendorId = Field(
    'vendorId',
    _$vendorId,
  );
  static int _$visitCount(PassportVendor v) => v.visitCount;
  static const Field<PassportVendor, int> _f$visitCount = Field(
    'visitCount',
    _$visitCount,
  );
  static String _$vendorName(PassportVendor v) => v.vendorName;
  static const Field<PassportVendor, String> _f$vendorName = Field(
    'vendorName',
    _$vendorName,
  );

  @override
  final MappableFields<PassportVendor> fields = const {
    #vendorId: _f$vendorId,
    #visitCount: _f$visitCount,
    #vendorName: _f$vendorName,
  };

  static PassportVendor _instantiate(DecodingData data) {
    return PassportVendor(
      vendorId: data.dec(_f$vendorId),
      visitCount: data.dec(_f$visitCount),
      vendorName: data.dec(_f$vendorName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PassportVendor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PassportVendor>(map);
  }

  static PassportVendor fromJson(String json) {
    return ensureInitialized().decodeJson<PassportVendor>(json);
  }
}

mixin PassportVendorMappable {
  String toJson() {
    return PassportVendorMapper.ensureInitialized().encodeJson<PassportVendor>(
      this as PassportVendor,
    );
  }

  Map<String, dynamic> toMap() {
    return PassportVendorMapper.ensureInitialized().encodeMap<PassportVendor>(
      this as PassportVendor,
    );
  }

  PassportVendorCopyWith<PassportVendor, PassportVendor, PassportVendor>
  get copyWith => _PassportVendorCopyWithImpl<PassportVendor, PassportVendor>(
    this as PassportVendor,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PassportVendorMapper.ensureInitialized().stringifyValue(
      this as PassportVendor,
    );
  }

  @override
  bool operator ==(Object other) {
    return PassportVendorMapper.ensureInitialized().equalsValue(
      this as PassportVendor,
      other,
    );
  }

  @override
  int get hashCode {
    return PassportVendorMapper.ensureInitialized().hashValue(
      this as PassportVendor,
    );
  }
}

extension PassportVendorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PassportVendor, $Out> {
  PassportVendorCopyWith<$R, PassportVendor, $Out> get $asPassportVendor =>
      $base.as((v, t, t2) => _PassportVendorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PassportVendorCopyWith<$R, $In extends PassportVendor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? vendorId, int? visitCount, String? vendorName});
  PassportVendorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PassportVendorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PassportVendor, $Out>
    implements PassportVendorCopyWith<$R, PassportVendor, $Out> {
  _PassportVendorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PassportVendor> $mapper =
      PassportVendorMapper.ensureInitialized();
  @override
  $R call({String? vendorId, int? visitCount, String? vendorName}) => $apply(
    FieldCopyWithData({
      if (vendorId != null) #vendorId: vendorId,
      if (visitCount != null) #visitCount: visitCount,
      if (vendorName != null) #vendorName: vendorName,
    }),
  );
  @override
  PassportVendor $make(CopyWithData data) => PassportVendor(
    vendorId: data.get(#vendorId, or: $value.vendorId),
    visitCount: data.get(#visitCount, or: $value.visitCount),
    vendorName: data.get(#vendorName, or: $value.vendorName),
  );

  @override
  PassportVendorCopyWith<$R2, PassportVendor, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PassportVendorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

