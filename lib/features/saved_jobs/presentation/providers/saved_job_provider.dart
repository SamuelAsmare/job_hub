import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/saved_job_repository_impl.dart';
import '../../data/sample_data/sample_saved_jobs.dart';
import '../../domain/models/saved_job.dart';
import '../../domain/repositories/saved_job_repository.dart';

/// Provider for the [SavedJobRepository] implementation.
final savedJobRepositoryProvider = Provider<SavedJobRepository>((ref) {
  return SavedJobRepositoryImpl();
});

/// Provider for the current active sample user ID.
final currentUserIdProvider = Provider<String>((ref) {
  return sampleUserId;
});

/// Riverpod AsyncNotifier managing the state of saved jobs for the active user.
class SavedJobsNotifier extends AsyncNotifier<List<SavedJob>> {
  @override
  Future<List<SavedJob>> build() async {
    final repository = ref.watch(savedJobRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);
    return repository.getSavedJobs(userId);
  }

  /// Saves a job and refreshes state.
  Future<void> saveJob(SavedJob savedJob) async {
    final repository = ref.read(savedJobRepositoryProvider);
    await repository.saveJob(savedJob);
    ref.invalidateSelf();
    await future;
  }

  /// Removes a saved job matching [jobId] for the current user and updates state.
  Future<void> removeSavedJob(String jobId) async {
    final repository = ref.read(savedJobRepositoryProvider);
    final userId = ref.read(currentUserIdProvider);
    await repository.removeSavedJob(userId, jobId);
    ref.invalidateSelf();
    await future;
  }

  /// Checks whether a job is currently saved for the active user.
  bool isJobSaved(String jobId) {
    final currentList = state.value;
    if (currentList == null) return false;
    return currentList.any((item) => item.jobId == jobId);
  }

  /// Manually reloads saved jobs from the repository.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// The main provider exposing the list of saved jobs to the UI.
final savedJobsProvider =
    AsyncNotifierProvider<SavedJobsNotifier, List<SavedJob>>(
  SavedJobsNotifier.new,
);
