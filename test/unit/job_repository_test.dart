import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/jobs/data/datasources/job_local_datasource.dart';
import 'package:job_hub/features/jobs/data/repositories/job_repository_impl.dart';

void main() {
  late JobLocalDataSource dataSource;
  late JobRepositoryImpl repository;

  setUp(() {
    dataSource = JobLocalDataSource();
    repository = JobRepositoryImpl(dataSource);
  });

  group('JobRepository', () {
    test('should return all available jobs', () async {
      final jobs = await repository.getJobs();

      expect(jobs.length, 3);
    });

    test('should find a job by its ID', () async {
      final job = await repository.getJobById('job_001');

      expect(job, isNotNull);
      expect(job!.title, 'Senior Flutter Developer');
    });

    test('should return null for an unknown job ID', () async {
      final job = await repository.getJobById('unknown_job');

      expect(job, isNull);
    });

    test('should search jobs by title', () async {
      final jobs = await repository.searchJobs('Flutter');

      expect(jobs.length, 1);
      expect(jobs.first.id, 'job_001');
    });

    test('should search jobs by company name', () async {
      final jobs = await repository.searchJobs('Creative Hive');

      expect(jobs.length, 1);
      expect(jobs.first.id, 'job_002');
    });

    test('should search jobs by location', () async {
      final jobs = await repository.searchJobs('Remote');

      expect(jobs.length, 1);
      expect(jobs.first.id, 'job_002');
    });

    test('should return all jobs for an empty search query', () async {
      final jobs = await repository.searchJobs('');

      expect(jobs.length, 3);
    });

    test('should filter jobs by employer ID', () async {
      final jobs = await repository.getJobsByEmployer('emp_001');

      expect(jobs.length, 1);
      expect(jobs.first.id, 'job_001');
    });
  });
}
