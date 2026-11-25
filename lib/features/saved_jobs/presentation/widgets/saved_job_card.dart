import 'package:flutter/material.dart';
import '../../domain/models/saved_job.dart';
import '../providers/saved_job_provider.dart';

class SavedJobCard extends StatelessWidget {
  const SavedJobCard({
    super.key,
    required this.savedJob,
    required this.jobSummary,
    required this.onRemove,
    this.onTap,
  });

  final SavedJob savedJob;
  final JobSummary? jobSummary;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  static const Color primaryNavy = Color(0xFF14264F);
  static const Color primaryBlue = Color(0xFF286BE8);
  static const Color accentCyan = Color(0xFF50CBE0);
  static const Color paleBlueBackground = Color(0xFFEAF2FF);
  static const Color secondaryText = Color(0xFF536584);
  static const Color mutedText = Color(0xFF7485A3);
  static const Color inputBorder = Color(0xFFD6E2F5);

  @override
  Widget build(BuildContext context) {
    final title = jobSummary?.title ?? 'Position #${savedJob.jobId}';
    final company = jobSummary?.company ?? 'Employer Details Pending';
    final location = jobSummary?.location ?? 'Location not specified';
    final salary = jobSummary?.salary ?? 'Competitive Salary';
    final type = jobSummary?.type ?? 'Full-time';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: inputBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryNavy.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: paleBlueBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.work_outline_rounded,
                        color: primaryBlue,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryNavy,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            company,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_rounded,
                        color: primaryBlue,
                        size: 24,
                      ),
                      tooltip: 'Remove from saved jobs',
                      onPressed: onRemove,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _buildPill(icon: Icons.location_on_outlined, label: location),
                    _buildPill(icon: Icons.schedule_rounded, label: type),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: inputBorder),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salary,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                    Text(
                      'Saved ${_formatDate(savedJob.savedAt)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: mutedText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: paleBlueBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: primaryNavy),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primaryNavy,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
