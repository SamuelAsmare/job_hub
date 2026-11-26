import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/core/constants/app_constants.dart';
import 'package:job_hub/core/providers/app_providers.dart';
import 'package:job_hub/core/router/app_router.dart';
import 'package:job_hub/core/router/route_names.dart';

void main() {
  group('AppProviders', () {
    test('appSessionProvider manages signIn, switchRole, and signOut', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(appSessionProvider),
        const AppSessionState.sampleJobSeeker(),
      );
      expect(
        container.read(currentUserIdProvider),
        AppConstants.defaultSampleUserId,
      );
      expect(container.read(currentUserRoleProvider), UserRole.jobSeeker);

      container.read(appSessionProvider.notifier).switchRole(UserRole.employer);
      expect(container.read(currentUserRoleProvider), UserRole.employer);
      expect(container.read(appSessionProvider).isAuthenticated, isTrue);

      container.read(appSessionProvider.notifier).signOut();
      expect(container.read(currentUserRoleProvider), UserRole.guest);
      expect(container.read(currentUserIdProvider), isNull);
      expect(container.read(appSessionProvider).isAuthenticated, isFalse);

      container.read(appSessionProvider.notifier).signIn(
            userId: 'user_099',
            role: UserRole.jobSeeker,
          );
      expect(container.read(currentUserIdProvider), 'user_099');
      expect(container.read(currentUserRoleProvider), UserRole.jobSeeker);
    });

    test('appThemeModeProvider updates from ThemeMode and string values', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(appThemeModeProvider), ThemeMode.light);

      container
          .read(appThemeModeProvider.notifier)
          .setThemeModeFromString('dark');
      expect(container.read(appThemeModeProvider), ThemeMode.dark);

      container
          .read(appThemeModeProvider.notifier)
          .setThemeModeFromString('system');
      expect(container.read(appThemeModeProvider), ThemeMode.system);

      container
          .read(appThemeModeProvider.notifier)
          .setThemeMode(ThemeMode.light);
      expect(container.read(appThemeModeProvider), ThemeMode.light);
    });
  });

  group('RouteNames & AppRouter', () {
    test('typed path builders format dynamic segments correctly', () {
      expect(RouteNames.jobDetailsPath('job_42'), '/jobs/job_42');
      expect(RouteNames.applyJobPath('job_42'), '/jobs/job_42/apply');
      expect(
        RouteNames.vacancyDetailsPath('vac_7'),
        '/employer/vacancies/vac_7',
      );
      expect(
        RouteNames.applicantsPath('vac_7'),
        '/employer/vacancies/vac_7/applicants',
      );
    });

    testWidgets('redirects guest away from protected routes to welcome', (
      tester,
    ) async {
      final router = createAppRouter(
        readSession: () => const AppSessionState(),
        initialLocation: RouteNames.savedJobs,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Welcome (Pending Integration)'), findsOneWidget);
    });

    testWidgets('redirects jobSeeker away from employer routes',
        (tester) async {
      final router = createAppRouter(
        readSession: () => const AppSessionState.sampleJobSeeker(),
        initialLocation: RouteNames.employerDashboard,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Find your next opportunity'), findsOneWidget);
    });

    testWidgets('redirects employer away from job-seeker-only routes', (
      tester,
    ) async {
      final router = createAppRouter(
        readSession: () => const AppSessionState(
          userId: 'emp_001',
          role: UserRole.employer,
          isAuthenticated: true,
        ),
        initialLocation: RouteNames.savedJobs,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Employer Dashboard (Pending Integration)'),
        findsOneWidget,
      );
    });
  });
}
