import '../../domain/models/saved_job.dart';
import '../../domain/repositories/saved_job_repository.dart';
import '../sample_data/sample_saved_jobs.dart';

class SavedJobRepositoryImpl implements SavedJobRepository {
  SavedJobRepositoryImpl({List<SavedJob>? initialSavedJobs})
      : _savedJobs = List<SavedJob>.from(initialSavedJobs ?? sampleSavedJobs);

  final List<SavedJob> _savedJobs;

  @override
  Future<List<SavedJob>> getSavedJobs(String userId) async {
    return _savedJobs.where((saved) => saved.userId == userId).toList();
  }

  @override
  Future<void> saveJob(SavedJob savedJob) async {
    final alreadySaved = _savedJobs.any(
      (item) => item.userId == savedJob.userId && item.jobId == savedJob.jobId,
    );
    if (!alreadySaved) {
      _savedJobs.add(savedJob);
    }
  }

  @override
  Future<void> removeSavedJob(String userId, String jobId) async {
    _savedJobs.removeWhere(
      (item) => item.userId == userId && item.jobId == jobId,
    );
  }

  @override
  Future<bool> isJobSaved(String userId, String jobId) async {
    return _savedJobs.any(
      (item) => item.userId == userId && item.jobId == jobId,
    );
  }
}
