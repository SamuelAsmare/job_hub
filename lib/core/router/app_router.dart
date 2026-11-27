import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/applications/presentation/screens/apply_job_screen.dart';
import '../../features/applications/presentation/screens/my_applications_screen.dart';
import '../../features/authentication/presentation/screens/auth_screen.dart';
import '../../features/authentication/presentation/screens/welcome_screen.dart';
import '../../features/jobs/presentation/providers/job_provider.dart';
import '../../features/jobs/presentation/screens/job_details_screen.dart';
import '../../features/jobs/presentation/screens/job_search_screen.dart';
import '../../features/jobs/presentation/screens/job_seeker_home_screen.dart';
import '../../features/jobs/presentation/screens/nearby_jobs_map_screen.dart';
import '../../features/messaging/presentation/screens/messages_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/job_seeker_profile_screen.dart';
import '../../features/profile/presentation/screens/my_cv_screen.dart';
import '../../features/saved_jobs/presentation/screens/saved_jobs_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

import '../../features/employer/presentation/screens/applicants_screen.dart';
import '../../features/employer/presentation/screens/employer_dashboard_screen.dart';
import '../../features/employer/presentation/screens/post_vacancy_screen.dart';
import '../../features/employer/presentation/screens/vacancy_details_screen.dart';

import '../constants/app_constants.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/empty_state_widget.dart';
import 'route_names.dart';

/// Refreshes GoRouter when the application session changes.
class _RouterRefreshNotifier extends ChangeNotifier {
  void triggerRefresh() => notifyListeners();
}

/// Global GoRouter provider.
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

/// Standalone router instance.
final GoRouter appRouter = createAppRouter(
  readSession: () => const AppSessionState.sampleJobSeeker(),
);

