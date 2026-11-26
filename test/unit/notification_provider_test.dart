import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:job_hub/features/notifications/domain/models/notification.dart';
import 'package:job_hub/features/notifications/domain/repositories/notification_repository.dart';
import 'package:job_hub/features/notifications/presentation/providers/notification_provider.dart';

class FailingNotificationRepository implements NotificationRepository {
  @override
  Future<List<Notification>> getNotifications(String userId) async {
    throw Exception('Database connection failed');
  }

  @override
  Future<void> markAllAsRead(String userId) async {}

  @override
  Future<void> markAsRead(String notificationId) async {}
}

void main() {
  group('NotificationsNotifier Provider', () {
    late Notification testNotification1;
    late Notification testNotification2;
    late NotificationRepositoryImpl repository;

    setUp(() {
      testNotification1 = Notification(
        id: 'notif_1',
        userId: 'user_001',
        title: 'App Update',
        message: 'Your profile was viewed.',
        type: 'application_status',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      testNotification2 = Notification(
        id: 'notif_2',
        userId: 'user_001',
        title: 'Interview Request',
        message: 'TechCorp sent an invite.',
        type: 'message',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      );

      repository = NotificationRepositoryImpl(
        initialNotifications: [testNotification1, testNotification2],
      );
    });

    test('loads initial notification data for the sample user', () async {
      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(repository),
          currentNotificationUserIdProvider.overrideWithValue('user_001'),
        ],
      );
      addTearDown(container.dispose);

      // Keep provider active
      container.listen(notificationsProvider, (_, __) {});

      final asyncValue = await container.read(notificationsProvider.future);
      expect(asyncValue.length, 2);
      expect(asyncValue.map((n) => n.id), containsAll(['notif_1', 'notif_2']));
    });

    test('marking one notification as read updates provider state', () async {
      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(repository),
          currentNotificationUserIdProvider.overrideWithValue('user_001'),
        ],
      );
      addTearDown(container.dispose);

      container.listen(notificationsProvider, (_, __) {});
      await container.read(notificationsProvider.future);

      await container.read(notificationsProvider.notifier).markAsRead('notif_1');

      final updatedState = container.read(notificationsProvider).asData?.value;
      expect(updatedState, isNotNull);
      final notif1 = updatedState!.firstWhere((n) => n.id == 'notif_1');
      final notif2 = updatedState.firstWhere((n) => n.id == 'notif_2');

      expect(notif1.isRead, isTrue);
      expect(notif2.isRead, isFalse);
    });

    test('marking all notifications as read updates provider state', () async {
      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(repository),
          currentNotificationUserIdProvider.overrideWithValue('user_001'),
        ],
      );
      addTearDown(container.dispose);

      container.listen(notificationsProvider, (_, __) {});
      await container.read(notificationsProvider.future);

      await container.read(notificationsProvider.notifier).markAllAsRead();

      final updatedState = container.read(notificationsProvider).asData?.value;
      expect(updatedState, isNotNull);
      expect(updatedState!.every((n) => n.isRead), isTrue);
    });

    test('exposes error state when repository throws exception', () async {
      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(FailingNotificationRepository()),
          currentNotificationUserIdProvider.overrideWithValue('user_001'),
        ],
      );
      addTearDown(container.dispose);

      final subscription = container.listen(
        notificationsProvider,
        (_, __) {},
        onError: (err, stack) {},
      );

      await Future<void>.delayed(Duration.zero);

      final state = container.read(notificationsProvider);
      expect(state.hasError, isTrue);
      expect(state.error.toString(), contains('Database connection failed'));

      subscription.close();
    });
  });
}
