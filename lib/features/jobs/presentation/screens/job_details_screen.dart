import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/app_providers.dart' as core_providers;
import '../../../../core/router/route_names.dart';
import '../../../saved_jobs/domain/models/saved_job.dart';
import '../../../saved_jobs/presentation/providers/saved_job_provider.dart';
import '../providers/job_provider.dart';

class JobDetailsScreen extends ConsumerWidget {
  const JobDetailsScreen({
    required this.jobId,
    super.key,
  });

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobByIdProvider(jobId));
    final savedJobsAsync = ref.watch(savedJobsProvider);
    final isSaved = savedJobsAsync.maybeWhen(
      data: (items) => items.any((item) => item.jobId == jobId),
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            tooltip: isSaved ? 'Remove from saved' : 'Save job',
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
            ),
            onPressed: () async {
              final notifier = ref.read(savedJobsProvider.notifier);
              if (isSaved) {
                await notifier.removeSavedJob(jobId);
              } else {
                final userId = ref.read(core_providers.currentUserIdProvider) ??
                    AppConstants.defaultSampleUserId;
                await notifier.saveJob(
                  SavedJob(
                    id: 'saved_${DateTime.now().millisecondsSinceEpoch}',
                    userId: userId,
                    jobId: jobId,
                    savedAt: DateTime.now(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: jobAsync.maybeWhen(
        data: (job) => job == null
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => context.push(
                          RouteNames.startConversationPath(job.id),
                        ),
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: const Text('Message'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () =>
                              context.push(RouteNames.applyJobPath(job.id)),
                          icon: const Icon(Icons.send_outlined),
                          label: const Text('Apply Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        orElse: () => null,
      ),
      body: jobAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Could not load job details: $error'),
        ),
        data: (job) {
          if (job == null) {
            return const Center(
              child: Text('Job not found.'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 36,
                    child: Text(
                      job.companyName.isNotEmpty
                          ? job.companyName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    job.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    job.companyName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow(
                  context,
                  Icons.location_on_outlined,
                  'Location',
                  job.location,
                ),
                _buildInfoRow(
                  context,
                  Icons.work_outline,
                  'Employment Type',
                  job.employmentType,
                ),
                if (job.salary != null)
                  _buildInfoRow(
                    context,
                    Icons.payments_outlined,
                    'Salary',
                    job.salary!,
                  ),
                _buildInfoRow(
                  context,
                  Icons.calendar_today_outlined,
                  'Posted',
                  _formatDate(job.postedAt),
                ),
                if (job.deadline != null)
                  _buildInfoRow(
                    context,
                    Icons.event_outlined,
                    'Application Deadline',
                    _formatDate(job.deadline!),
                  ),
                const SizedBox(height: 24),
                Text(
                  'Job Description',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  job.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'Requirements',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ...job.requirements.map(
                  (requirement) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 20),
                        const SizedBox(width: 10),
                        Expanded(child: Text(requirement)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
