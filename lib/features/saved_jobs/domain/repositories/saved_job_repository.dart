import '../models/saved_job.dart';

abstract class SavedJobRepository {
  Future<List<SavedJob>> getSavedJobs(String userId);

  Future<void> saveJob(SavedJob savedJob);

  Future<void> removeSavedJob(String userId, String jobId);

  Future<bool> isJobSaved(String userId, String jobId);
}
