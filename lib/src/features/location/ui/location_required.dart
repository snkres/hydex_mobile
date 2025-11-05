import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';

class LocationRequired extends StatefulWidget {
  final Widget child;
  const LocationRequired({super.key, required this.child});

  @override
  State<LocationRequired> createState() => _LocationRequiredState();
}

class _LocationRequiredState extends State<LocationRequired>
    with WidgetsBindingObserver {
  LocationPermission? _permissionStatus;
  bool _isLoading = true;
  bool _hasUserInteracted =
      false; // Track if user has attempted to grant permission

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-check permission when app resumes (user returns from settings)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _hasUserInteracted) {
      checkStatus();
    }
  }

  Future<void> checkStatus() async {
    final status = await LocationService().locationPermission();
    print(status);
    if (!mounted) return;
    setState(() {
      _permissionStatus = status;
      _isLoading = false;
    });
  }

  Widget _buildLocationDeniedWidget() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Location Required',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                  setState(() => _hasUserInteracted = true);
                  await LocationService().requestLocationPermission();
                  await checkStatus();
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Enable Location'),
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
      ),
    );
  }

  Widget _buildLocationPermanentlyDeniedWidget() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                'Location Access Denied',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Show regular "Enable Location" for first-time denied
    if (_permissionStatus == LocationPermission.denied && !_hasUserInteracted) {
      return _buildLocationDeniedWidget();
    }

    // Show "Open Settings" only if user denied after interaction or deniedForever
    if (_permissionStatus == LocationPermission.denied && _hasUserInteracted ||
        _permissionStatus == LocationPermission.deniedForever) {
      return _buildLocationPermanentlyDeniedWidget();
    }

    // Permission granted
    return widget.child;
  }
}
