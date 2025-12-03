import 'package:geolocator/geolocator.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_notifier.g.dart';

@Riverpod(keepAlive: true)
class LocationChecker extends _$LocationChecker {
  @override
  FutureOr<LocationPermission?> build() async {
    checkStatus();
    return null;
  }

  Future<void> checkStatus() async {
    try {
      state = AsyncValue.loading();

      final status = await LocationService().locationPermission();
      state = AsyncValue.data(status);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> requestPermissionAndUpdate() async {
    // You might want to update a separate flag here to track user interaction
    await LocationService().requestLocationPermission();
    await checkStatus();
  }
}
