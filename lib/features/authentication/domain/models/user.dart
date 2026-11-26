import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum UserRole {
  jobSeeker,
  employer,
}

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String fullName,
    required String email,
    required UserRole role,
    String? profileImage,
  }) = _User;
}
