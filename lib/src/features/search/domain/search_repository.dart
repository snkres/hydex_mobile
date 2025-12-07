import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/search/data/search_data.dart';
import 'package:hydex/src/features/search/data/search_filters.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

@riverpod
Future<SearchData> search(Ref ref, {required SearchFilters filters}) async {
  try {
    final Map<String, dynamic> query = {"page": 1, "limit": 10};
    if (filters.categoryId != null) {
      query["categoryId"] = filters.categoryId;
    }
    if (filters.priceType != null) {
      query["priceType"] = filters.priceType?.toValue();
    }
    if (filters.openNow != null) {
      query["openNow"] = filters.openNow;
    }
    if (filters.query != null) {
      query["search"] = filters.query;
    }
    if (filters.distance != null) {
      query["maxDistance"] = filters.distance;
    }
    if (filters.coordinates != null) {
      query["lat"] = filters.coordinates?.lat;
      query["lng"] = filters.coordinates?.lng;
    }

    final response = await DioHelper.get("/search", queryParameters: query);
    final data = response.data["data"];

    final vendorsData = data["vendors"]["data"] as List;
    final eventsData = data["events"]["data"] as List;
    final vendors = vendorsData.map((e) => VendorMapper.fromMap(e)).toList();
    final events = eventsData.map((e) => SearchEventMapper.fromMap(e)).toList();

    return SearchData(events: events, vendors: vendors);
  } catch (e) {
    throw Exception("Search Data Error: $e");
  }
}
