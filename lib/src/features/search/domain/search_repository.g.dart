// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(search)
const searchProvider = SearchFamily._();

final class SearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<SearchData>,
          SearchData,
          FutureOr<SearchData>
        >
    with $FutureModifier<SearchData>, $FutureProvider<SearchData> {
  const SearchProvider._({
    required SearchFamily super.from,
    required SearchFilters super.argument,
  }) : super(
         retry: null,
         name: r'searchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchHash();

  @override
  String toString() {
    return r'searchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SearchData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SearchData> create(Ref ref) {
    final argument = this.argument as SearchFilters;
    return search(ref, filters: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchHash() => r'824254935a43c9350e35f7568f314e3f913c83e0';

final class SearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SearchData>, SearchFilters> {
  const SearchFamily._()
    : super(
        retry: null,
        name: r'searchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchProvider call({required SearchFilters filters}) =>
      SearchProvider._(argument: filters, from: this);

  @override
  String toString() => r'searchProvider';
}
