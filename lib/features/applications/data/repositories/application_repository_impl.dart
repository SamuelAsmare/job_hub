import '../../domain/models/application.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/application_local_datasource.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  ApplicationRepositoryImpl(this._dataSource);

  final ApplicationLocalDataSource _dataSource;

  @override
  Future<List<Application>> getApplications() {
    return _dataSource.getApplications();
  }

  @override
  Future<Application?> getApplicationById(String id) {
    return _dataSource.getApplicationById(id);
  }

  @override
  Future<List<Application>> getApplicationsByApplicant(String applicantId) {
    return _dataSource.getApplicationsByApplicant(applicantId);
  }

  @override
  Future<bool> hasAlreadyApplied(String jobId, String applicantId) {
    return _dataSource.hasAlreadyApplied(jobId, applicantId);
  }

  @override
  Future<void> submitApplication(Application application) async {
    if (await hasAlreadyApplied(application.jobId, application.applicantId)) {
      throw DuplicateApplicationException(
        jobId: application.jobId,
        applicantId: application.applicantId,
      );
    }

    await _dataSource.addApplication(application);
  }
}

class DuplicateApplicationException implements Exception {
  const DuplicateApplicationException({
    required this.jobId,
    required this.applicantId,
  });

  final String jobId;
  final String applicantId;

  @override
  String toString() =>
      'Applicant "$applicantId" has already applied to job "$jobId".';
}