import '../../domain/models/job_seeker_profile.dart';

class ProfileLocalDataSource {
  ProfileLocalDataSource()
      : _profiles = {
          'user_001': const JobSeekerProfile(
            userId: 'user_001',
            phone: '+251911000001',
            bio:
                'Computer Science graduate interested in software development.',
            skills: [
              'Flutter',
              'Dart',
              'Python',
              'Problem Solving',
            ],
            education: [
              'BSc Computer Science - Addis Ababa University',
            ],
            experience: [
              'Junior Software Developer - Internship',
            ],
            cvUrl: 'sample_cv_abebe.pdf',
          ),
        };

  final Map<String, JobSeekerProfile> _profiles;

  Future<JobSeekerProfile?> getProfile(String userId) async {
    return _profiles[userId];
  }

  Future<void> updateProfile(JobSeekerProfile profile) async {
    _profiles[profile.userId] = profile;
  }
}
