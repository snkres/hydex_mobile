import 'package:geolocator/geolocator.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_notifier.g.dart';

class LocationStatus {
  final LocationPermission permission;
  final bool isServiceEnabled;

  const LocationStatus({
    required this.permission,
    required this.isServiceEnabled,
  });
}

@Riverpod(keepAlive: true)
class LocationChecker extends _$LocationChecker {
  @override
  FutureOr<LocationStatus?> build() async {
    checkStatus();
    return null;
  }

  Future<void> checkStatus() async {
    try {
      state = AsyncValue.loading();

      final locationService = LocationService();
      final permission = await locationService.locationPermission();
      final isServiceEnabled = await locationService.isLocationEnabled;
      state = AsyncValue.data(
        LocationStatus(
          permission: permission,
          isServiceEnabled: isServiceEnabled,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> requestPermissionAndUpdate() async {
    await LocationService().requestLocationPermission();
    await checkStatus();
  }
}
