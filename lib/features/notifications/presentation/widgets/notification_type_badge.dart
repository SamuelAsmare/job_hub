import 'package:flutter/material.dart' hide Notification;

class NotificationTypeBadge extends StatelessWidget {
  final String type;

  const NotificationTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final (label, icon, color, bgColor) = _getTypeDetails(
      Theme.of(context).colorScheme,
      type,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  static (String, IconData, Color, Color) _getTypeDetails(
    ColorScheme colors,
    String type,
  ) {
    switch (type.toLowerCase()) {
      case 'application_status':
        return (
          'Application',
          Icons.assignment_turned_in_outlined,
          colors.onPrimaryContainer,
          colors.primaryContainer,
        );
      case 'message':
        return (
          'Message',
          Icons.chat_bubble_outline_rounded,
          colors.onTertiaryContainer,
          colors.tertiaryContainer,
        );
      case 'job_alert':
        return (
          'Job Alert',
          Icons.notifications_active_outlined,
          colors.onSecondaryContainer,
          colors.secondaryContainer,
        );
      default:
        return (
          'Update',
          Icons.info_outline_rounded,
          colors.onSurfaceVariant,
          colors.surfaceContainerHigh,
        );
    }
  }
}
