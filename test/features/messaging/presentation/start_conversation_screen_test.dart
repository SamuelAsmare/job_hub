import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/core/providers/app_providers.dart' as app_providers;
import 'package:job_hub/core/router/app_router.dart';
import 'package:job_hub/core/router/route_names.dart';
import 'package:job_hub/features/authentication/domain/models/user.dart';
import 'package:job_hub/features/authentication/presentation/providers/auth_provider.dart';
import 'package:job_hub/features/jobs/domain/models/job.dart';
import 'package:job_hub/features/jobs/presentation/providers/job_provider.dart';
import 'package:job_hub/features/messaging/data/datasources/message_local_datasource.dart';
import 'package:job_hub/features/messaging/presentation/providers/message_provider.dart';

void main() {
  testWidgets('starts a job conversation and sends the first message',
      (tester) async {
    final job = Job(
      id: 'job_001',
      title: 'Flutter Developer',
      companyName: 'TechCorp',
      location: 'Remote',
      description: 'Build Flutter apps.',
      requirements: const ['Flutter'],
      employmentType: 'Full-time',
      postedAt: DateTime(2026, 11, 27),
      employerId: 'employer_001',
    );
    final dataSource = MessageLocalDataSource();
    final router = createAppRouter(
      readSession: () => const app_providers.AppSessionState(
        userId: 'seeker_001',
        role: app_providers.UserRole.jobSeeker,
        isAuthenticated: true,
      ),
      initialLocation: RouteNames.jobDetailsPath(job.id),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          app_providers.currentUserIdProvider.overrideWithValue('seeker_001'),
          currentUserProvider.overrideWithValue(
            const User(
              id: 'seeker_001',
              fullName: 'Job Seeker',
              email: 'seeker@example.com',
              role: UserRole.jobSeeker,
            ),
          ),
          jobByIdProvider(job.id).overrideWith((ref) async => job),
          messageLocalDataSourceProvider.overrideWithValue(dataSource),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Job Details'), findsOneWidget);
    await tester.tap(find.text('Message'));
    await tester.pumpAndSettle();

    expect(find.text('TechCorp'), findsOneWidget);
    expect(find.text('Start your conversation.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Hello about the job.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.text('Hello about the job.'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Job Details'), findsOneWidget);
  });
}
