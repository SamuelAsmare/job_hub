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

/// Represents basic display attributes of a Job resolved for presentation.
class JobSummary {
  const JobSummary({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.category,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String category;
}

/// Fallback sample job resolution map matching the shared Jobs agreement.
/// This allows Saved Jobs to display rich job details and can be overridden
/// by the Jobs feature's provider when integrated.
final sampleJobCatalogProvider = Provider<Map<String, JobSummary>>((ref) {
  return const {
    'job_001': JobSummary(
      id: 'job_001',
      title: 'Senior Flutter Developer',
      company: 'TechCorp Solutions',
      location: 'Addis Ababa, Ethiopia',
      salary: '\$3,000 - \$4,500 / month',
      type: 'Full-time',
      category: 'Software Development',
    ),
    'job_002': JobSummary(
      id: 'job_002',
      title: 'Mobile UI/UX Designer',
      company: 'Creative Hive Studio',
      location: 'Remote',
      salary: '\$2,500 - \$3,500 / month',
      type: 'Full-time',
      category: 'Design & Creative',
    ),
    'job_003': JobSummary(
      id: 'job_003',
      title: 'Backend Engineer (Dart / Go)',
      company: 'CloudScale Systems',
      location: 'Addis Ababa (Hybrid)',
      salary: '\$2,800 - \$4,000 / month',
      type: 'Full-time',
      category: 'Backend Engineering',
    ),
  };
});

/// Provider to resolve job summary details for a given [jobId].
final jobDetailsResolverProvider =
    Provider.family<JobSummary?, String>((ref, jobId) {
  final catalog = ref.watch(sampleJobCatalogProvider);
  return catalog[jobId];
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
