// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking.dart';

class BookingMapper extends ClassMapperBase<Booking> {
  BookingMapper._();

  static BookingMapper? _instance;
  static BookingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingMapper._());
      BookingStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Booking';

  static String? _$id(Booking v) => v.id;
  static const Field<Booking, String> _f$id = Field('id', _$id, opt: true);
  static String _$eventId(Booking v) => v.eventId;
  static const Field<Booking, String> _f$eventId = Field('eventId', _$eventId);
  static DateTime _$bookingDate(Booking v) => v.bookingDate;
  static const Field<Booking, DateTime> _f$bookingDate =
      Field('bookingDate', _$bookingDate);
  static BookingStatus _$status(Booking v) => v.status;
  static const Field<Booking, BookingStatus> _f$status =
      Field('status', _$status);
  static String? _$notes(Booking v) => v.notes;
  static const Field<Booking, String> _f$notes =
      Field('notes', _$notes, opt: true);

  @override
  final MappableFields<Booking> fields = const {
    #id: _f$id,
    #eventId: _f$eventId,
    #bookingDate: _f$bookingDate,
    #status: _f$status,
    #notes: _f$notes,
  };

  static Booking _instantiate(DecodingData data) {
    return Booking(
        id: data.dec(_f$id),
        eventId: data.dec(_f$eventId),
        bookingDate: data.dec(_f$bookingDate),
        status: data.dec(_f$status),
        notes: data.dec(_f$notes));
  }

  @override
  final Function instantiate = _instantiate;

  static Booking fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Booking>(map);
  }

  static Booking fromJson(String json) {
    return ensureInitialized().decodeJson<Booking>(json);
  }
}

mixin BookingMappable {
  String toJson() {
    return BookingMapper.ensureInitialized()
        .encodeJson<Booking>(this as Booking);
  }

  Map<String, dynamic> toMap() {
    return BookingMapper.ensureInitialized()
        .encodeMap<Booking>(this as Booking);
  }

  BookingCopyWith<Booking, Booking, Booking> get copyWith =>
      _BookingCopyWithImpl<Booking, Booking>(
          this as Booking, $identity, $identity);
  @override
  String toString() {
    return BookingMapper.ensureInitialized().stringifyValue(this as Booking);
  }

  @override
  bool operator ==(Object other) {
    return BookingMapper.ensureInitialized()
        .equalsValue(this as Booking, other);
  }

  @override
  int get hashCode {
    return BookingMapper.ensureInitialized().hashValue(this as Booking);
  }
}

extension BookingValueCopy<$R, $Out> on ObjectCopyWith<$R, Booking, $Out> {
  BookingCopyWith<$R, Booking, $Out> get $asBooking =>
      $base.as((v, t, t2) => _BookingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookingCopyWith<$R, $In extends Booking, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? eventId,
      DateTime? bookingDate,
      BookingStatus? status,
      String? notes});
  BookingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Booking, $Out>
    implements BookingCopyWith<$R, Booking, $Out> {
  _BookingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Booking> $mapper =
      BookingMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? eventId,
          DateTime? bookingDate,
          BookingStatus? status,
          Object? notes = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (eventId != null) #eventId: eventId,
        if (bookingDate != null) #bookingDate: bookingDate,
        if (status != null) #status: status,
        if (notes != $none) #notes: notes
      }));
  @override
  Booking $make(CopyWithData data) => Booking(
      id: data.get(#id, or: $value.id),
      eventId: data.get(#eventId, or: $value.eventId),
      bookingDate: data.get(#bookingDate, or: $value.bookingDate),
      status: data.get(#status, or: $value.status),
      notes: data.get(#notes, or: $value.notes));

  @override
  BookingCopyWith<$R2, Booking, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
