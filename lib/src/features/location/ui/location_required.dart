import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydex/src/features/location/domain/location_notifier.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';

class LocationRequired extends ConsumerWidget {
  final Widget child;
  const LocationRequired({super.key, required this.child});

  Widget _buildLocationDeniedWidget(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Location Required',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This app needs access to your location to function properly.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                await ref
                    .read(locationCheckerProvider.notifier)
                    .requestPermissionAndUpdate();
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDisabledWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.orange[400]),
            const SizedBox(height: 16),
            Text(
              'Location Service Disabled',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Please turn on your location service to discover nearby experiences.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                await LocationService().openLocationSettings();
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Turn On Location'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPermanentlyDeniedWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Location Access Denied',
              textAlign: .center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location permission was permanently denied. Please enable it in your device settings.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                await LocationService().openLocationSettings();
              },
              icon: const Icon(Icons.settings),
              label: const Text('Open Settings'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationCheckerProvider);
    final locationStatus = locationState.value;

    // Still loading or not yet checked
    if (locationState.isLoading || locationStatus == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Location service (GPS) is disabled
    if (!locationStatus.isServiceEnabled) {
      return _buildServiceDisabledWidget(context);
    }

    // Permission denied
    if (locationStatus.permission == LocationPermission.denied) {
      return _buildLocationDeniedWidget(context, ref);
    }

    // Permission permanently denied
    if (locationStatus.permission == LocationPermission.deniedForever) {
      return _buildLocationPermanentlyDeniedWidget(context);
    }

    // Permission granted and service enabled
    return child;
  }
}
