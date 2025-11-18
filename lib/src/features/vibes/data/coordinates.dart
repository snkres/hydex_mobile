import 'package:dart_mappable/dart_mappable.dart';

part 'coordinates.mapper.dart';

@MappableClass()
class Coordinates with CoordinatesMappable {
  @MappableField(key: "latitude")
  final double lat;

  @MappableField(key: "longitude")
  final double lng;

  Coordinates({required this.lat, required this.lng});
}
