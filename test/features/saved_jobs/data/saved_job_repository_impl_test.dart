import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/saved_jobs/data/repositories/saved_job_repository_impl.dart';
import 'package:job_hub/features/saved_jobs/domain/models/saved_job.dart';

void main() {
  group('SavedJobRepositoryImpl', () {
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
      SavedJob(
        id: 'saved_003',
        userId: 'user_002',
        jobId: 'job_001',
        savedAt: DateTime(2026, 11, 23),
      ),
    ];

    setUp(() {
      repository = SavedJobRepositoryImpl(initialSavedJobs: initialJobs);
    });

    test('getSavedJobs returns only records belonging to the requested user', () async {
      final user1Jobs = await repository.getSavedJobs('user_001');
      expect(user1Jobs.length, 2);
      expect(user1Jobs.every((j) => j.userId == 'user_001'), isTrue);

      final user2Jobs = await repository.getSavedJobs('user_002');
      expect(user2Jobs.length, 1);
      expect(user2Jobs.first.jobId, 'job_001');

      final user3Jobs = await repository.getSavedJobs('user_unknown');
      expect(user3Jobs, isEmpty);
    });

    test('saveJob adds a saved record', () async {
      final newSavedJob = SavedJob(
        id: 'saved_004',
        userId: 'user_001',
        jobId: 'job_003',
        savedAt: DateTime.now(),
      );

      await repository.saveJob(newSavedJob);
      final jobs = await repository.getSavedJobs('user_001');
      expect(jobs.length, 3);
      expect(jobs.any((j) => j.jobId == 'job_003'), isTrue);
    });

    test('Saving the same job twice does not create duplicates', () async {
      final duplicateJob = SavedJob(
        id: 'saved_999',
        userId: 'user_001',
        jobId: 'job_001',
        savedAt: DateTime.now(),
      );

      await repository.saveJob(duplicateJob);
      final jobs = await repository.getSavedJobs('user_001');
      expect(jobs.length, 2);
    });

    test('removeSavedJob removes the correct record', () async {
      await repository.removeSavedJob('user_001', 'job_001');
      final jobs = await repository.getSavedJobs('user_001');
      expect(jobs.length, 1);
      expect(jobs.first.jobId, 'job_002');
      expect(await repository.isJobSaved('user_001', 'job_001'), isFalse);
    });

    test('Removing a job for one user does not affect another user\'s records', () async {
      await repository.removeSavedJob('user_001', 'job_001');
      final user2Jobs = await repository.getSavedJobs('user_002');
      expect(user2Jobs.length, 1);
      expect(user2Jobs.first.jobId, 'job_001');
    });

    test('isJobSaved returns true for saved jobs', () async {
      expect(await repository.isJobSaved('user_001', 'job_001'), isTrue);
      expect(await repository.isJobSaved('user_001', 'job_002'), isTrue);
      expect(await repository.isJobSaved('user_002', 'job_001'), isTrue);
    });

    test('isJobSaved returns false for jobs that are not saved', () async {
      expect(await repository.isJobSaved('user_001', 'job_999'), isFalse);
      expect(await repository.isJobSaved('user_002', 'job_002'), isFalse);
      expect(await repository.isJobSaved('user_unknown', 'job_001'), isFalse);
    });
  });
}
