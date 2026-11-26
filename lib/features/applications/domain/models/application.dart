import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.freezed.dart';

enum ApplicationStatus {
  pending,
  reviewed,
  shortlisted,
  accepted,
  rejected,
}

@freezed
abstract class ApplicationAiReview with _$ApplicationAiReview {
  const factory ApplicationAiReview({
    @Default(<String>[]) List<String> strengths,
    @Default(<String>[]) List<String> weaknesses,
    @Default(<String>[]) List<String> missingInformation,
    @Default(<String>[]) List<String> grammarSuggestions,
    @Default(<String>[]) List<String> improvementRecommendations,
  }) = _ApplicationAiReview;
}

@freezed
abstract class Application with _$Application {
  const factory Application({
    required String id,
    required String jobId,
    required String jobTitle,
    required String companyName,
    required String applicantId,
    required String cvReference,
    required String cvFileName,
    required String coverLetter,
    required DateTime appliedAt,
    @Default(ApplicationStatus.pending) ApplicationStatus status,
    ApplicationAiReview? aiReview,
    String? employerFeedback,
  }) = _Application;
}
