import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/jobs/domain/utils/distance_calculator.dart';

void main() {
  group('DistanceCalculator', () {
    test('returns zero for identical coordinates', () {
      final distance = DistanceCalculator.calculateDistance(
        startLatitude: 8.995,
        startLongitude: 38.787,
        endLatitude: 8.995,
        endLongitude: 38.787,
      );

      expect(distance, closeTo(0, 0.001));
    });

    test('calculates a positive distance between two locations', () {
      final distance = DistanceCalculator.calculateDistance(
        startLatitude: 8.995,
        startLongitude: 38.787,
        endLatitude: 9.010,
        endLongitude: 38.766,
      );

      expect(distance, greaterThan(0));
    });
  });
}
