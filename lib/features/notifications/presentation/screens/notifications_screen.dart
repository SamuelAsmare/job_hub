import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/notification_provider.dart';
import '../widgets/notification_item_card.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.surfaceContainerLow,
              colors.surface,
              colors.surface,
            ],
            stops: const [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context, ref, notificationsState),
              _buildHeader(context, notificationsState),
              const SizedBox(height: 12),
              Expanded(
                child: notificationsState.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(color: colors.primary),
                  ),
                  error: (error, stack) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: colors.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Failed to load notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .refresh();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  data: (notifications) {
                    if (notifications.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return RefreshIndicator(
                      color: colors.primary,
                      onRefresh: () async {
                        await ref
                            .read(notificationsProvider.notifier)
                            .refresh();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return NotificationItemCard(
                            key: ValueKey(notification.id),
                            notification: notification,
                            onMarkAsRead: () {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .markAsRead(notification.id);
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

  Widget _buildEmptyState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.outlineVariant,
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 40,
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We will notify you about updates to your job applications and recruiter messages.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<dynamic>> notificationsState,
  ) {
    final colors = Theme.of(context).colorScheme;
    final hasUnread = notificationsState.maybeWhen(
      data: (items) => items.any((n) => !n.isRead),
      orElse: () => false,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: colors.onSurface,
              ),
              onPressed: () {
                final router = GoRouter.maybeOf(context);
                if (router != null) {
                  if (router.canPop()) router.pop();
                } else {
                  Navigator.of(context).maybePop();
                }
              },
            ),
          ),
          if (hasUnread)
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
                backgroundColor: colors.surfaceContainerHigh,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: colors.outlineVariant),
                ),
              ),
              onPressed: () {
                ref.read(notificationsProvider.notifier).markAllAsRead();
              },
              icon: const Icon(Icons.done_all_rounded, size: 16),
              label: const Text(
                'Mark all read',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AsyncValue<List<dynamic>> notificationsState,
  ) {
    final colors = Theme.of(context).colorScheme;
    final unreadCount = notificationsState.maybeWhen(
      data: (items) => items.where((n) => !n.isRead).length,
      orElse: () => 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UPDATES & ALERTS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              if (unreadCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$unreadCount new',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Stay updated on your job applications and recruitment activity.',
            style: TextStyle(
              fontSize: 13,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
