import '../../domain/models/application.dart';
import '../sample_data/sample_applications.dart';

class ApplicationLocalDataSource {
  ApplicationLocalDataSource({List<Application>? initialApplications})
      : _applications = List.of(initialApplications ?? sampleApplications);

  final List<Application> _applications;

  Future<List<Application>> getApplications() async {
    return List.unmodifiable(_applications);
  }

  Future<Application?> getApplicationById(String id) async {
    for (final application in _applications) {
      if (application.id == id) {
        return application;
      }
    }
    return null;
  }

  Future<List<Application>> getApplicationsByApplicant(
    String applicantId,
  ) async {
    return List.unmodifiable(
      _applications
          .where((application) => application.applicantId == applicantId),
    );
  }

  Future<bool> hasAlreadyApplied(String jobId, String applicantId) async {
    return _applications.any(
      (application) =>
          application.jobId == jobId &&
          application.applicantId == applicantId,
    );
  }

  Future<void> addApplication(Application application) async {
    _applications.add(application);
  }
}