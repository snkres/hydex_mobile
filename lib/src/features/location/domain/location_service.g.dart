// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculateDistanceHash() => r'4b31a9a53c10f90010da21e58dade1e1378b77df';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [calculateDistance].
@ProviderFor(calculateDistance)
const calculateDistanceProvider = CalculateDistanceFamily();

/// See also [calculateDistance].
class CalculateDistanceFamily extends Family<AsyncValue<String>> {
  /// See also [calculateDistance].
  const CalculateDistanceFamily();

  /// See also [calculateDistance].
  CalculateDistanceProvider call({
    required double endLatitude,
    required double endLongitude,
  }) {
    return CalculateDistanceProvider(
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );
  }

  @override
  CalculateDistanceProvider getProviderOverride(
    covariant CalculateDistanceProvider provider,
  ) {
    return call(
      endLatitude: provider.endLatitude,
      endLongitude: provider.endLongitude,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calculateDistanceProvider';
}

/// See also [calculateDistance].
class CalculateDistanceProvider extends AutoDisposeFutureProvider<String> {
  /// See also [calculateDistance].
  CalculateDistanceProvider({
    required double endLatitude,
    required double endLongitude,
  }) : this._internal(
         (ref) => calculateDistance(
           ref as CalculateDistanceRef,
           endLatitude: endLatitude,
           endLongitude: endLongitude,
         ),
         from: calculateDistanceProvider,
         name: r'calculateDistanceProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$calculateDistanceHash,
         dependencies: CalculateDistanceFamily._dependencies,
         allTransitiveDependencies:
             CalculateDistanceFamily._allTransitiveDependencies,
         endLatitude: endLatitude,
         endLongitude: endLongitude,
       );

  CalculateDistanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.endLatitude,
    required this.endLongitude,
  }) : super.internal();

  final double endLatitude;
  final double endLongitude;

  @override
  Override overrideWith(
    FutureOr<String> Function(CalculateDistanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalculateDistanceProvider._internal(
        (ref) => create(ref as CalculateDistanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        endLatitude: endLatitude,
        endLongitude: endLongitude,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _CalculateDistanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalculateDistanceProvider &&
        other.endLatitude == endLatitude &&
        other.endLongitude == endLongitude;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, endLatitude.hashCode);
    hash = _SystemHash.combine(hash, endLongitude.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalculateDistanceRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `endLatitude` of this provider.
  double get endLatitude;

  /// The parameter `endLongitude` of this provider.
  double get endLongitude;
}

class _CalculateDistanceProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with CalculateDistanceRef {
  _CalculateDistanceProviderElement(super.provider);

  @override
  double get endLatitude => (origin as CalculateDistanceProvider).endLatitude;
  @override
  double get endLongitude => (origin as CalculateDistanceProvider).endLongitude;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
