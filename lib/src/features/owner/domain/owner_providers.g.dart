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
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
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
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
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
    r'626b33c8f9e0a1b6d4c2a273944edc4641f528f5';

final class GetOwnerEventBookingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, String> {
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
