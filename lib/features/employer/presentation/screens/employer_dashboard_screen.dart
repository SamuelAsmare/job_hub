import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/router/route_names.dart';
import '../providers/employer_provider.dart';

class EmployerDashboardScreen extends ConsumerWidget {
  const EmployerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employerId = ref.watch(employerIdProvider);
    final vacancies = ref.watch(employerVacanciesProvider(employerId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () =>
                ref.invalidate(employerVacanciesProvider(employerId)),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: _EmployerDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RouteNames.postVacancy),
        icon: const Icon(Icons.add),
        label: const Text('Post Vacancy'),
      ),
      body: vacancies.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Could not load vacancies: $error'),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(employerVacanciesProvider(employerId));
            await ref.read(employerVacanciesProvider(employerId).future);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Recruitment Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Total Vacancies',
                            value: '${items.length}',
                          ),
                          _StatItem(
                            label: 'Active Vacancies',
                            value: '${items.length}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Your Vacancies (${items.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              if (items.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(28),
                    child: Column(
                      children: [
                        Icon(Icons.work_outline, size: 48),
                        SizedBox(height: 12),
                        Text(
                          'No vacancies yet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Post your first vacancy to start receiving applications.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...items.map(
                  (job) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.work_outline),
                      ),
                      title: Text(job.title),
                      subtitle: Text(
                        '${job.companyName} • ${job.location}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(
                        RouteNames.vacancyDetailsPath(job.id),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}

/// Navigation drawer for the employer section.
class _EmployerDrawer extends ConsumerWidget {
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
              'JobHub Employer',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pop();
              context.go(RouteNames.employerDashboard);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Post Vacancy'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.postVacancy);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Messages'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.messages);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(RouteNames.notifications);
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
