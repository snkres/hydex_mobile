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
    extends $AsyncNotifierProvider<LocationChecker, LocationStatus?> {
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

String _$locationCheckerHash() => r'5a1e69e7ccf824c427337fef00ed578a88b472ca';

abstract class _$LocationChecker extends $AsyncNotifier<LocationStatus?> {
  FutureOr<LocationStatus?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LocationStatus?>, LocationStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationStatus?>, LocationStatus?>,
              AsyncValue<LocationStatus?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
