import '../models/job_seeker_profile.dart';

abstract class JobSeekerProfileRepository {
  Future<JobSeekerProfile?> getProfile(String userId);

  Future<void> updateProfile(JobSeekerProfile profile);
}
