import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/saved_jobs/data/repositories/saved_job_repository_impl.dart';
import 'package:job_hub/features/saved_jobs/domain/models/saved_job.dart';
import 'package:job_hub/features/saved_jobs/domain/repositories/saved_job_repository.dart';
import 'package:job_hub/features/saved_jobs/presentation/providers/saved_job_provider.dart';

class ErrorThrowingSavedJobRepository implements SavedJobRepository {
  @override
  Future<List<SavedJob>> getSavedJobs(String userId) async {
    throw Exception('Failed to load saved jobs');
  }

  @override
  Future<void> saveJob(SavedJob savedJob) async {
    throw Exception('Failed to save job');
  }

  @override
  Future<void> removeSavedJob(String userId, String jobId) async {
    throw Exception('Failed to remove saved job');
  }

  @override
  Future<bool> isJobSaved(String userId, String jobId) async {
    throw Exception('Failed to check saved status');
  }
}

void main() {
  group('savedJobsProvider', () {
    late ProviderContainer container;
    late SavedJobRepositoryImpl repository;
    final initialJobs = [
      SavedJob(
        id: 'saved_001',
        userId: 'user_001',
        jobId: 'job_001',
        savedAt: DateTime(2026, 11, 20),
      ),
      SavedJob(
        id: 'saved_002',
        userId: 'user_001',
        jobId: 'job_002',
        savedAt: DateTime(2026, 11, 22),
      ),
    ];

    setUp(() {
      repository = SavedJobRepositoryImpl(initialSavedJobs: initialJobs);
      container = ProviderContainer(
        overrides: [
          savedJobRepositoryProvider.overrideWithValue(repository),
          currentUserIdProvider.overrideWithValue('user_001'),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial saved jobs are loaded from the repository and provider exposes expected records', () async {
      final subscription = container.listen(savedJobsProvider, (_, __) {});
      addTearDown(subscription.close);

      final jobs = await container.read(savedJobsProvider.future);
      expect(jobs.length, 2);
      expect(jobs.first.jobId, 'job_001');
      expect(jobs.last.jobId, 'job_002');
    });

    test('Saving a job updates the exposed state', () async {
      final subscription = container.listen(savedJobsProvider, (_, __) {});
      addTearDown(subscription.close);

      await container.read(savedJobsProvider.future);

      final newJob = SavedJob(
        id: 'saved_003',
        userId: 'user_001',
        jobId: 'job_003',
        savedAt: DateTime.now(),
      );

      await container.read(savedJobsProvider.notifier).saveJob(newJob);

      final updatedJobs = container.read(savedJobsProvider).value;
      expect(updatedJobs, isNotNull);
      expect(updatedJobs!.length, 3);
      expect(updatedJobs.any((j) => j.jobId == 'job_003'), isTrue);
    });

    test('Removing a job updates the exposed state', () async {
      final subscription = container.listen(savedJobsProvider, (_, __) {});
      addTearDown(subscription.close);

      await container.read(savedJobsProvider.future);

      await container.read(savedJobsProvider.notifier).removeSavedJob('job_001');

      final updatedJobs = container.read(savedJobsProvider).value;
      expect(updatedJobs, isNotNull);
      expect(updatedJobs!.length, 1);
      expect(updatedJobs.first.jobId, 'job_002');
    });

    test('isJobSaved returns accurate status', () async {
      final subscription = container.listen(savedJobsProvider, (_, __) {});
      addTearDown(subscription.close);

      await container.read(savedJobsProvider.future);

      final notifier = container.read(savedJobsProvider.notifier);
      expect(notifier.isJobSaved('job_001'), isTrue);
      expect(notifier.isJobSaved('job_999'), isFalse);
    });

    test('Repository errors are handled correctly', () async {
      final testContainer = ProviderContainer(
        overrides: [
          savedJobRepositoryProvider.overrideWithValue(ErrorThrowingSavedJobRepository()),
          currentUserIdProvider.overrideWithValue('user_001'),
        ],
      );
      addTearDown(testContainer.dispose);

      final sub = testContainer.listen(savedJobsProvider, (_, __) {});
      addTearDown(sub.close);

      await pumpEventQueue();

      expect(testContainer.read(savedJobsProvider).hasError, isTrue);
    });
  });
}
