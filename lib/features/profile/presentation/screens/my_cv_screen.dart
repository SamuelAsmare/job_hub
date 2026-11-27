import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class MyCvScreen extends ConsumerWidget {
  const MyCvScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(profileProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view your CV.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
      ),
      body: profileAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: TextButton(
            onPressed: () => ref.invalidate(profileProvider),
            child: const Text('Unable to load CV. Tap to retry.'),
          ),
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(
              child: Text('No CV information available.'),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Curriculum Vitae',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.cvUrl ?? 'No CV file attached',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Chip(
                        avatar: Icon(Icons.info_outline, size: 18),
                        label: Text('Sample CV information'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _CvSection(
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [
                  _CvItem(label: 'Name', value: user.fullName),
                  _CvItem(label: 'Email', value: user.email),
                  _CvItem(
                    label: 'Phone',
                    value: profile.phone ?? 'Not provided',
                  ),
                ],
              ),
              _CvSection(
                title: 'Professional Summary',
                icon: Icons.badge_outlined,
                children: [
                  Text(profile.bio ?? 'No professional summary added.'),
                ],
              ),
              _CvSection(
                title: 'Skills',
                icon: Icons.code,
                children: [
                  _CvList(items: profile.skills),
                ],
              ),
              _CvSection(
                title: 'Education',
                icon: Icons.school_outlined,
                children: [
                  _CvList(items: profile.education),
                ],
              ),
              _CvSection(
                title: 'Work Experience',
                icon: Icons.work_outline,
                children: [
                  _CvList(items: profile.experience),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CvSection extends StatelessWidget {
  const _CvSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _CvItem extends StatelessWidget {
  const _CvItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 3),
          Text(value),
        ],
      ),
    );
  }
}

class _CvList extends StatelessWidget {
  const _CvList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text('No information added yet.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  '),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
