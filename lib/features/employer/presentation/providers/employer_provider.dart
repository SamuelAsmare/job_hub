import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../jobs/domain/models/job.dart';
import '../../data/datasources/employer_local_datasource.dart';
import '../../data/repositories/employer_repository_impl.dart';
import '../../domain/models/employer_profile.dart';
import '../../domain/repositories/employer_repository.dart';

final employerLocalDataSourceProvider =
    Provider<EmployerLocalDataSource>((ref) {
  return EmployerLocalDataSource();
});

final employerRepositoryProvider = Provider<EmployerRepository>((ref) {
  return EmployerRepositoryImpl(
    ref.watch(employerLocalDataSourceProvider),
  );
});

final employerProfileProvider =
    FutureProvider.family<EmployerProfile?, String>((ref, employerId) {
  return ref.watch(employerRepositoryProvider).getEmployerProfile(employerId);
});

final employerVacanciesProvider =
    FutureProvider.family<List<Job>, String>((ref, employerId) {
  return ref.watch(employerRepositoryProvider).getVacancies(employerId);
});

final employerVacancyProvider =
    FutureProvider.family<Job?, ({String employerId, String vacancyId})>(
  (ref, params) {
    return ref.watch(employerRepositoryProvider).getVacancyById(
          employerId: params.employerId,
          vacancyId: params.vacancyId,
        );
  },
);

final employerIdProvider = Provider<String>((ref) {
  return ref.watch(currentUserIdProvider) ?? 'user_002';
});
