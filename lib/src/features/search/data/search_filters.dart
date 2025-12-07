import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/event.dart';

part 'search_filters.mapper.dart';

@MappableClass()
class SearchFilters with SearchFiltersMappable {
  final String? categoryId,query;
  final PriceType? priceType;
  final bool? openNow;
  final Coordinates? coordinates;
  final int? distance;

  SearchFilters({
    this.categoryId,
    this.priceType,
    this.openNow,
    this.query,
    this.coordinates,
    this.distance
  });
}
