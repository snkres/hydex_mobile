import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'location_service.g.dart';


class LocationService {
  Future<bool> get isLocationEnabled async =>
      await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> locationPermission() async =>
      await Geolocator.checkPermission();

  Future<LocationPermission> requestLocationPermission() async =>
      await Geolocator.requestPermission();

  Future<void> openLocationSettings() async =>
      await Geolocator.openLocationSettings();

  Future<Position> getCurrentPosition() async =>
      await Geolocator.getCurrentPosition(
      );

  Future<String?> getCountry() async {
    try {
      // Get current GPS positio
      final currentLocation = await getCurrentPosition();
      // Reverse geocoding to get address from coordinates
      final placemarks = await placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final countryCode = placemark.isoCountryCode;

        return countryCode;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}

@riverpod
Future<String> calculateDistance(
  Ref ref, {
  required double endLatitude,
  required double endLongitude,
}) async {
  final locationService = LocationService();
  final currentPosition = await locationService.getCurrentPosition();
  final distanceInMeters = Geolocator.distanceBetween(
    currentPosition.latitude,
    currentPosition.longitude,
    endLatitude,
    endLongitude,
  );
  final distanceInKm = distanceInMeters / 1000;
  return distanceInKm.toStringAsFixed(2);
}
