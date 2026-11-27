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
import '../../features/messaging/presentation/screens/chat_screen.dart';
import '../../features/messaging/presentation/screens/start_conversation_screen.dart';
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
  readSession: () => const AppSessionState(),
);

/// Creates the application router.
GoRouter createAppRouter({
  required AppSessionState Function() readSession,
  Listenable? refreshListenable,
  String initialLocation = RouteNames.welcome,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final session = readSession();
      final location = state.matchedLocation;
      final isGuestBrowsableRoute = location == RouteNames.jobSearch ||
          RegExp(r'^/jobs/[^/]+$').hasMatch(location);

      const publicLocations = {
        RouteNames.welcome,
        RouteNames.auth,
      };

      if (!session.isAuthenticated &&
          RegExp(r'^/jobs/[^/]+/(apply|message)$').hasMatch(location)) {
        return Uri(
          path: RouteNames.auth,
          queryParameters: {'redirect': state.uri.toString()},
        ).toString();
      }

      // Guests can browse jobs but need an account to use member features.
      if (!session.isAuthenticated &&
          !publicLocations.contains(location) &&
          !isGuestBrowsableRoute) {
        return RouteNames.welcome;
      }

      if (session.isAuthenticated) {
        // Authenticated users landing on welcome/auth/home → send to their home
        if (location == RouteNames.welcome ||
            location == RouteNames.auth ||
            location == RouteNames.home) {
          return session.role == UserRole.employer
              ? RouteNames.employerDashboard
              : RouteNames.jobSeekerHome;
        }

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
      // Root redirect
      // --------------------------------------------------
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        redirect: (context, state) => RouteNames.welcome,
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
          onBrowseJobs: () => context.push(RouteNames.jobSearch),
        ),
      ),

      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.authName,
        builder: (context, state) {
          final isRegistration =
              state.uri.queryParameters['register'] == 'true';
          final redirectLocation = state.uri.queryParameters['redirect'];

          return Consumer(
            builder: (context, ref, child) {
              return AuthScreen(
                isRegistration: isRegistration,
                onBack: () {
                  context.go(RouteNames.welcome);
                },
                onSwitchMode: () {
                  if (isRegistration) {
                    context.go(
                      Uri(
                        path: RouteNames.auth,
                        queryParameters: {
                          if (redirectLocation != null)
                            'redirect': redirectLocation,
                        },
                      ).toString(),
                    );
                  } else {
                    context.go(
                      Uri(
                        path: RouteNames.auth,
                        queryParameters: {
                          'register': 'true',
                          if (redirectLocation != null)
                            'redirect': redirectLocation,
                        },
                      ).toString(),
                    );
                  }
                },
                onAuthenticated: (user) {
                  final role = user.role.name == 'employer'
                      ? UserRole.employer
                      : UserRole.jobSeeker;

                  ref.read(appSessionProvider.notifier).signIn(
                        userId: user.id,
                        role: role,
                      );

                  if (role == UserRole.employer) {
                    context.go(RouteNames.employerDashboard);
                  } else if (redirectLocation != null &&
                      redirectLocation.startsWith('/')) {
                    context.go(redirectLocation);
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
        path: RouteNames.startConversation,
        name: RouteNames.startConversationName,
        builder: (context, state) => StartConversationScreen(
          jobId: state.pathParameters['jobId']!,
        ),
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
        path: RouteNames.chat,
        name: RouteNames.chatName,
        builder: (context, state) {
          final conversationId = state.pathParameters['conversationId']!;
          return Consumer(
            builder: (context, ref, child) {
              final userId = ref.watch(currentUserIdProvider) ??
                  AppConstants.defaultSampleUserId;
              return ChatLoadingScreen(
                conversationId: conversationId,
                currentUserId: userId,
              );
            },
          );
        },
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
          onPressed: () => context.go(RouteNames.welcome),
        ),
      ),
    ),
  );
}

// ======================================================
