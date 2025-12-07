import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';

part 'search_data.mapper.dart';

@MappableClass()
class SearchData with SearchDataMappable {
  final List<Vendor>? vendors;
  final List<SearchEvent>? events;

  SearchData({this.vendors, this.events});
}

@MappableClass()
class SearchEvent with SearchEventMappable {
  final String id, name, description;
  final PriceType priceType;
  final CategoryNoDesc category;
  final Location location;
  final List<String> media;

  SearchEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.priceType,
    required this.location,
    required this.media
  });
}

class PriceOption {
  final PriceType type;
  final String label;

  const PriceOption({required this.type, required this.label});
}
