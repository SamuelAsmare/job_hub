import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/applications/data/datasources/application_local_datasource.dart';
import 'package:job_hub/features/applications/data/repositories/application_repository_impl.dart';
import 'package:job_hub/features/applications/domain/models/application.dart';

void main() {
  late ApplicationLocalDataSource dataSource;
  late ApplicationRepositoryImpl repository;

  setUp(() {
    dataSource = ApplicationLocalDataSource(
      initialApplications: const [],
    );
    repository = ApplicationRepositoryImpl(dataSource);
  });

  Application createApplication({
    String id = 'application-1',
    String jobId = 'job-1',
    String applicantId = 'applicant-1',
  }) {
    return Application(
      id: id,
      jobId: jobId,
      jobTitle: 'Flutter Developer',
      companyName: 'JobHub',
      applicantId: applicantId,
      cvReference: 'resume.pdf',
      cvFileName: 'resume.pdf',
      coverLetter: 'I am interested in this position.',
      appliedAt: DateTime(2026, 11, 26),
    );
  }

  group('ApplicationRepository', () {
    test('submits a new application successfully', () async {
      final application = createApplication();

      await repository.submitApplication(application);

      final applications = await repository.getApplications();

      expect(applications, hasLength(1));
      expect(applications.first.id, application.id);
    });

    test('prevents an applicant from applying to the same job twice', () async {
      final firstApplication = createApplication();
      final duplicateApplication = createApplication(
        id: 'application-2',
      );

      await repository.submitApplication(firstApplication);

      expect(
        () => repository.submitApplication(duplicateApplication),
        throwsA(isA<DuplicateApplicationException>()),
      );
    });

    test('allows the same applicant to apply to different jobs', () async {
      await repository.submitApplication(createApplication());

      final secondApplication = createApplication(
        id: 'application-2',
        jobId: 'job-2',
      );

      await repository.submitApplication(secondApplication);

      final applications = await repository.getApplications();

      expect(applications, hasLength(2));
    });
  });
}
