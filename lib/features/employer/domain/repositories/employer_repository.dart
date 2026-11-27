import '../models/employer_profile.dart';
import '../../../jobs/domain/models/job.dart';

abstract interface class EmployerRepository {
  // Employer profile operations.
  Future<EmployerProfile?> getEmployerProfile(String employerId);

  Future<void> saveEmployerProfile(EmployerProfile profile);

  // Vacancy operations.
  Future<List<Job>> getVacancies(String employerId);

  Future<Job?> getVacancyById({
    required String employerId,
    required String vacancyId,
  });
  Future<Job> createVacancy(Job vacancy);

  Future<void> updateVacancy(Job vacancy);

  Future<void> deleteVacancy({
    required String employerId,
    required String vacancyId,
  });
}
