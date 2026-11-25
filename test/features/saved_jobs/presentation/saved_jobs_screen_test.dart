import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/saved_jobs/data/repositories/saved_job_repository_impl.dart';
import 'package:job_hub/features/saved_jobs/domain/models/saved_job.dart';
import 'package:job_hub/features/saved_jobs/presentation/providers/saved_job_provider.dart';
import 'package:job_hub/features/saved_jobs/presentation/screens/saved_jobs_screen.dart';
import 'package:job_hub/features/saved_jobs/presentation/widgets/saved_job_card.dart';

void main() {
  Widget buildTestableWidget({
    List<SavedJob>? initialJobs,
    SavedJobRepositoryImpl? repository,
  }) {
    final repo = repository ??
        SavedJobRepositoryImpl(initialSavedJobs: initialJobs ?? []);

    return ProviderScope(
      overrides: [
        savedJobRepositoryProvider.overrideWithValue(repo),
        currentUserIdProvider.overrideWithValue('user_001'),
      ],
      child: const MaterialApp(
        home: SavedJobsScreen(),
      ),
    );
  }

  group('SavedJobsScreen', () {
    testWidgets(
        'The screen displays the empty state when there are no saved jobs',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget(initialJobs: []));
      await tester.pumpAndSettle();

      expect(find.text('No Saved Jobs Yet'), findsOneWidget);
      expect(find.byType(SavedJobCard), findsNothing);
    });

    testWidgets('The screen displays saved jobs', (tester) async {
      final sampleList = [
        SavedJob(
          id: 'saved_001',
          userId: 'user_001',
          jobId: 'job_001',
          savedAt: DateTime(2026, 11, 20),
        ),
        SavedJob(
          id: 'saved_002',
          userId: 'user_001',
          jobId: 'job_002',
          savedAt: DateTime(2026, 11, 22),
        ),
      ];

      await tester.pumpWidget(buildTestableWidget(initialJobs: sampleList));
      await tester.pumpAndSettle();

      expect(find.byType(SavedJobCard), findsNWidgets(2));
      expect(find.text('Job Reference #job_001'), findsOneWidget);
      expect(find.text('Job Reference #job_002'), findsOneWidget);
    });

    testWidgets('Removing a saved job updates the UI', (tester) async {
      final sampleList = [
        SavedJob(
          id: 'saved_001',
          userId: 'user_001',
          jobId: 'job_001',
          savedAt: DateTime(2026, 11, 20),
        ),
      ];

      await tester.pumpWidget(buildTestableWidget(initialJobs: sampleList));
      await tester.pumpAndSettle();

      expect(find.byType(SavedJobCard), findsOneWidget);
      expect(find.text('Job Reference #job_001'), findsOneWidget);

      await tester.tap(find.byTooltip('Remove from saved jobs'));
      await tester.pumpAndSettle();

      expect(find.byType(SavedJobCard), findsNothing);
      expect(find.text('No Saved Jobs Yet'), findsOneWidget);
      expect(find.text('Job removed from saved list'), findsOneWidget);
    });

    testWidgets('Loading state renders CircularProgressIndicator initially',
        (tester) async {
      final notifier = CompleterNotifier();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            savedJobsProvider.overrideWith(() => notifier),
          ],
          child: const MaterialApp(
            home: SavedJobsScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      notifier.completer.complete([]);
      await tester.pumpAndSettle();
    });

    testWidgets('Error state renders error UI and retry button',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            savedJobsProvider.overrideWith(ErrorNotifier.new),
          ],
          child: const MaterialApp(
            home: SavedJobsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Unable to load saved jobs'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });
  });
}

class CompleterNotifier extends SavedJobsNotifier {
  final completer = Completer<List<SavedJob>>();

  @override
  Future<List<SavedJob>> build() => completer.future;
}

class ErrorNotifier extends SavedJobsNotifier {
  @override
  Future<List<SavedJob>> build() {
    throw Exception('Failed to fetch saved jobs');
  }
}
