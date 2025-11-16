// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nationality_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NationalityNotifier)
const nationalityProvider = NationalityNotifierProvider._();

final class NationalityNotifierProvider
    extends $NotifierProvider<NationalityNotifier, String?> {
  const NationalityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nationalityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nationalityNotifierHash();

  @$internal
  @override
  NationalityNotifier create() => NationalityNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$nationalityNotifierHash() =>
    r'873466475fcdb1a7e8a2a5350c75a0911479b26f';

abstract class _$NationalityNotifier extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
