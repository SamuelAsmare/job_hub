import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_profile.freezed.dart';

/// Immutable employer company profile model.
@freezed
abstract class EmployerProfile with _$EmployerProfile {
  const factory EmployerProfile({
    required String employerId,
    required String companyName,
    required String industry,
    required String description,
    String? location,
    String? website,
    String? phone,
    String? logoUrl,
  }) = _EmployerProfile;
}
