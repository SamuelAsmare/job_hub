import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/saved_jobs/presentation/screens/saved_jobs_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../constants/app_constants.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/empty_state_widget.dart';
import 'route_names.dart';

/// Listens to Riverpod session changes so [GoRouter] re-evaluates redirects
/// without recreating the router instance.
class _RouterRefreshNotifier extends ChangeNotifier {
  void triggerRefresh() => notifyListeners();
}

/// Global [GoRouter] provider wired into [MaterialApp.router].
final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier();
  ref.listen<AppSessionState>(appSessionProvider, (previous, next) {
    refreshNotifier.triggerRefresh();
  });
  ref.onDispose(refreshNotifier.dispose);

  return createAppRouter(
    readSession: () => ref.read(appSessionProvider),
    refreshListenable: refreshNotifier,
  );
});

/// Default standalone router instance for simple references or quick previews.
final GoRouter appRouter = createAppRouter(
  readSession: () => const AppSessionState.sampleJobSeeker(),
);

/// Builds the application [GoRouter] with role-based redirects and all routes.
GoRouter createAppRouter({
  required AppSessionState Function() readSession,
  Listenable? refreshListenable,
  String initialLocation = RouteNames.home,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final session = readSession();
      final location = state.matchedLocation;

      const publicLocations = {
        RouteNames.home,
        RouteNames.welcome,
        RouteNames.auth,
      };

      if (!session.isAuthenticated && !publicLocations.contains(location)) {
        return RouteNames.welcome;
      }

      if (session.isAuthenticated) {
        final isEmployerRoute = location == RouteNames.employerDashboard ||
            location.startsWith('${RouteNames.employerDashboard}/');
        if (isEmployerRoute && session.role != UserRole.employer) {
          return RouteNames.jobSeekerHome;
        }

        final isJobSeekerOnlyRoute = location == RouteNames.jobSeekerHome ||
            location == RouteNames.myApplications ||
            location == RouteNames.savedJobs ||
            location == RouteNames.jobSeekerProfile ||
            location == RouteNames.myCv ||
            location.endsWith('/apply');
        if (isJobSeekerOnlyRoute && session.role != UserRole.jobSeeker) {
          return RouteNames.employerDashboard;
        }
      }

      return null;
    },
    routes: [
      // Integration Hub / Entry
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        builder: (context, state) => const _IntegrationHubScreen(),
      ),

      // Authentication routes (replace with WelcomeScreen & AuthScreen once ready)
      GoRoute(
        path: RouteNames.welcome,
        name: RouteNames.welcomeName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Welcome',
          featurePath: 'lib/features/authentication/presentation/screens/welcome_screen.dart',
          routePath: RouteNames.welcome,
          description:
              'Introduces JobHub and provides navigation to login and registration.',
        ),
      ),
      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.authName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Login & Registration',
          featurePath: 'lib/features/authentication/presentation/screens/auth_screen.dart',
          routePath: RouteNames.auth,
          description:
              'Authenticates job seekers and employers and sets their role.',
        ),
      ),

      // Job Seeker routes
      GoRoute(
        path: RouteNames.jobSeekerHome,
        name: RouteNames.jobSeekerHomeName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Job Seeker Home',
          featurePath: 'lib/features/jobs/presentation/screens/job_seeker_home_screen.dart',
          routePath: RouteNames.jobSeekerHome,
          description: 'Displays recent and recommended job vacancies.',
        ),
      ),
      GoRoute(
        path: RouteNames.jobSearch,
        name: RouteNames.jobSearchName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Job Search',
          featurePath: 'lib/features/jobs/presentation/screens/job_search_screen.dart',
          routePath: RouteNames.jobSearch,
          description: 'Searches and filters available and nearby jobs.',
        ),
      ),
      GoRoute(
        path: RouteNames.jobDetails,
        name: RouteNames.jobDetailsName,
        builder: (context, state) {
          final jobId = state.pathParameters['jobId'] ?? 'unknown';
          return _PendingFeatureScreen(
            title: 'Job Details ($jobId)',
            featurePath: 'lib/features/jobs/presentation/screens/job_details_screen.dart',
            routePath: RouteNames.jobDetailsPath(jobId),
            description:
                'Displays full job description, requirements, and AI summary.',
          );
        },
      ),
      GoRoute(
        path: RouteNames.applyJob,
        name: RouteNames.applyJobName,
        builder: (context, state) {
          final jobId = state.pathParameters['jobId'] ?? 'unknown';
          return _PendingFeatureScreen(
            title: 'Apply for Job ($jobId)',
            featurePath: 'lib/features/applications/presentation/screens/apply_job_screen.dart',
            routePath: RouteNames.applyJobPath(jobId),
            description:
                'Attaches saved CV and collects a cover letter before submission.',
          );
        },
      ),
      GoRoute(
        path: RouteNames.myApplications,
        name: RouteNames.myApplicationsName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'My Applications',
          featurePath: 'lib/features/applications/presentation/screens/my_applications_screen.dart',
          routePath: RouteNames.myApplications,
          description: 'Displays submitted job applications and their statuses.',
        ),
      ),
      GoRoute(
        path: RouteNames.savedJobs,
        name: RouteNames.savedJobsName,
        builder: (context, state) => const SavedJobsScreen(),
      ),
      GoRoute(
        path: RouteNames.jobSeekerProfile,
        name: RouteNames.jobSeekerProfileName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Job Seeker Profile',
          featurePath: 'lib/features/profile/presentation/screens/job_seeker_profile_screen.dart',
          routePath: RouteNames.jobSeekerProfile,
          description: 'Manages personal details, skills, education, and experience.',
        ),
      ),
      GoRoute(
        path: RouteNames.myCv,
        name: RouteNames.myCvName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'My CV',
          featurePath: 'lib/features/profile/presentation/screens/my_cv_screen.dart',
          routePath: RouteNames.myCv,
          description: 'Uploads, previews, and replaces the saved CV document.',
        ),
      ),

      // Employer routes
      GoRoute(
        path: RouteNames.employerDashboard,
        name: RouteNames.employerDashboardName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Employer Dashboard',
          featurePath: 'lib/features/employer/presentation/screens/employer_dashboard_screen.dart',
          routePath: RouteNames.employerDashboard,
          description: 'Displays recruitment statistics and employer vacancies.',
        ),
      ),
      GoRoute(
        path: RouteNames.postVacancy,
        name: RouteNames.postVacancyName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Post / Edit Vacancy',
          featurePath: 'lib/features/employer/presentation/screens/post_vacancy_screen.dart',
          routePath: RouteNames.postVacancy,
          description: 'Creates new job vacancies or edits existing ones.',
        ),
      ),
      GoRoute(
        path: RouteNames.vacancyDetails,
        name: RouteNames.vacancyDetailsName,
        builder: (context, state) {
          final vacancyId = state.pathParameters['vacancyId'] ?? 'unknown';
          return _PendingFeatureScreen(
            title: 'Vacancy Details ($vacancyId)',
            featurePath: 'lib/features/employer/presentation/screens/vacancy_details_screen.dart',
            routePath: RouteNames.vacancyDetailsPath(vacancyId),
            description: 'Views, edits, or deletes a published vacancy.',
          );
        },
      ),
      GoRoute(
        path: RouteNames.applicants,
        name: RouteNames.applicantsName,
        builder: (context, state) {
          final vacancyId = state.pathParameters['vacancyId'] ?? 'unknown';
          return _PendingFeatureScreen(
            title: 'Applicants ($vacancyId)',
            featurePath: 'lib/features/employer/presentation/screens/applicants_screen.dart',
            routePath: RouteNames.applicantsPath(vacancyId),
            description: 'Reviews applicants and updates application statuses.',
          );
        },
      ),

      // Shared routes
      GoRoute(
        path: RouteNames.messages,
        name: RouteNames.messagesName,
        builder: (context, state) => const _PendingFeatureScreen(
          title: 'Messages',
          featurePath: 'lib/features/messaging/presentation/screens/messages_screen.dart',
          routePath: RouteNames.messages,
          description: 'Real-time conversations between job seekers and employers.',
        ),
      ),
      GoRoute(
        path: RouteNames.notifications,
        name: RouteNames.notificationsName,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settingsName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: EmptyStateWidget(
        icon: Icons.explore_off_outlined,
        title: 'Route Not Found',
        message: 'No screen is registered for "${state.uri}".',
        action: AppButton(
          text: 'Go to Home',
          icon: Icons.home_outlined,
          onPressed: () => context.go(RouteNames.home),
        ),
      ),
    ),
  );
}

