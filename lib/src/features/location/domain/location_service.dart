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
      await Geolocator.getCurrentPosition();

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

  Future<Map<String, String?>> getCurrentAddress() async {
    try {
      // Get current GPS position
      final currentLocation = await getCurrentPosition();

      // Reverse geocoding to get address from coordinates
      final placemarks = await placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        // Build street address
        String? street = placemark.street;
        String? subLocality = placemark.subLocality;
        String? locality = placemark.locality;
        String? administrativeArea = placemark.administrativeArea;
        String? country = placemark.country;

        // Create formatted address string
        List<String> addressParts = [];
        if (street != null && street.isNotEmpty) addressParts.add(street);
        if (subLocality != null && subLocality.isNotEmpty) {
          addressParts.add(subLocality);
        }
        if (locality != null && locality.isNotEmpty) addressParts.add(locality);
        if (administrativeArea != null && administrativeArea.isNotEmpty) {
          addressParts.add(administrativeArea);
        }
        if (country != null && country.isNotEmpty) addressParts.add(country);

        String fullAddress = addressParts.join(', ');

        return {
          'street': street,
          'subLocality': subLocality,
          'locality': locality,
          'administrativeArea': administrativeArea,
          'country': country,
          'fullAddress': fullAddress,
          'countryCode': placemark.isoCountryCode,
        };
      }

      return {};
    } catch (e) {
      return {};
    }
  }
}

@Riverpod(keepAlive: true)
Future<Map<String, String?>> currentAddress(Ref ref) async {
  final locationService = LocationService();
  return await locationService.getCurrentAddress();
}

@riverpod
Future<String?> currentCountryCode(Ref ref) async {
  final locationService = LocationService();
  return await locationService.getCountry();
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
  final distanceInKm = (distanceInMeters / 1000).round();
  return distanceInKm.toString();
}

@riverpod
class SelectedCountry extends _$SelectedCountry {
  @override
  Future<String> build() async {
    // Get GPS country as default
    final countryCode = await LocationService().getCountry();
    if (countryCode == null) return "EGYPT";

    // Map country code to country name
    if (countryCode == "EG") return "EGYPT";
    if (countryCode == "AE") return "UAE";

    // Default to EGYPT for unknown countries
    return "EGYPT";
  }

  // Method to update selected country
  void setCountry(String country) {
    state = AsyncValue.data(country);
  }
}
