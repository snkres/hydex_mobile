// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$calculateDistanceHash() => r'4b31a9a53c10f90010da21e58dade1e1378b77df';

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
