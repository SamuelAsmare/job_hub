import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/jobs/data/sample_data/sample_jobs.dart';

void main() {
  group('Job model', () {
    test('should contain the three required sample jobs', () {
      expect(sampleJobs.length, 3);

      expect(
        sampleJobs.map((job) => job.id).toList(),
        ['job_001', 'job_002', 'job_003'],
      );
    });

    test('should contain required job information', () {
      final job = sampleJobs.first;

      expect(job.title, isNotEmpty);
      expect(job.companyName, isNotEmpty);
      expect(job.location, isNotEmpty);
      expect(job.description, isNotEmpty);
      expect(job.requirements, isNotEmpty);
      expect(job.employerId, isNotEmpty);
    });

    test('should support copyWith without modifying the original job', () {
      final originalJob = sampleJobs.first;

      final updatedJob = originalJob.copyWith(
        title: 'Updated Flutter Developer',
      );

      expect(updatedJob.title, 'Updated Flutter Developer');
      expect(originalJob.title, 'Senior Flutter Developer');
    });

    test('should support value equality', () {
      final job = sampleJobs.first;
      final copiedJob = job.copyWith();

      expect(copiedJob, job);
    });
  });
}
