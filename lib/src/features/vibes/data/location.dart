import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';

part 'location.mapper.dart';



@MappableClass()
class Location with LocationMappable {
  final String address;
  final Coordinates coordinates;

  Location({
    required this.address,
    required this.coordinates,
  });
}