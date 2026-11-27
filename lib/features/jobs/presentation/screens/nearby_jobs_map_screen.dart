import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../providers/job_provider.dart';
import '../../domain/models/job.dart';

class NearbyJobsMapScreen extends ConsumerStatefulWidget {
  const NearbyJobsMapScreen({super.key});

  @override
  ConsumerState<NearbyJobsMapScreen> createState() =>
      _NearbyJobsMapScreenState();
}

class _NearbyJobsMapScreenState extends ConsumerState<NearbyJobsMapScreen> {
  double _selectedRadius = 10;

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationProvider);
    final nearbyJobsAsync = ref.watch(nearbyJobsProvider(_selectedRadius));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Jobs'),
        actions: [
          IconButton(
            onPressed: _refreshLocation,
            icon: const Icon(Icons.my_location),
            tooltip: 'Refresh location',
          ),
        ],
      ),
      body: locationAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _buildLocationError(error),
        data: (position) => Column(
          children: [
            _buildRadiusSelector(),
            Expanded(
              child: nearbyJobsAsync.when(
                loading: () => Stack(
                  children: [
                    _buildMap(position, []),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Could not load nearby jobs: $error'),
                ),
                data: (jobs) => _buildMap(position, jobs),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadiusSelector() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.radar),
          const SizedBox(width: 12),
          const Text('Search radius:'),
          const Spacer(),
          DropdownButton<double>(
            value: _selectedRadius,
            items: const [
              DropdownMenuItem(
                value: 5,
                child: Text('5 km'),
              ),
              DropdownMenuItem(
                value: 10,
                child: Text('10 km'),
              ),
              DropdownMenuItem(
                value: 20,
                child: Text('20 km'),
              ),
            ],
            onChanged: (radius) {
              if (radius != null) {
                setState(() {
                  _selectedRadius = radius;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMap(Position position, List<Job> jobs) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          position.latitude,
          position.longitude,
        ),
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(
                position.latitude,
                position.longitude,
              ),
              width: 45,
              height: 45,
              child: const Icon(
                Icons.my_location,
                color: Colors.blue,
                size: 35,
              ),
            ),
            for (final job in jobs)
              Marker(
                point: LatLng(
                  job.latitude!,
                  job.longitude!,
                ),
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    context.push('/jobs/${job.id}');
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
          ],
        ),
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationError(Object error) {
    final message = error.toString();

    final permanentlyDenied = message.contains('permanently denied');

    final serviceDisabled = message.contains('disabled');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              serviceDisabled ? Icons.location_disabled : Icons.location_off,
              size: 55,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to get your location',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              serviceDisabled
                  ? 'Please enable location services on your device.'
                  : permanentlyDenied
                      ? 'Location permission is permanently denied. '
                          'Enable it in app settings.'
                      : 'Location permission is required to find nearby jobs.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLocationError,
              child: Text(
                serviceDisabled
                    ? 'Enable location'
                    : permanentlyDenied
                        ? 'Open app settings'
                        : 'Try again',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLocationError() async {
    final locationError = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();

    if (!locationError) {
      await Geolocator.openLocationSettings();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    _refreshLocation();
  }

  void _refreshLocation() {
    ref.invalidate(currentLocationProvider);
    ref.invalidate(
      nearbyJobsProvider(_selectedRadius),
    );
  }
}
