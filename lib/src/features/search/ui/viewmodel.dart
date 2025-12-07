import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/search/data/search_data.dart';
import 'package:hydex/src/features/search/data/search_filters.dart';
import 'package:hydex/src/features/search/domain/search_repository.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'viewmodel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  SearchFilters filters = SearchFilters();
  @override
  Future<SearchData> build() async {
    return _search();
  }

  Future<SearchData> _search() async {
    final results = ref.read(searchProvider(filters: filters).future);
    return results;
  }

  Future<void> setQuery(String? query) async {
    filters = filters.copyWith(query: query);
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }

  Future<void> setCategory(String? id) async {
    filters = filters.copyWith(categoryId: id);
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }

  Future<void> setPriceType(PriceType? priceType) async {
    filters = filters.copyWith(priceType: priceType);
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }

  Future<void> setOpenNow(bool? value) async {
    filters = filters.copyWith(openNow: value);
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }

  Future<void> setByDistance(int? distance) async {
    filters = filters.copyWith(distance: distance);
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }

  Future<void> toggleNearest() async {
    if (filters.coordinates == null) {
      final userPosition = await LocationService().getCurrentPosition();
      final userLat = userPosition.latitude;
      final userLng = userPosition.longitude;
      final coordinates = Coordinates(lat: userLat, lng: userLng);
      filters = filters.copyWith(coordinates: coordinates);
      state = const AsyncLoading();
      state = await AsyncValue.guard(_search);
    } else {
      filters = filters.copyWith(coordinates: null);
      state = const AsyncLoading();
      state = await AsyncValue.guard(_search);
    }
  }

  int getLength() {
    final events = state.value?.events?.length ?? 0;
    final vendors = state.value?.vendors?.length ?? 0;

    return events + vendors;
  }

  Future<void> reset() async {
    filters = SearchFilters();
    state = const AsyncLoading();
    state = await AsyncValue.guard(_search);
  }
}
