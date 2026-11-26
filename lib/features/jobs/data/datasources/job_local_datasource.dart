import '../../domain/models/job.dart';
import '../sample_data/sample_jobs.dart';

class JobLocalDataSource {
  final List<Job> _jobs = List.of(sampleJobs);

  Future<List<Job>> getJobs() async {
    return List.unmodifiable(_jobs);
  }

  Future<Job?> getJobById(String jobId) async {
    for (final job in _jobs) {
      if (job.id == jobId) {
        return job;
      }
    }
    return null;
  }

  Future<List<Job>> searchJobs(String query) async {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return getJobs();
    }

    return _jobs.where((job) {
      return job.title.toLowerCase().contains(normalizedQuery) ||
          job.companyName.toLowerCase().contains(normalizedQuery) ||
          job.location.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  Future<List<Job>> getJobsByEmployer(String employerId) async {
    return _jobs.where((job) => job.employerId == employerId).toList();
  }
}
