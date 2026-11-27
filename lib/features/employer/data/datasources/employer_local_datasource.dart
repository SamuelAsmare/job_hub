import '../../../jobs/domain/models/job.dart';
import '../../domain/models/employer_profile.dart';

class EmployerLocalDataSource {
  final Map<String, EmployerProfile> _profiles = {};

  final List<Job> _vacancies = [];

  // --------------------------------------------------
  // Employer Profile
  // --------------------------------------------------

  Future<EmployerProfile?> getEmployerProfile(String employerId) async {
    return _profiles[employerId];
  }

  Future<void> saveEmployerProfile(EmployerProfile profile) async {
    _profiles[profile.employerId] = profile;
  }

  // --------------------------------------------------
  // Vacancies
  // --------------------------------------------------

  Future<List<Job>> getVacancies(String employerId) async {
    final vacancies = _vacancies
        .where((vacancy) => vacancy.employerId == employerId)
        .toList();

    return List.unmodifiable(vacancies);
  }

  Future<Job?> getVacancyById({
    required String employerId,
    required String vacancyId,
  }) async {
    for (final vacancy in _vacancies) {
      if (vacancy.id == vacancyId && vacancy.employerId == employerId) {
        return vacancy;
      }
    }

    return null;
  }

  Future<void> addVacancy(Job vacancy) async {
    final alreadyExists = _vacancies.any(
      (existing) => existing.id == vacancy.id,
    );

    if (alreadyExists) {
      throw StateError('A vacancy with this ID already exists.');
    }

    _vacancies.add(vacancy);
  }

  Future<void> updateVacancy(Job vacancy) async {
    final index = _vacancies.indexWhere(
      (existing) =>
          existing.id == vacancy.id &&
          existing.employerId == vacancy.employerId,
    );

    if (index == -1) {
      throw StateError('Vacancy not found or access denied.');
    }

    _vacancies[index] = vacancy;
  }

  Future<void> deleteVacancy({
    required String employerId,
    required String vacancyId,
  }) async {
    final index = _vacancies.indexWhere(
      (vacancy) => vacancy.id == vacancyId && vacancy.employerId == employerId,
    );

    if (index == -1) {
      throw StateError('Vacancy not found or access denied.');
    }

    _vacancies.removeAt(index);
  }
}
