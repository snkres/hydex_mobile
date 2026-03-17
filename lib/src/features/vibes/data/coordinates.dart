import 'package:dart_mappable/dart_mappable.dart';

part 'coordinates.mapper.dart';

@MappableClass()
class Coordinates with CoordinatesMappable {
  final double? lat;

  final double? lng;

  Coordinates({this.lat, this.lng});
}
