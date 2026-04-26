// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_booking_response.dart';

class EventBookingItemMapper extends ClassMapperBase<EventBookingItem> {
  EventBookingItemMapper._();

  static EventBookingItemMapper? _instance;
  static EventBookingItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventBookingItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventBookingItem';

  static String _$id(EventBookingItem v) => v.id;
  static const Field<EventBookingItem, String> _f$id = Field('id', _$id);
  static String _$displayCode(EventBookingItem v) => v.displayCode;
  static const Field<EventBookingItem, String> _f$displayCode = Field(
    'displayCode',
    _$displayCode,
  );
  static String _$fullName(EventBookingItem v) => v.fullName;
  static const Field<EventBookingItem, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static DateTime _$bookingDate(EventBookingItem v) => v.bookingDate;
  static const Field<EventBookingItem, DateTime> _f$bookingDate = Field(
    'bookingDate',
    _$bookingDate,
  );
  static int? _$guestNumber(EventBookingItem v) => v.guestNumber;
  static const Field<EventBookingItem, int> _f$guestNumber = Field(
    'guestNumber',
    _$guestNumber,
  );
  static int? _$numberOfGuests(EventBookingItem v) => v.numberOfGuests;
  static const Field<EventBookingItem, int> _f$numberOfGuests = Field(
    'numberOfGuests',
    _$numberOfGuests,
  );
  static String _$passName(EventBookingItem v) => v.passName;
  static const Field<EventBookingItem, String> _f$passName = Field(
    'passName',
    _$passName,
  );
  static RsvStatus _$status(EventBookingItem v) => v.status;
  static const Field<EventBookingItem, RsvStatus> _f$status = Field(
    'status',
    _$status,
    key: r'uiStatus',
    hook: RsvStatusHook(),
  );

  @override
  final MappableFields<EventBookingItem> fields = const {
    #id: _f$id,
    #displayCode: _f$displayCode,
    #fullName: _f$fullName,
    #bookingDate: _f$bookingDate,
    #guestNumber: _f$guestNumber,
    #numberOfGuests: _f$numberOfGuests,
    #passName: _f$passName,
    #status: _f$status,
  };

  static EventBookingItem _instantiate(DecodingData data) {
    return EventBookingItem(
      id: data.dec(_f$id),
      displayCode: data.dec(_f$displayCode),
      fullName: data.dec(_f$fullName),
      bookingDate: data.dec(_f$bookingDate),
      guestNumber: data.dec(_f$guestNumber),
      numberOfGuests: data.dec(_f$numberOfGuests),
      passName: data.dec(_f$passName),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventBookingItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventBookingItem>(map);
  }

  static EventBookingItem fromJson(String json) {
    return ensureInitialized().decodeJson<EventBookingItem>(json);
  }
}

mixin EventBookingItemMappable {
  String toJson() {
    return EventBookingItemMapper.ensureInitialized()
        .encodeJson<EventBookingItem>(this as EventBookingItem);
  }

  Map<String, dynamic> toMap() {
    return EventBookingItemMapper.ensureInitialized()
        .encodeMap<EventBookingItem>(this as EventBookingItem);
  }

  EventBookingItemCopyWith<EventBookingItem, EventBookingItem, EventBookingItem>
  get copyWith =>
      _EventBookingItemCopyWithImpl<EventBookingItem, EventBookingItem>(
        this as EventBookingItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventBookingItemMapper.ensureInitialized().stringifyValue(
      this as EventBookingItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventBookingItemMapper.ensureInitialized().equalsValue(
      this as EventBookingItem,
      other,
    );
  }

  @override
  int get hashCode {
    return EventBookingItemMapper.ensureInitialized().hashValue(
      this as EventBookingItem,
    );
  }
}

extension EventBookingItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventBookingItem, $Out> {
  EventBookingItemCopyWith<$R, EventBookingItem, $Out>
  get $asEventBookingItem =>
      $base.as((v, t, t2) => _EventBookingItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventBookingItemCopyWith<$R, $In extends EventBookingItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? displayCode,
    String? fullName,
    DateTime? bookingDate,
    int? guestNumber,
    int? numberOfGuests,
    String? passName,
    RsvStatus? status,
  });
  EventBookingItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventBookingItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventBookingItem, $Out>
    implements EventBookingItemCopyWith<$R, EventBookingItem, $Out> {
  _EventBookingItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventBookingItem> $mapper =
      EventBookingItemMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? displayCode,
    String? fullName,
    DateTime? bookingDate,
    Object? guestNumber = $none,
    Object? numberOfGuests = $none,
    String? passName,
    RsvStatus? status,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (displayCode != null) #displayCode: displayCode,
      if (fullName != null) #fullName: fullName,
      if (bookingDate != null) #bookingDate: bookingDate,
      if (guestNumber != $none) #guestNumber: guestNumber,
      if (numberOfGuests != $none) #numberOfGuests: numberOfGuests,
      if (passName != null) #passName: passName,
      if (status != null) #status: status,
    }),
  );
  @override
  EventBookingItem $make(CopyWithData data) => EventBookingItem(
    id: data.get(#id, or: $value.id),
    displayCode: data.get(#displayCode, or: $value.displayCode),
    fullName: data.get(#fullName, or: $value.fullName),
    bookingDate: data.get(#bookingDate, or: $value.bookingDate),
    guestNumber: data.get(#guestNumber, or: $value.guestNumber),
    numberOfGuests: data.get(#numberOfGuests, or: $value.numberOfGuests),
    passName: data.get(#passName, or: $value.passName),
    status: data.get(#status, or: $value.status),
  );

  @override
  EventBookingItemCopyWith<$R2, EventBookingItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventBookingItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

