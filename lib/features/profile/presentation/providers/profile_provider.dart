import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../data/repositories/job_seeker_profile_repository_impl.dart';
import '../../domain/models/job_seeker_profile.dart';
import '../../domain/repositories/job_seeker_profile_repository.dart';

/// Provides the local profile data source.
final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource();
});

/// Provides the profile repository.
final jobSeekerProfileRepositoryProvider =
    Provider<JobSeekerProfileRepository>((ref) {
  return JobSeekerProfileRepositoryImpl(
    ref.watch(profileLocalDataSourceProvider),
  );
});

/// Provides the authenticated user's profile.
final profileProvider = FutureProvider<JobSeekerProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);

  if (user == null) {
    return null;
  }

  return ref.watch(jobSeekerProfileRepositoryProvider).getProfile(user.id);
});

/// Updates the authenticated user's profile.
final updateProfileProvider = Provider<
    Future<void> Function(
      JobSeekerProfile profile,
    )>((ref) {
  return (profile) async {
    await ref.read(jobSeekerProfileRepositoryProvider).updateProfile(profile);

    ref.invalidate(profileProvider);
  };
});
