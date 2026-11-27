import '../../domain/models/employer_profile.dart';
import '../../domain/repositories/employer_repository.dart';
import '../../../jobs/domain/models/job.dart';
import '../datasources/employer_local_datasource.dart';

class EmployerRepositoryImpl implements EmployerRepository {
  EmployerRepositoryImpl(this._dataSource);

  final EmployerLocalDataSource _dataSource;

  // --------------------------------------------------
  // Employer Profile
  // --------------------------------------------------

  @override
  Future<EmployerProfile?> getEmployerProfile(String employerId) {
    return _dataSource.getEmployerProfile(employerId);
  }

  @override
  Future<void> saveEmployerProfile(EmployerProfile profile) {
    return _dataSource.saveEmployerProfile(profile);
  }

  // --------------------------------------------------
  // Vacancy Management
  // --------------------------------------------------

  @override
  Future<List<Job>> getVacancies(String employerId) {
    return _dataSource.getVacancies(employerId);
  }

  @override
  Future<Job?> getVacancyById({
    required String employerId,
    required String vacancyId,
  }) {
    return _dataSource.getVacancyById(
      employerId: employerId,
      vacancyId: vacancyId,
    );
  }

  @override
  Future<Job> createVacancy(Job vacancy) async {
    final newVacancy = Job(
      id: 'vacancy_${DateTime.now().microsecondsSinceEpoch}',
      title: vacancy.title,
      companyName: vacancy.companyName,
      companyLogo: vacancy.companyLogo,
      location: vacancy.location,
      description: vacancy.description,
      requirements: vacancy.requirements,
      employmentType: vacancy.employmentType,
      salary: vacancy.salary,
      postedAt: vacancy.postedAt,
      deadline: vacancy.deadline,
      employerId: vacancy.employerId,
      latitude: vacancy.latitude,
      longitude: vacancy.longitude,
    );

    await _dataSource.addVacancy(newVacancy);
    return newVacancy;
  }

  @override
  Future<void> updateVacancy(Job vacancy) {
    return _dataSource.updateVacancy(vacancy);
  }

  @override
  Future<void> deleteVacancy({
    required String employerId,
    required String vacancyId,
  }) {
    return _dataSource.deleteVacancy(
      employerId: employerId,
      vacancyId: vacancyId,
    );
  }
}
