import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: () => context.push('/jobs/search'),
            icon: const Icon(Icons.search),
            tooltip: 'Search jobs',
          ),
        ],
      ),
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
