import 'package:flutter/material.dart';

import '../../domain/models/user.dart';

class AuthRoleSelector extends StatelessWidget {
  const AuthRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  final UserRole selectedRole;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I want to join JobHub as a',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _RoleCard(
                title: 'Job Seeker',
                subtitle: 'Find opportunities',
                icon: Icons.person_search_outlined,
                selected: selectedRole == UserRole.jobSeeker,
                onTap: () => onChanged(UserRole.jobSeeker),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _RoleCard(
                title: 'Employer',
                subtitle: 'Hire talent',
                icon: Icons.business_outlined,
                selected: selectedRole == UserRole.employer,
                onTap: () => onChanged(UserRole.employer),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      label: '$title. $subtitle',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? colors.primaryContainer : colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? colors.primary : colors.onSurfaceVariant,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (selected) ...[
                const SizedBox(height: 8),
                Icon(
                  Icons.check_circle,
                  color: colors.primary,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
