import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/router/route_names.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';

class JobSeekerHomeScreen extends ConsumerWidget {
  const JobSeekerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JobHub'),
        actions: [
          IconButton(
            onPressed: () => context.push(RouteNames.nearbyJobsMap),
            icon: const Icon(Icons.map_outlined),
            tooltip: 'Nearby jobs map',
          ),
          IconButton(
            onPressed: () => context.push(RouteNames.jobSearch),
            icon: const Icon(Icons.search),
            tooltip: 'Search jobs',
          ),
          IconButton(
            onPressed: () => context.push(RouteNames.jobSeekerProfile),
            icon: const Icon(Icons.person_outline),
            tooltip: 'Profile',
          ),
        ],
      ),
      drawer: const _JobSeekerDrawer(),
      bottomNavigationBar: _JobSeekerBottomNav(),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(jobsProvider.future),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find your next opportunity',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore jobs that match your skills and interests.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    onTap: () => context.push('/jobs/search'),
                    decoration: InputDecoration(
                      hintText: 'Search jobs, companies, or locations',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.arrow_forward),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Jobs',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/jobs/search'),
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            jobsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text('Could not load jobs: $error'),
                ),
              ),
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: Text('No jobs available yet.')),
                  );
                }

                return Column(
                  children: jobs
                      .map(
                        (job) => JobCard(
                          job: job,
                          onTap: () => context.push('/jobs/${job.id}'),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// Persistent bottom navigation for the job-seeker flow.
class _JobSeekerBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(RouteNames.jobSeekerHome);
          case 1:
            context.push(RouteNames.savedJobs);
          case 2:
            context.push(RouteNames.myApplications);
          case 3:
            context.push(RouteNames.messages);
          case 4:
            context.push(RouteNames.notifications);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment_outlined),
          selectedIcon: Icon(Icons.assignment),
          label: 'Applications',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          selectedIcon: Icon(Icons.chat_bubble),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
      ],
    );
  }
}

/// Navigation drawer providing access to profile, CV, map, settings, and sign out.
class _JobSeekerDrawer extends ConsumerWidget {
  const _JobSeekerDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'JobHub',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.jobSeekerProfile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('My CV'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.myCv);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('Nearby Jobs Map'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.nearbyJobsMap);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.settings);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              Navigator.of(context).pop();
              ref.read(appSessionProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
