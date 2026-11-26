
import '../models/job.dart';

abstract class JobRepository {
  /// Returns all available jobs.
  Future<List<Job>> getJobs();

  /// Finds a job using its unique ID.
  Future<Job?> getJobById(String jobId);

  /// Searches jobs by title, company, or location.
  Future<List<Job>> searchJobs(String query);

  /// Returns jobs posted by a specific employer.
  Future<List<Job>> getJobsByEmployer(String employerId);

  /// Returns jobs within a specified distance from the seeker's location.
  Future<List<Job>> getNearbyJobs({
    required double latitude,
    required double longitude,
    required double radiusInKm,
  });
}
