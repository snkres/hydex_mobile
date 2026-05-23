// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getBookings)
const getBookingsProvider = GetBookingsProvider._();

final class GetBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          FutureOr<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $FutureProvider<List<Booking>> {
  const GetBookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBookingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Booking>> create(Ref ref) {
    return getBookings(ref);
  }
}

String _$getBookingsHash() => r'a84b9ad87d17c1703d2976dd38f4bf24efa9c98c';

@ProviderFor(createBooking)
const createBookingProvider = CreateBookingProvider._();

final class CreateBookingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const CreateBookingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createBookingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createBookingHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return createBooking(ref);
  }
}

String _$createBookingHash() => r'5294efcdbacbe3d3db3b5d77ca8f39e588cff238';

@ProviderFor(cancelBooking)
const cancelBookingProvider = CancelBookingFamily._();

final class CancelBookingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const CancelBookingProvider._({
    required CancelBookingFamily super.from,
    required ({String id, String reason}) super.argument,
  }) : super(
         retry: null,
         name: r'cancelBookingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cancelBookingHash();

  @override
  String toString() {
    return r'cancelBookingProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as ({String id, String reason});
    return cancelBooking(ref, id: argument.id, reason: argument.reason);
  }

  @override
  bool operator ==(Object other) {
    return other is CancelBookingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cancelBookingHash() => r'f88ef0576305c81f760c09d4c1b04d53d3431bda';

final class CancelBookingFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<bool>,
          ({String id, String reason})
        > {
  const CancelBookingFamily._()
    : super(
        retry: null,
        name: r'cancelBookingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CancelBookingProvider call({required String id, required String reason}) =>
      CancelBookingProvider._(argument: (id: id, reason: reason), from: this);

  @override
  String toString() => r'cancelBookingProvider';
}
