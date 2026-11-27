import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/domain/models/user.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../domain/models/job_seeker_profile.dart';
import '../providers/profile_provider.dart';

class JobSeekerProfileScreen extends ConsumerWidget {
  const JobSeekerProfileScreen({super.key});

  Future<void> _editProfile(
    BuildContext context,
    WidgetRef ref,
    JobSeekerProfile profile,
  ) async {
    final phoneController = TextEditingController(
      text: profile.phone ?? '',
    );
    final bioController = TextEditingController(
      text: profile.bio ?? '',
    );
    final skillsController = TextEditingController(
      text: profile.skills.join(', '),
    );
    final educationController = TextEditingController(
      text: profile.education.join('\n'),
    );
    final experienceController = TextEditingController(
      text: profile.experience.join('\n'),
    );

    String? errorMessage;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ProfileInput(
                      controller: phoneController,
                      label: 'Phone number',
                    ),
                    _ProfileInput(
                      controller: bioController,
                      label: 'Bio',
                      maxLines: 3,
                    ),
                    _ProfileInput(
                      controller: skillsController,
                      label: 'Skills',
                      hint: 'Separate skills with commas',
                      maxLines: 2,
                    ),
                    _ProfileInput(
                      controller: educationController,
                      label: 'Education',
                      hint: 'Enter each qualification on a new line',
                      maxLines: 3,
                    ),
                    _ProfileInput(
                      controller: experienceController,
                      label: 'Experience',
                      hint: 'Enter each experience on a new line',
                      maxLines: 3,
                    ),
                    if (errorMessage != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    setDialogState(() => errorMessage = null);

                    try {
                      final updatedProfile = profile.copyWith(
                        phone: phoneController.text.trim().isEmpty
                            ? null
                            : phoneController.text.trim(),
                        bio: bioController.text.trim().isEmpty
                            ? null
                            : bioController.text.trim(),
                        skills: skillsController.text
                            .split(',')
                            .map((item) => item.trim())
                            .where((item) => item.isNotEmpty)
                            .toList(),
                        education: educationController.text
                            .split('\n')
                            .map((item) => item.trim())
                            .where((item) => item.isNotEmpty)
                            .toList(),
                        experience: experienceController.text
                            .split('\n')
                            .map((item) => item.trim())
                            .where((item) => item.isNotEmpty)
                            .toList(),
                      );

                      await ref.read(updateProfileProvider)(updatedProfile);

                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile updated successfully.'),
                          ),
                        );
                      }
                    } catch (_) {
                      setDialogState(() {
                        errorMessage = 'Unable to update profile. Try again.';
                      });
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            );
          },
        );
      },
    );

    phoneController.dispose();
    bioController.dispose();
    skillsController.dispose();
    educationController.dispose();
    experienceController.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(profileProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view your profile.')),
      );
    }

    if (user.role != UserRole.jobSeeker) {
      return const Scaffold(
        body: Center(
          child: Text('This profile is available to job seekers.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: profileAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Unable to load your profile.'),
              TextButton(
                onPressed: () => ref.invalidate(profileProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (profile) {
          final currentProfile = profile ?? JobSeekerProfile(userId: user.id);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 42,
                  child: Text(
                    user.fullName.isNotEmpty
                        ? user.fullName[0].toUpperCase()
                        : '?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => _editProfile(
                  context,
                  ref,
                  currentProfile,
                ),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push('/profile/cv'),
                icon: const Icon(Icons.description_outlined),
                label: const Text('View My CV'),
              ),
              const SizedBox(height: 24),
              _ProfileSection(
                title: 'Contact Information',
                icon: Icons.contact_phone_outlined,
                children: [
                  _ProfileText(
                    label: 'Phone',
                    value: currentProfile.phone,
                  ),
                ],
              ),
              _ProfileSection(
                title: 'About Me',
                icon: Icons.person_outline,
                children: [
                  Text(
                    currentProfile.bio?.isNotEmpty == true
                        ? currentProfile.bio!
                        : 'No bio added yet.',
                  ),
                ],
              ),
              _ProfileSection(
                title: 'Skills',
                icon: Icons.code,
                children: [
                  _ProfileList(items: currentProfile.skills),
                ],
              ),
              _ProfileSection(
                title: 'Education',
                icon: Icons.school_outlined,
                children: [
                  _ProfileList(items: currentProfile.education),
                ],
              ),
              _ProfileSection(
                title: 'Experience',
                icon: Icons.work_outline,
                children: [
                  _ProfileList(items: currentProfile.experience),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
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
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ProfileText extends StatelessWidget {
  const _ProfileText({
    required this.label,
    required this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 4),
        Text(value?.isNotEmpty == true ? value! : 'Not provided'),
      ],
    );
  }
}

class _ProfileList extends StatelessWidget {
  const _ProfileList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text('Nothing added yet.');
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

class _ProfileInput extends StatelessWidget {
  const _ProfileInput({
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }
}
