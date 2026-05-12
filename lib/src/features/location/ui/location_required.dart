import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydex/src/features/location/domain/location_notifier.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationRequired extends ConsumerStatefulWidget {
  final Widget child;
  const LocationRequired({super.key, required this.child});

  @override
  ConsumerState<LocationRequired> createState() => _LocationRequiredState();
}

class _LocationRequiredState extends ConsumerState<LocationRequired>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(locationCheckerProvider.notifier).checkStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationCheckerProvider);
    final locationStatus = locationState.value;

    if (locationState.isLoading || locationStatus == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!locationStatus.isServiceEnabled) {
      return _LocationServiceDisabled();
    }

    if (locationStatus.permission == LocationPermission.denied) {
      return _LocationPermissionDenied(
        onRequest: () => ref
            .read(locationCheckerProvider.notifier)
            .requestPermissionAndUpdate(),
      );
    }

    if (locationStatus.permission == LocationPermission.deniedForever) {
      return const _LocationPermissionPermanentlyDenied();
    }

    return widget.child;
  }
}

class _LocationServiceDisabled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _LocationPermissionDenied extends StatelessWidget {
  final VoidCallback onRequest;
  const _LocationPermissionDenied({required this.onRequest});

  @override
  Widget build(BuildContext context) {
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
              onPressed: onRequest,
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
}

class _LocationPermissionPermanentlyDenied extends StatelessWidget {
  const _LocationPermissionPermanentlyDenied();

  @override
  Widget build(BuildContext context) {
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
              textAlign: TextAlign.center,
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
                await openAppSettings();
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
}
