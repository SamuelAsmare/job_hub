import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_seeker_profile.freezed.dart';

@freezed
abstract class JobSeekerProfile with _$JobSeekerProfile {
  const factory JobSeekerProfile({
    required String userId,
    String? phone,
    String? bio,
    @Default(<String>[]) List<String> skills,
    @Default(<String>[]) List<String> education,
    @Default(<String>[]) List<String> experience,
    String? cvUrl,
  }) = _JobSeekerProfile;
}
