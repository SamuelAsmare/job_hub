import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/application_local_datasource.dart';
import '../../data/repositories/application_repository_impl.dart';
import '../../domain/models/application.dart';
import '../../domain/repositories/application_repository.dart';

// Creates the local data source.
final applicationLocalDataSourceProvider =
    Provider<ApplicationLocalDataSource>((ref) {
  return ApplicationLocalDataSource();
});

// Connects the repository to the local data source.
final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  final dataSource = ref.watch(applicationLocalDataSourceProvider);

  return ApplicationRepositoryImpl(dataSource);
});

// Loads all applications.
final applicationsProvider = FutureProvider<List<Application>>((ref) {
  final repository = ref.watch(applicationRepositoryProvider);

  return repository.getApplications();
});

// Loads applications belonging to one applicant.
final applicationsByApplicantProvider =
    FutureProvider.family<List<Application>, String>(
  (ref, applicantId) {
    final repository = ref.watch(applicationRepositoryProvider);

    return repository.getApplicationsByApplicant(applicantId);
  },
);

// Loads one application using its ID.
final applicationByIdProvider =
    FutureProvider.family<Application?, String>((ref, applicationId) {
  final repository = ref.watch(applicationRepositoryProvider);

  return repository.getApplicationById(applicationId);
});

// Checks whether an applicant has already applied for a job.
final hasAlreadyAppliedProvider =
    FutureProvider.family<bool, ApplicationCheckParams>((ref, params) {
  final repository = ref.watch(applicationRepositoryProvider);

  return repository.hasAlreadyApplied(
    params.jobId,
    params.applicantId,
  );
});

// Provides actions for submitting applications.
final applicationActionsProvider = Provider<ApplicationActions>((ref) {
  final repository = ref.watch(applicationRepositoryProvider);

  return ApplicationActions(repository);
});

class ApplicationActions {
  const ApplicationActions(this._repository);

  final ApplicationRepository _repository;

  Future<void> submitApplication(Application application) {
    return _repository.submitApplication(application);
  }
}

// Groups the two values required by the duplicate-check provider.
class ApplicationCheckParams {
  const ApplicationCheckParams({
    required this.jobId,
    required this.applicantId,
  });

  final String jobId;
  final String applicantId;

  @override
  bool operator ==(Object other) {
    return other is ApplicationCheckParams &&
        other.jobId == jobId &&
        other.applicantId == applicantId;
  }

  @override
  int get hashCode => Object.hash(jobId, applicantId);
}
