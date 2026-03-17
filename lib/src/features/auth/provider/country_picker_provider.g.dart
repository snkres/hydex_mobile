// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_picker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountryPickerNotifier)
const countryPickerProvider = CountryPickerNotifierProvider._();

final class CountryPickerNotifierProvider
    extends $AsyncNotifierProvider<CountryPickerNotifier, Country> {
  const CountryPickerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryPickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryPickerNotifierHash();

  @$internal
  @override
  CountryPickerNotifier create() => CountryPickerNotifier();
}

String _$countryPickerNotifierHash() =>
    r'238e7be3fdac7942d5dd7b6d09f10c2a676956a3';

abstract class _$CountryPickerNotifier extends $AsyncNotifier<Country> {
  FutureOr<Country> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Country>, Country>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Country>, Country>,
              AsyncValue<Country>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
