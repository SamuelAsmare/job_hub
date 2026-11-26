import '../../domain/models/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/utils/distance_calculator.dart';
import '../datasources/job_local_datasource.dart';

class JobRepositoryImpl implements JobRepository {
  final JobLocalDataSource _dataSource;

  JobRepositoryImpl(this._dataSource);

  @override
  Future<List<Job>> getJobs() {
    return _dataSource.getJobs();
  }

  @override
  Future<Job?> getJobById(String jobId) {
    return _dataSource.getJobById(jobId);
  }

  @override
  Future<List<Job>> searchJobs(String query) {
    return _dataSource.searchJobs(query);
  }

  @override
  Future<List<Job>> getJobsByEmployer(String employerId) {
    return _dataSource.getJobsByEmployer(employerId);
  }

  @override
  Future<List<Job>> getNearbyJobs({
    required double latitude,
    required double longitude,
    required double radiusInKm,
  }) async {
    final jobs = await _dataSource.getJobs();

    final nearbyJobs = jobs.where((job) {
      if (job.location.toLowerCase().contains('remote')) {
        return false;
      }

      if (job.latitude == null || job.longitude == null) {
        return false;
      }

      final distance = DistanceCalculator.calculateDistance(
        startLatitude: latitude,
        startLongitude: longitude,
        endLatitude: job.latitude!,
        endLongitude: job.longitude!,
      );

      return distance <= radiusInKm;
    }).toList();

    nearbyJobs.sort((a, b) {
      final distanceA = DistanceCalculator.calculateDistance(
        startLatitude: latitude,
        startLongitude: longitude,
        endLatitude: a.latitude!,
        endLongitude: a.longitude!,
      );

      final distanceB = DistanceCalculator.calculateDistance(
        startLatitude: latitude,
        startLongitude: longitude,
        endLatitude: b.latitude!,
        endLongitude: b.longitude!,
      );

      return distanceA.compareTo(distanceB);
    });

    return nearbyJobs;
  }
}
