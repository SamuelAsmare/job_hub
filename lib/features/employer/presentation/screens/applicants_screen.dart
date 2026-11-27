import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../applications/presentation/providers/application_provider.dart';

class ApplicantsScreen extends ConsumerWidget {
  const ApplicantsScreen({
    super.key,
    required this.vacancyId,
  });

  final String vacancyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applications = ref.watch(applicationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: applications.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Could not load applicants: $error'),
        ),
        data: (items) {
          final applicants = items
              .where((application) => application.jobId == vacancyId)
              .toList()
            ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

          if (applicants.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people_outline, size: 56),
                    SizedBox(height: 12),
                    Text(
                      'No applicants yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Applications for this vacancy will appear here.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applicants.length,
            itemBuilder: (context, index) {
              final application = applicants[index];

              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  title: Text(application.applicantId),
                  subtitle: Text(
                    '${application.cvFileName}\n'
                    'Applied: ${application.appliedAt.toLocal().toString().split(' ').first}',
                  ),
                  isThreeLine: true,
                  trailing: Chip(
                    label: Text(application.status.name),
                  ),
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(application.applicantId),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('CV: ${application.cvFileName}'),
                              const SizedBox(height: 12),
                              const Text(
                                'Cover Letter',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(application.coverLetter),
                              const SizedBox(height: 12),
                              Text('Status: ${application.status.name}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
