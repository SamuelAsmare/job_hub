import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/saved_job_provider.dart';
import '../widgets/saved_job_card.dart';

/// The Saved Jobs screen where job-seekers can view and manage their bookmarked jobs.
///
/// Route: `/saved-jobs` (owned by Samuel in router configuration).
class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  /// The standard route path for navigation registration.
  static const String routePath = '/saved-jobs';
  static const String routeName = 'saved-jobs';

  static const Color primaryNavy = Color(0xFF14264F);
  static const Color primaryBlue = Color(0xFF286BE8);
  static const Color accentCyan = Color(0xFF50CBE0);
  static const Color paleBlueBackground = Color(0xFFEAF2FF);
  static const Color secondaryText = Color(0xFF536584);
  static const Color mutedText = Color(0xFF7485A3);
  static const Color inputBorder = Color(0xFFD6E2F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedJobsAsync = ref.watch(savedJobsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              paleBlueBackground,
              Colors.white,
            ],
            stops: [0.0, 0.30],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: savedJobsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlue,
                    ),
                  ),
                  error: (error, stack) => _buildErrorState(context, ref, error),
                  data: (savedJobs) {
                    if (savedJobs.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return RefreshIndicator(
                      color: primaryBlue,
                      backgroundColor: Colors.white,
                      onRefresh: () async {
                        await ref.read(savedJobsProvider.notifier).refresh();
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        itemCount: savedJobs.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final savedJob = savedJobs[index];

                          return SavedJobCard(
                            key: ValueKey(savedJob.id),
                            savedJob: savedJob,
                            onRemove: () async {
                              await ref
                                  .read(savedJobsProvider.notifier)
                                  .removeSavedJob(savedJob.jobId);

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Job removed from saved list',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    backgroundColor: primaryNavy,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: inputBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: primaryNavy.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: primaryNavy,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'JOB SEEKER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Saved Jobs',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: primaryNavy,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Review and manage your bookmarked opportunities',
            style: TextStyle(
              fontSize: 13,
              color: secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: paleBlueBackground,
                shape: BoxShape.circle,
                border: Border.all(color: inputBorder, width: 1.5),
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                color: primaryBlue,
                size: 38,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Saved Jobs Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryNavy,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bookmark job openings while browsing to keep track of opportunities and apply whenever you are ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: secondaryText,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.search_rounded, size: 18),
                label: const Text(
                  'Explore Jobs',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Unable to load saved jobs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: secondaryText,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => ref.read(savedJobsProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
