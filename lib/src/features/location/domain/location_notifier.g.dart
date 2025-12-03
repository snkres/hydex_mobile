// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationChecker)
const locationCheckerProvider = LocationCheckerProvider._();

final class LocationCheckerProvider
    extends $AsyncNotifierProvider<LocationChecker, LocationPermission?> {
  const LocationCheckerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationCheckerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationCheckerHash();

  @$internal
  @override
  LocationChecker create() => LocationChecker();
}

String _$locationCheckerHash() => r'2bd04255e83b7df440c43e0bb7059e445b35bf78';

abstract class _$LocationChecker extends $AsyncNotifier<LocationPermission?> {
  FutureOr<LocationPermission?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<LocationPermission?>, LocationPermission?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationPermission?>, LocationPermission?>,
              AsyncValue<LocationPermission?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
