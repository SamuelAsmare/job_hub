import 'dart:math' as math;

class DistanceCalculator {
  static double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const earthRadius = 6371.0;

    final latDifference = _degreesToRadians(endLatitude - startLatitude);

    final lonDifference = _degreesToRadians(endLongitude - startLongitude);

    final a = math.pow(math.sin(latDifference / 2), 2) +
        math.cos(_degreesToRadians(startLatitude)) *
            math.cos(_degreesToRadians(endLatitude)) *
            math.pow(math.sin(lonDifference / 2), 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}
