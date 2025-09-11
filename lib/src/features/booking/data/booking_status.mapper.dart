// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_status.dart';

class BookingStatusMapper extends EnumMapper<BookingStatus> {
  BookingStatusMapper._();

  static BookingStatusMapper? _instance;
  static BookingStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingStatusMapper._());
    }
    return _instance!;
  }

  static BookingStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BookingStatus decode(dynamic value) {
    switch (value) {
      case 'PENDING':
        return BookingStatus.pending;
      case 'CONFIRMED':
        return BookingStatus.confirmed;
      case 'CANCELLED':
        return BookingStatus.cancelled;
      case 'COMPLETED':
        return BookingStatus.completed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BookingStatus self) {
    switch (self) {
      case BookingStatus.pending:
        return 'PENDING';
      case BookingStatus.confirmed:
        return 'CONFIRMED';
      case BookingStatus.cancelled:
        return 'CANCELLED';
      case BookingStatus.completed:
        return 'COMPLETED';
    }
  }
}

extension BookingStatusMapperExtension on BookingStatus {
  dynamic toValue() {
    BookingStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BookingStatus>(this);
  }
}
