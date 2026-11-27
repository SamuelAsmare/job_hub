import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';

class JobSearchScreen extends ConsumerStatefulWidget {
  const JobSearchScreen({super.key});

  @override
  ConsumerState<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends ConsumerState<JobSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(jobSearchQueryProvider);
    final jobsAsync = ref.watch(jobSearchProvider(query));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Jobs'),
        actions: [
          IconButton(
            onPressed: () => context.push(RouteNames.nearbyJobsMap),
            icon: const Icon(Icons.map_outlined),
            tooltip: 'Nearby jobs map',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) =>
                  ref.read(jobSearchQueryProvider.notifier).setQuery(value),
              decoration: InputDecoration(
                hintText: 'Search title, company, or location',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          ref.read(jobSearchQueryProvider.notifier).clear();
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Clear search',
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: jobsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Could not search jobs: $error'),
                ),
              ),
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const Center(
                    child: Text('No jobs found. Try another search.'),
                  );
                }

                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];

                    return JobCard(
                      job: job,
                      onTap: () => context.push('/jobs/${job.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
