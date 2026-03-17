// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentAddress)
const currentAddressProvider = CurrentAddressProvider._();

final class CurrentAddressProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, String?>>,
          Map<String, String?>,
          FutureOr<Map<String, String?>>
        >
    with
        $FutureModifier<Map<String, String?>>,
        $FutureProvider<Map<String, String?>> {
  const CurrentAddressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAddressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAddressHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, String?>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, String?>> create(Ref ref) {
    return currentAddress(ref);
  }
}

String _$currentAddressHash() => r'0a3c1be14e36a5e3b6320ba0b71baa63f94cf4f5';

@ProviderFor(currentCountryCode)
const currentCountryCodeProvider = CurrentCountryCodeProvider._();

final class CurrentCountryCodeProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  const CurrentCountryCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCountryCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentCountryCodeHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return currentCountryCode(ref);
  }
}

String _$currentCountryCodeHash() =>
    r'fe2cc3f07fc899d0966fdb0c4278bcbba45de203';

@ProviderFor(calculateDistance)
const calculateDistanceProvider = CalculateDistanceFamily._();

final class CalculateDistanceProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const CalculateDistanceProvider._({
    required CalculateDistanceFamily super.from,
    required ({double endLatitude, double endLongitude}) super.argument,
  }) : super(
         retry: null,
         name: r'calculateDistanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calculateDistanceHash();

  @override
  String toString() {
    return r'calculateDistanceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument =
        this.argument as ({double endLatitude, double endLongitude});
    return calculateDistance(
      ref,
      endLatitude: argument.endLatitude,
      endLongitude: argument.endLongitude,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CalculateDistanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calculateDistanceHash() => r'5a76ae3a142f823e4b7572977def82b44711d2bb';

final class CalculateDistanceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String>,
          ({double endLatitude, double endLongitude})
        > {
  const CalculateDistanceFamily._()
    : super(
        retry: null,
        name: r'calculateDistanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CalculateDistanceProvider call({
    required double endLatitude,
    required double endLongitude,
  }) => CalculateDistanceProvider._(
    argument: (endLatitude: endLatitude, endLongitude: endLongitude),
    from: this,
  );

  @override
  String toString() => r'calculateDistanceProvider';
}

@ProviderFor(SelectedCountry)
const selectedCountryProvider = SelectedCountryProvider._();

final class SelectedCountryProvider
    extends $AsyncNotifierProvider<SelectedCountry, String> {
  const SelectedCountryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCountryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCountryHash();

  @$internal
  @override
  SelectedCountry create() => SelectedCountry();
}

String _$selectedCountryHash() => r'5825a26d36bf1fdd285b3ecedc4b8a6c21ecd70a';

abstract class _$SelectedCountry extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