/// Creates the application router.
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
            location == RouteNames.nearbyJobsMap ||
            location.endsWith('/apply');

        if (isJobSeekerOnlyRoute && session.role != UserRole.jobSeeker) {
          return RouteNames.employerDashboard;
        }
      }

      return null;
    },
    routes: [
      // --------------------------------------------------
      // Integration Hub
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        builder: (context, state) => const _IntegrationHubScreen(),
      ),

      // --------------------------------------------------
      // Authentication
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.welcome,
        name: RouteNames.welcomeName,
        builder: (context, state) => WelcomeScreen(
          onLogin: () {
            context.push(RouteNames.auth);
          },
          onRegister: () {
            context.push('${RouteNames.auth}?register=true');
          },
        ),
      ),

      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.authName,
        builder: (context, state) {
          final isRegistration =
              state.uri.queryParameters['register'] == 'true';

          return Consumer(
            builder: (context, ref, child) {
              return AuthScreen(
                isRegistration: isRegistration,
                onBack: () {
                  context.go(RouteNames.welcome);
                },
                onSwitchMode: () {
                  if (isRegistration) {
                    context.go(RouteNames.auth);
                  } else {
                    context.go('${RouteNames.auth}?register=true');
                  }
                },
                onAuthenticated: (user) {
                  final role = user.role.name == 'employer'
                      ? UserRole.employer
                      : UserRole.jobSeeker;

                  ref.read(appSessionProvider.notifier).switchRole(role);

                  if (role == UserRole.employer) {
                    context.go(RouteNames.employerDashboard);
                  } else {
                    context.go(RouteNames.jobSeekerHome);
                  }
                },
              );
            },
          );
        },
      ),

      // --------------------------------------------------
      // Job Seeker
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.jobSeekerHome,
        name: RouteNames.jobSeekerHomeName,
        builder: (context, state) => const JobSeekerHomeScreen(),
      ),

      GoRoute(
        path: RouteNames.jobSearch,
        name: RouteNames.jobSearchName,
        builder: (context, state) => const JobSearchScreen(),
      ),

      GoRoute(
        path: RouteNames.nearbyJobsMap,
        name: RouteNames.nearbyJobsMapName,
        builder: (context, state) => const NearbyJobsMapScreen(),
      ),

      GoRoute(
        path: RouteNames.jobDetails,
        name: RouteNames.jobDetailsName,
        builder: (context, state) {
          final jobId = state.pathParameters['jobId']!;

          return JobDetailsScreen(jobId: jobId);
        },
      ),

      GoRoute(
        path: RouteNames.applyJob,
        name: RouteNames.applyJobName,
        builder: (context, state) {
          final jobId = state.pathParameters['jobId']!;

          return Consumer(
            builder: (context, ref, child) {
              final jobAsync = ref.watch(jobByIdProvider(jobId));

              final applicantId = ref.watch(currentUserIdProvider) ??
                  AppConstants.defaultSampleUserId;

              return jobAsync.when(
                loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Apply for Job'),
                  ),
                  body: Center(
                    child: Text('Could not load job: $error'),
                  ),
                ),
                data: (job) {
                  if (job == null) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Job not found.'),
                      ),
                    );
                  }

                  return ApplyJobScreen(
                    job: job,
                    applicantId: applicantId,
                  );
                },
              );
            },
          );
        },
      ),

      GoRoute(
        path: RouteNames.myApplications,
        name: RouteNames.myApplicationsName,
        builder: (context, state) => Consumer(
          builder: (context, ref, child) {
            final applicantId = ref.watch(currentUserIdProvider) ??
                AppConstants.defaultSampleUserId;

            return MyApplicationsScreen(
              applicantId: applicantId,
            );
          },
        ),
      ),

      GoRoute(
        path: RouteNames.savedJobs,
        name: RouteNames.savedJobsName,
        builder: (context, state) => const SavedJobsScreen(),
      ),

      // --------------------------------------------------
      // Profile
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.jobSeekerProfile,
        name: RouteNames.jobSeekerProfileName,
        builder: (context, state) => const JobSeekerProfileScreen(),
      ),

      GoRoute(
        path: RouteNames.myCv,
        name: RouteNames.myCvName,
        builder: (context, state) => const MyCvScreen(),
      ),

      GoRoute(
        path: RouteNames.employerDashboard,
        name: RouteNames.employerDashboardName,
        builder: (context, state) => const EmployerDashboardScreen(),
      ),

      GoRoute(
        path: RouteNames.postVacancy,
        name: RouteNames.postVacancyName,
        builder: (context, state) => PostVacancyScreen(
          vacancyId: state.uri.queryParameters['vacancyId'],
        ),
      ),

      GoRoute(
        path: RouteNames.vacancyDetails,
        name: RouteNames.vacancyDetailsName,
        builder: (context, state) => VacancyDetailsScreen(
          vacancyId: state.pathParameters['vacancyId']!,
        ),
      ),

      GoRoute(
        path: RouteNames.applicants,
        name: RouteNames.applicantsName,
        builder: (context, state) => ApplicantsScreen(
          vacancyId: state.pathParameters['vacancyId']!,
        ),
      ),
      // --------------------------------------------------
      // Shared routes
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.messages,
        name: RouteNames.messagesName,
        builder: (context, state) => Consumer(
          builder: (context, ref, child) {
            final userId = ref.watch(currentUserIdProvider) ??
                AppConstants.defaultSampleUserId;

            return MessagesScreen(userId: userId);
          },
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
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
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

// ======================================================
// Integration Hub
// ======================================================

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
            padding: const EdgeInsets.all(
              AppConstants.pageHorizontalPadding,
            ),
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

              // Session and theme controls
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
                          const Text(
                            'Dark Theme',
                            style: AppTextStyles.body,
                          ),
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
                icon: Icons.work_outline,
                title: 'Job Seeker Home',
                subtitle: RouteNames.jobSeekerHome,
                isReady: true,
                onTap: () => context.push(RouteNames.jobSeekerHome),
              ),
              _RouteTile(
                icon: Icons.search,
                title: 'Job Search',
                subtitle: RouteNames.jobSearch,
                isReady: true,
                onTap: () => context.push(RouteNames.jobSearch),
              ),
              _RouteTile(
                icon: Icons.map_outlined,
                title: 'Nearby Jobs Map',
                subtitle: RouteNames.nearbyJobsMap,
                isReady: true,
                onTap: () => context.push(RouteNames.nearbyJobsMap),
              ),
              _RouteTile(
                icon: Icons.assignment_outlined,
                title: 'My Applications',
                subtitle: RouteNames.myApplications,
                isReady: true,
                onTap: () => context.push(RouteNames.myApplications),
              ),
              _RouteTile(
                icon: Icons.bookmark_outline,
                title: 'Saved Jobs',
                subtitle: RouteNames.savedJobs,
                isReady: true,
                onTap: () => context.push(RouteNames.savedJobs),
              ),
              _RouteTile(
                icon: Icons.chat_bubble_outline,
                title: 'Messages',
                subtitle: RouteNames.messages,
                isReady: true,
                onTap: () => context.push(RouteNames.messages),
              ),
              _RouteTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: RouteNames.notifications,
                isReady: true,
                onTap: () => context.push(RouteNames.notifications),
              ),
              _RouteTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: RouteNames.settings,
                isReady: true,
                onTap: () => context.push(RouteNames.settings),
              ),

              const SizedBox(height: AppConstants.sectionSpacing),

              const Text(
                'Available & Pending Feature Routes',
                style: AppTextStyles.sectionHeading,
              ),
              const SizedBox(height: 10),

              _RouteTile(
                icon: Icons.waving_hand_outlined,
                title: 'Welcome',
                subtitle: RouteNames.welcome,
                isReady: true,
                onTap: () => context.push(RouteNames.welcome),
              ),
              _RouteTile(
                icon: Icons.login_outlined,
                title: 'Login / Registration',
                subtitle: RouteNames.auth,
                isReady: true,
                onTap: () => context.push(RouteNames.auth),
              ),
              _RouteTile(
                icon: Icons.person_outline,
                title: 'Job Seeker Profile',
                subtitle: RouteNames.jobSeekerProfile,
                isReady: true,
                onTap: () => context.push(RouteNames.jobSeekerProfile),
              ),
              _RouteTile(
                icon: Icons.description_outlined,
                title: 'My CV',
                subtitle: RouteNames.myCv,
                isReady: true,
                onTap: () => context.push(RouteNames.myCv),
              ),
              _RouteTile(
                icon: Icons.business_center_outlined,
                title: 'Employer Dashboard',
                subtitle: RouteNames.employerDashboard,
                isReady: false,
                onTap: () => context.push(RouteNames.employerDashboard),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// Reusable Integration Hub Tile
// ======================================================

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
        title: Text(
          title,
          style: AppTextStyles.sectionHeading,
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodyMuted,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
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

// ======================================================
// Pending Feature Placeholder
// ======================================================

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
      appBar: AppBar(
        title: Text(title),
      ),
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
