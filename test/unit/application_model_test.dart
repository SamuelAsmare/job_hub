import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/applications/domain/models/application.dart';

void main() {
  group('Application model', () {
    test('creates an application with a pending status by default', () {
      final appliedAt = DateTime(2026, 11, 26);
      final application = Application(
        id: 'application-1',
        jobId: 'job-1',
        jobTitle: 'Flutter Developer',
        companyName: 'JobHub',
        applicantId: 'applicant-1',
        cvReference: '/files/resume.pdf',
        cvFileName: 'resume.pdf',
        coverLetter: 'I am interested in this role.',
        appliedAt: appliedAt,
      );

      expect(application.status, ApplicationStatus.pending);
      expect(application.appliedAt, appliedAt);
      expect(application.cvReference, '/files/resume.pdf');
    });

    test('keeps the optional resume review and employer feedback', () {
      const review = ApplicationAiReview(
        strengths: ['Clear work history'],
        weaknesses: ['No summary section'],
      );
      final application = Application(
        id: 'application-2',
        jobId: 'job-2',
        jobTitle: 'Designer',
        companyName: 'Studio',
        applicantId: 'applicant-1',
        cvReference: 'resume.docx',
        cvFileName: 'resume.docx',
        coverLetter: 'Please consider my application.',
        appliedAt: DateTime(2026, 11, 26),
        status: ApplicationStatus.reviewed,
        aiReview: review,
        employerFeedback: 'We are reviewing your profile.',
      );

      expect(application.status, ApplicationStatus.reviewed);
      expect(application.aiReview, review);
      expect(application.employerFeedback, isNotNull);
    });
  });
}
