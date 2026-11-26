import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/jobs/data/sample_data/sample_jobs.dart';
import 'package:job_hub/features/jobs/presentation/widgets/job_card.dart';

void main() {
  group('JobCard widget', () {
    testWidgets('should display job information', (tester) async {
      final job = sampleJobs.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: JobCard(
              job: job,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text(job.title), findsOneWidget);
      expect(find.text(job.companyName), findsOneWidget);
      expect(find.text(job.location), findsOneWidget);
      expect(find.text(job.employmentType), findsOneWidget);
      expect(find.text(job.salary!), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: JobCard(
              job: sampleJobs.first,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(JobCard));

      expect(tapped, isTrue);
    });

    testWidgets('should display company initial', (tester) async {
      final job = sampleJobs.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: JobCard(
              job: job,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(
        find.text(job.companyName[0].toUpperCase()),
        findsOneWidget,
      );
    });
  });
}
