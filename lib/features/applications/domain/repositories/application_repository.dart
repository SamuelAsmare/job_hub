import '../models/application.dart';

abstract interface class ApplicationRepository {
  Future<List<Application>> getApplications();

  Future<Application?> getApplicationById(String id);

  Future<List<Application>> getApplicationsByApplicant(String applicantId);

  Future<void> submitApplication(Application application);

  Future<bool> hasAlreadyApplied(String jobId, String applicantId);
}