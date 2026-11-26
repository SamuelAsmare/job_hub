import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/application.dart';
import '../providers/application_provider.dart';

class MyApplicationsScreen extends ConsumerWidget {
  const MyApplicationsScreen({
    required this.applicantId,
    super.key,
  });

  final String applicantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync =
        ref.watch(applicationsByApplicantProvider(applicantId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        centerTitle: true,
      ),
      body: applicationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              const Text('Could not load your applications.'),
              TextButton(
                onPressed: () {
                  ref.invalidate(
                    applicationsByApplicantProvider(applicantId),
                  );
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
        data: (applications) {
          if (applications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.description_outlined, size: 64),
                  SizedBox(height: 16),
                  Text(
                    'No applications yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Your submitted job applications will appear here.'),
                ],
              ),
            );
          }

          final sortedApplications = [...applications]
            ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(
                applicationsByApplicantProvider(applicantId),
              );
              await ref.read(
                applicationsByApplicantProvider(applicantId).future,
              );
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sortedApplications.length,
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final application = sortedApplications[index];

                return _ApplicationCard(application: application);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application});

  final Application application;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.business_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.jobTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        application.companyName,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: application.status),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Applied on ${_formatDate(application.appliedAt)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_file, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    application.cvFileName,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            if (application.employerFeedback != null &&
                application.employerFeedback!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Employer feedback',
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(application.employerFeedback!),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      ApplicationStatus.pending => ('Pending', Colors.orange),
      ApplicationStatus.reviewed => ('Reviewed', Colors.blue),
      ApplicationStatus.shortlisted => ('Shortlisted', Colors.purple),
      ApplicationStatus.accepted => ('Accepted', Colors.green),
      ApplicationStatus.rejected => ('Rejected', Colors.red),
    };

    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
