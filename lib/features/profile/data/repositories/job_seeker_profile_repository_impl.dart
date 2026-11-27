import '../../domain/models/job_seeker_profile.dart';
import '../../domain/repositories/job_seeker_profile_repository.dart';
import '../datasources/profile_local_datasource.dart';

class JobSeekerProfileRepositoryImpl implements JobSeekerProfileRepository {
  JobSeekerProfileRepositoryImpl(this._dataSource);

  final ProfileLocalDataSource _dataSource;

  @override
  Future<JobSeekerProfile?> getProfile(String userId) {
    return _dataSource.getProfile(userId);
  }

  @override
  Future<void> updateProfile(JobSeekerProfile profile) {
    return _dataSource.updateProfile(profile);
  }
}