/// Temporary Milestone 1 integration hub rendered at [RouteNames.home] until
/// authentication and home screens are merged.
class _IntegrationHubScreen extends ConsumerWidget {
  const _IntegrationHubScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(appSessionProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.screenBackgroundGradient,
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppConstants.pageHorizontalPadding),
            children: [
              Text(
                'CORE & INTEGRATION',
                style: AppTextStyles.eyebrow,
              ),
              const SizedBox(height: 6),
              const Text(
                AppConstants.appName,
                style: AppTextStyles.pageHeading,
              ),
              const SizedBox(height: 4),
              const Text(
                AppConstants.appTagline,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppConstants.sectionSpacing),

              // Active Session & Theme Controls
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Session & Theme Controls',
                        style: AppTextStyles.sectionHeading,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Active Role: ${session.role.name} • User: ${session.userId ?? 'none'}',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: UserRole.values.map((role) {
                          final isSelected = session.role == role;
                          return ChoiceChip(
                            label: Text(role.name),
                            selected: isSelected,
                            onSelected: (_) => ref
                                .read(appSessionProvider.notifier)
                                .switchRole(role),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark Theme', style: AppTextStyles.body),
                          Switch(
                            value: themeMode == ThemeMode.dark,
                            onChanged: (isDark) => ref
                                .read(appThemeModeProvider.notifier)
                                .setThemeMode(
                                  isDark ? ThemeMode.dark : ThemeMode.light,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.sectionSpacing),

              const Text(
                'Integrated Feature Screens',
                style: AppTextStyles.sectionHeading,
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: RouteNames.notifications,
                isReady: true,
                onTap: () => context.push(RouteNames.notifications),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.bookmark_outline,
                title: 'Saved Jobs',
                subtitle: RouteNames.savedJobs,
                isReady: true,
                onTap: () => context.push(RouteNames.savedJobs),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: RouteNames.settings,
                isReady: true,
                onTap: () => context.push(RouteNames.settings),
              ),
              const SizedBox(height: AppConstants.sectionSpacing),

              const Text(
                'Pending Feature Routes (Stubbed)',
                style: AppTextStyles.sectionHeading,
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.waving_hand_outlined,
                title: 'Welcome',
                subtitle: RouteNames.welcome,
                isReady: false,
                onTap: () => context.push(RouteNames.welcome),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.login_outlined,
                title: 'Login / Registration',
                subtitle: RouteNames.auth,
                isReady: false,
                onTap: () => context.push(RouteNames.auth),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.work_outline,
                title: 'Job Seeker Home',
                subtitle: RouteNames.jobSeekerHome,
                isReady: false,
                onTap: () => context.push(RouteNames.jobSeekerHome),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.search,
                title: 'Job Search',
                subtitle: RouteNames.jobSearch,
                isReady: false,
                onTap: () => context.push(RouteNames.jobSearch),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.business_center_outlined,
                title: 'Employer Dashboard',
                subtitle: RouteNames.employerDashboard,
                isReady: false,
                onTap: () => context.push(RouteNames.employerDashboard),
              ),
              const SizedBox(height: 10),
              _RouteTile(
                icon: Icons.chat_bubble_outline,
                title: 'Messages',
                subtitle: RouteNames.messages,
                isReady: false,
                onTap: () => context.push(RouteNames.messages),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isReady;
  final VoidCallback onTap;

  const _RouteTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isReady,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: isReady ? AppColors.primaryBlue : AppColors.textMuted,
        ),
        title: Text(title, style: AppTextStyles.sectionHeading),
        subtitle: Text(subtitle, style: AppTextStyles.bodyMuted),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isReady
                    ? AppColors.success.withValues(alpha: 0.12)
                    : AppColors.paleBlueBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isReady ? 'Ready' : 'Pending',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isReady ? AppColors.success : AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Placeholder displayed for routes whose feature screens are not yet merged.
class _PendingFeatureScreen extends StatelessWidget {
  final String title;
  final String featurePath;
  final String routePath;
  final String description;

  const _PendingFeatureScreen({
    required this.title,
    required this.featurePath,
    required this.routePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyStateWidget(
        icon: Icons.construction_rounded,
        title: '$title (Pending Integration)',
        message: '$description\n\nRoute: $routePath\nTarget file: $featurePath',
        action: AppButton(
          text: 'Back to Hub',
          icon: Icons.arrow_back_rounded,
          onPressed: () => context.go(RouteNames.home),
        ),
      ),
    );
  }
}
