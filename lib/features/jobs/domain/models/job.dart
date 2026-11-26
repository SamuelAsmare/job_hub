import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';

@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    required String companyName,
    String? companyLogo,
    required String location,
    required String description,
    required List<String> requirements,
    required String employmentType,
    String? salary,
    required DateTime postedAt,
    DateTime? deadline,
    required String employerId,
    double? latitude,
    double? longitude,
  }) = _Job;
}
