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

String _$createBookingHash() => r'b9ba55bcd87e2534d9cc29ec36b5532570c4bfed';
