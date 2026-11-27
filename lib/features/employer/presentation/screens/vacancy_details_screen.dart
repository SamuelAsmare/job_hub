import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../providers/employer_provider.dart';

class VacancyDetailsScreen extends ConsumerWidget {
  const VacancyDetailsScreen({
    super.key,
    required this.vacancyId,
  });

  final String vacancyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employerId = ref.watch(employerIdProvider);
    final vacancy = ref.watch(
      employerVacancyProvider((
        employerId: employerId,
        vacancyId: vacancyId,
      )),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Vacancy Details')),
      body: vacancy.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Could not load vacancy: $error'),
        ),
        data: (job) {
          if (job == null) {
            return const Center(child: Text('Vacancy not found.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                job.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(job.companyName),
              const SizedBox(height: 16),
              _DetailRow(Icons.location_on_outlined, job.location),
              _DetailRow(Icons.work_outline, job.employmentType),
              if (job.salary != null)
                _DetailRow(Icons.payments_outlined, job.salary!),
              _DetailRow(
                Icons.calendar_today_outlined,
                'Posted ${job.postedAt.toLocal().toString().split(' ').first}',
              ),
              const Divider(height: 32),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(job.description),
              const SizedBox(height: 24),
              const Text(
                'Requirements',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...job.requirements.map(
                (requirement) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(requirement),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.push(
                  '${RouteNames.postVacancy}?vacancyId=${job.id}',
                ),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Vacancy'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => context.push(
                  RouteNames.applicantsPath(job.id),
                ),
                icon: const Icon(Icons.people_outline),
                label: const Text('View Applicants'),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Delete Vacancy?'),
                      content: const Text(
                        'This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed != true) return;

                  try {
                    await ref.read(employerRepositoryProvider).deleteVacancy(
                          employerId: employerId,
                          vacancyId: job.id,
                        );

                    ref.invalidate(employerVacanciesProvider(employerId));

                    if (context.mounted) {
                      context.go(RouteNames.employerDashboard);
                    }
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Delete failed: $error')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Delete Vacancy',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
