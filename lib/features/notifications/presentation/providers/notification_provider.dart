import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/notification_repository_impl.dart';
import '../../data/sample_data/sample_notifications.dart';
import '../../domain/models/notification.dart';
import '../../domain/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl();
});

final currentNotificationUserIdProvider = Provider<String>((ref) {
  return sampleUserId;
});

class NotificationsNotifier extends AsyncNotifier<List<Notification>> {
  @override
  Future<List<Notification>> build() async {
    final repository = ref.watch(notificationRepositoryProvider);
    final userId = ref.watch(currentNotificationUserIdProvider);
    return repository.getNotifications(userId);
  }

  Future<void> markAsRead(String notificationId) async {
    final repository = ref.read(notificationRepositoryProvider);
    final userId = ref.read(currentNotificationUserIdProvider);
    await repository.markAsRead(notificationId);
    state = AsyncData(await repository.getNotifications(userId));
  }

  Future<void> markAllAsRead() async {
    final repository = ref.read(notificationRepositoryProvider);
    final userId = ref.read(currentNotificationUserIdProvider);
    await repository.markAllAsRead(userId);
    state = AsyncData(await repository.getNotifications(userId));
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(notificationRepositoryProvider);
      final userId = ref.read(currentNotificationUserIdProvider);
      return repository.getNotifications(userId);
    });
  }
}

final notificationsProvider =
    AsyncNotifierProvider<NotificationsNotifier, List<Notification>>(
  NotificationsNotifier.new,
);
