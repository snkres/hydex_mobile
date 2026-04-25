// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getOwnerEvents)
const getOwnerEventsProvider = GetOwnerEventsFamily._();

final class GetOwnerEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OwnerEvent>>,
          List<OwnerEvent>,
          FutureOr<List<OwnerEvent>>
        >
    with $FutureModifier<List<OwnerEvent>>, $FutureProvider<List<OwnerEvent>> {
  const GetOwnerEventsProvider._({
    required GetOwnerEventsFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'getOwnerEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getOwnerEventsHash();

  @override
  String toString() {
    return r'getOwnerEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OwnerEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OwnerEvent>> create(Ref ref) {
    final argument = this.argument as bool;
    return getOwnerEvents(ref, active: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOwnerEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getOwnerEventsHash() => r'b8db2a3ff12a6e60f4993191aa52f7bccd84b611';

final class GetOwnerEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OwnerEvent>>, bool> {
  const GetOwnerEventsFamily._()
    : super(
        retry: null,
        name: r'getOwnerEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetOwnerEventsProvider call({bool active = false}) =>
      GetOwnerEventsProvider._(argument: active, from: this);

  @override
  String toString() => r'getOwnerEventsProvider';
}

@ProviderFor(getOwnerEventDetails)
const getOwnerEventDetailsProvider = GetOwnerEventDetailsFamily._();

final class GetOwnerEventDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<OwnerEvent>,
          OwnerEvent,
          FutureOr<OwnerEvent>
        >
    with $FutureModifier<OwnerEvent>, $FutureProvider<OwnerEvent> {
  const GetOwnerEventDetailsProvider._({
    required GetOwnerEventDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getOwnerEventDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getOwnerEventDetailsHash();

  @override
  String toString() {
    return r'getOwnerEventDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<OwnerEvent> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<OwnerEvent> create(Ref ref) {
    final argument = this.argument as String;
    return getOwnerEventDetails(ref, eventID: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOwnerEventDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getOwnerEventDetailsHash() =>
    r'0a1999eb38cf6b2299a381f6ff1320f3a44af800';

final class GetOwnerEventDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<OwnerEvent>, String> {
  const GetOwnerEventDetailsFamily._()
    : super(
        retry: null,
        name: r'getOwnerEventDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetOwnerEventDetailsProvider call({required String eventID}) =>
      GetOwnerEventDetailsProvider._(argument: eventID, from: this);

  @override
  String toString() => r'getOwnerEventDetailsProvider';
}

@ProviderFor(getOwnerEventBookings)
const getOwnerEventBookingsProvider = GetOwnerEventBookingsFamily._();

final class GetOwnerEventBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventBookingItem>>,
          List<EventBookingItem>,
          FutureOr<List<EventBookingItem>>
        >
    with
        $FutureModifier<List<EventBookingItem>>,
        $FutureProvider<List<EventBookingItem>> {
  const GetOwnerEventBookingsProvider._({
    required GetOwnerEventBookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getOwnerEventBookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getOwnerEventBookingsHash();

  @override
  String toString() {
    return r'getOwnerEventBookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<EventBookingItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventBookingItem>> create(Ref ref) {
    final argument = this.argument as String;
    return getOwnerEventBookings(ref, eventID: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOwnerEventBookingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getOwnerEventBookingsHash() =>
    r'750075753cd1fa480e18e03517989b9ec9580d4e';

final class GetOwnerEventBookingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<EventBookingItem>>, String> {
  const GetOwnerEventBookingsFamily._()
    : super(
        retry: null,
        name: r'getOwnerEventBookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetOwnerEventBookingsProvider call({required String eventID}) =>
      GetOwnerEventBookingsProvider._(argument: eventID, from: this);

  @override
  String toString() => r'getOwnerEventBookingsProvider';
}

@ProviderFor(getOwnerVendorBookings)
const getOwnerVendorBookingsProvider = GetOwnerVendorBookingsFamily._();

final class GetOwnerVendorBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VendorBookingItem>>,
          List<VendorBookingItem>,
          FutureOr<List<VendorBookingItem>>
        >
    with
        $FutureModifier<List<VendorBookingItem>>,
        $FutureProvider<List<VendorBookingItem>> {
  const GetOwnerVendorBookingsProvider._({
    required GetOwnerVendorBookingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getOwnerVendorBookingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getOwnerVendorBookingsHash();

  @override
  String toString() {
    return r'getOwnerVendorBookingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<VendorBookingItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VendorBookingItem>> create(Ref ref) {
    final argument = this.argument as String;
    return getOwnerVendorBookings(ref, vendorId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOwnerVendorBookingsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getOwnerVendorBookingsHash() =>
    r'0519817a5051d0992d12bad1839fe5a9c3632c31';

final class GetOwnerVendorBookingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<VendorBookingItem>>, String> {
  const GetOwnerVendorBookingsFamily._()
    : super(
        retry: null,
        name: r'getOwnerVendorBookingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetOwnerVendorBookingsProvider call({required String vendorId}) =>
      GetOwnerVendorBookingsProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'getOwnerVendorBookingsProvider';
}

@ProviderFor(getVendorReservations)
const getVendorReservationsProvider = GetVendorReservationsFamily._();

final class GetVendorReservationsProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  const GetVendorReservationsProvider._({
    required GetVendorReservationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getVendorReservationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getVendorReservationsHash();

  @override
  String toString() {
    return r'getVendorReservationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as String;
    return getVendorReservations(ref, vendorId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVendorReservationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getVendorReservationsHash() =>
    r'b840dbb658752689d00bf64f134fc5fe39fd38ec';

final class GetVendorReservationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, String> {
  const GetVendorReservationsFamily._()
    : super(
        retry: null,
        name: r'getVendorReservationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetVendorReservationsProvider call({required String vendorId}) =>
      GetVendorReservationsProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'getVendorReservationsProvider';
}

@ProviderFor(getVendorSales)
const getVendorSalesProvider = GetVendorSalesFamily._();

final class GetVendorSalesProvider
    extends
        $FunctionalProvider<
          AsyncValue<VendorSales>,
          VendorSales,
          FutureOr<VendorSales>
        >
    with $FutureModifier<VendorSales>, $FutureProvider<VendorSales> {
  const GetVendorSalesProvider._({
    required GetVendorSalesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getVendorSalesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getVendorSalesHash();

  @override
  String toString() {
    return r'getVendorSalesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VendorSales> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VendorSales> create(Ref ref) {
    final argument = this.argument as String;
    return getVendorSales(ref, vendorId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVendorSalesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getVendorSalesHash() => r'57bd5af04fa27bc3654731251cd16766f52d8485';

final class GetVendorSalesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VendorSales>, String> {
  const GetVendorSalesFamily._()
    : super(
        retry: null,
        name: r'getVendorSalesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetVendorSalesProvider call({required String vendorId}) =>
      GetVendorSalesProvider._(argument: vendorId, from: this);

  @override
  String toString() => r'getVendorSalesProvider';
}
