import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_job.freezed.dart';

@freezed
abstract class SavedJob with _$SavedJob {
  const factory SavedJob({
    required String id,
    required String userId,
    required String jobId,
    required DateTime savedAt,
  }) = _SavedJob;
}
