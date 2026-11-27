import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedJobsAsync = ref.watch(savedJobsProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.surfaceContainerLow, colors.surface],
            stops: const [0.0, 0.30],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: savedJobsAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(color: colors.primary),
                  ),
                  error: (error, stack) =>
                      _buildErrorState(context, ref, error),
                  data: (savedJobs) {
                    if (savedJobs.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return RefreshIndicator(
                      color: colors.primary,
                      backgroundColor: colors.surface,
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
                                    backgroundColor: colors.inverseSurface,
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
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  final router = GoRouter.maybeOf(context);
                  if (router != null) {
                    if (router.canPop()) router.pop();
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.outlineVariant, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'JOB SEEKER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Saved Jobs',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Review and manage your bookmarked opportunities',
            style: TextStyle(
              fontSize: 13,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
                color: colors.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colors.outlineVariant, width: 1.5),
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                color: colors.onPrimaryContainer,
                size: 38,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Saved Jobs Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Bookmark job openings while browsing to keep track of opportunities and apply whenever you are ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {
                  final router = GoRouter.maybeOf(context);
                  if (router != null) {
                    router.push(RouteNames.jobSearch);
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                icon: const Icon(Icons.search_rounded, size: 18),
                label: const Text(
                  'Explore Jobs',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
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
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: colors.error,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load saved jobs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => ref.read(savedJobsProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
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
