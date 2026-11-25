import 'package:flutter/material.dart' hide Notification;

class NotificationTypeBadge extends StatelessWidget {
  final String type;

  const NotificationTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final (label, icon, color, bgColor) = _getTypeDetails(type);

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

  static (String, IconData, Color, Color) _getTypeDetails(String type) {
    switch (type.toLowerCase()) {
      case 'application_status':
        return (
          'Application',
          Icons.assignment_turned_in_outlined,
          const Color(0xFF286BE8),
          const Color(0xFFEAF2FF),
        );
      case 'message':
        return (
          'Message',
          Icons.chat_bubble_outline_rounded,
          const Color(0xFF14264F),
          const Color(0xFFEAF2FF),
        );
      case 'job_alert':
        return (
          'Job Alert',
          Icons.notifications_active_outlined,
          const Color(0xFF0097A7),
          const Color(0xFFE0F7FA),
        );
      default:
        return (
          'Update',
          Icons.info_outline_rounded,
          const Color(0xFF536584),
          const Color(0xFFF1F4F9),
        );
    }
  }
}
