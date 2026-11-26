import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Gets the user's current device location.
  Future<Position> getCurrentLocation() async {
    // 1. Check whether device location services are enabled.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable GPS.');
    }

    // 2. Check the current location permission.
    LocationPermission permission = await Geolocator.checkPermission();

    // 3. Request permission if it has not been granted.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // 4. Handle denied permission.
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission was denied.');
    }

    // 5. Handle permanently denied permission.
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission is permanently denied. '
        'Please enable it in your device settings.',
      );
    }

    // 6. Get the current device position.
    return Geolocator.getCurrentPosition();
  }
}
