// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchViewModel)
const searchViewModelProvider = SearchViewModelProvider._();

final class SearchViewModelProvider
    extends $AsyncNotifierProvider<SearchViewModel, SearchData> {
  const SearchViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchViewModelHash();

  @$internal
  @override
  SearchViewModel create() => SearchViewModel();
}

String _$searchViewModelHash() => r'4359016aa1ceaa6cad8139c8314ea306dd3a4c79';

abstract class _$SearchViewModel extends $AsyncNotifier<SearchData> {
  FutureOr<SearchData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SearchData>, SearchData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SearchData>, SearchData>,
              AsyncValue<SearchData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
