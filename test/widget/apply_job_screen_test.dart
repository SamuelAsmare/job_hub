import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/applications/presentation/screens/apply_job_screen.dart';
import 'package:job_hub/features/jobs/domain/models/job.dart';

void main() {
  late Job testJob;

  setUp(() {
    testJob = Job(
      id: 'job-1',
      title: 'Flutter Developer',
      companyName: 'JobHub',
      location: 'Addis Ababa',
      description: 'Develop mobile applications.',
      requirements: const ['Flutter', 'Dart'],
      employmentType: 'Full-time',
      postedAt: DateTime(2026, 11, 26),
      employerId: 'employer-1',
    );
  });

  Widget createTestApp() {
    return ProviderScope(
      child: MaterialApp(
        home: ApplyJobScreen(
          job: testJob,
          applicantId: 'applicant-1',
        ),
      ),
    );
  }

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createTestApp());
  }

  group('ApplyJobScreen', () {
    testWidgets('displays the selected job information', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('JobHub'), findsOneWidget);
      expect(find.text('Apply for Job'), findsOneWidget);
    });

    testWidgets('shows an error when cover letter is empty', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Submit Application'));
      await tester.pump();

      expect(find.text('Please write a cover letter.'), findsOneWidget);
    });

    testWidgets('rejects a cover letter shorter than 30 characters',
        (tester) async {
      await pumpScreen(tester);

      await tester.enterText(
        find.byType(TextFormField),
        'I want this job.',
      );

      await tester.tap(find.text('Submit Application'));
      await tester.pump();

      expect(
        find.text(
          'Your cover letter must contain at least 30 characters.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('requires a CV before submitting', (tester) async {
      await pumpScreen(tester);

      await tester.enterText(
        find.byType(TextFormField),
        'I am interested in this position and believe my skills are suitable.',
      );

      await tester.tap(find.text('Submit Application'));
      await tester.pump();

      expect(find.text('Please select your CV.'), findsOneWidget);
    });
  });
}
