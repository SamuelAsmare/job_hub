import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:job_hub/features/notifications/domain/models/notification.dart';

void main() {
  group('NotificationRepositoryImpl', () {
    late Notification notification1;
    late Notification notification2;
    late Notification notification3;
    late Notification user2Notification;
    late NotificationRepositoryImpl repository;

    setUp(() {
      notification1 = Notification(
        id: 'n1',
        userId: 'user_001',
        title: 'Title 1',
        message: 'Message 1',
        type: 'application_status',
        isRead: false,
        createdAt: DateTime(2026, 11, 20, 10, 0),
      );

      notification2 = Notification(
        id: 'n2',
        userId: 'user_001',
        title: 'Title 2',
        message: 'Message 2',
        type: 'message',
        isRead: false,
        createdAt: DateTime(2026, 11, 21, 10, 0), // Newer
      );

      notification3 = Notification(
        id: 'n3',
        userId: 'user_001',
        title: 'Title 3',
        message: 'Message 3',
        type: 'job_alert',
        isRead: true,
        createdAt: DateTime(2026, 11, 19, 10, 0), // Oldest
      );

      user2Notification = Notification(
        id: 'n4',
        userId: 'user_002',
        title: 'User 2 Title',
        message: 'User 2 Message',
        type: 'system',
        isRead: false,
        createdAt: DateTime(2026, 11, 22, 10, 0),
      );

      repository = NotificationRepositoryImpl(
        initialNotifications: [
          notification1,
          notification2,
          notification3,
          user2Notification,
        ],
      );
    });

    test('getNotifications returns only notifications for the requested user', () async {
      final user1Notifications = await repository.getNotifications('user_001');
      expect(user1Notifications.length, 3);
      expect(user1Notifications.every((n) => n.userId == 'user_001'), isTrue);

      final user2Notifications = await repository.getNotifications('user_002');
      expect(user2Notifications.length, 1);
      expect(user2Notifications.first.id, 'n4');
    });

    test('getNotifications returns notifications in chronological order (newest first)', () async {
      final notifications = await repository.getNotifications('user_001');
      expect(notifications.length, 3);
      expect(notifications[0].id, 'n2'); // Nov 21
      expect(notifications[1].id, 'n1'); // Nov 20
      expect(notifications[2].id, 'n3'); // Nov 19
    });

    test('markAsRead changes the selected notification isRead value to true', () async {
      final initial = await repository.getNotifications('user_001');
      expect(initial.firstWhere((n) => n.id == 'n1').isRead, isFalse);

      await repository.markAsRead('n1');

      final updated = await repository.getNotifications('user_001');
      expect(updated.firstWhere((n) => n.id == 'n1').isRead, isTrue);
    });

    test('markAsRead does not modify unrelated notifications', () async {
      await repository.markAsRead('n1');

      final user1Notifications = await repository.getNotifications('user_001');
      expect(user1Notifications.firstWhere((n) => n.id == 'n2').isRead, isFalse);

      final user2Notifications = await repository.getNotifications('user_002');
      expect(user2Notifications.firstWhere((n) => n.id == 'n4').isRead, isFalse);
    });

    test('markAllAsRead marks all notifications for requested user as read', () async {
      await repository.markAllAsRead('user_001');

      final user1Notifications = await repository.getNotifications('user_001');
      expect(user1Notifications.every((n) => n.isRead), isTrue);
    });

    test('markAllAsRead does not modify another user notifications', () async {
      await repository.markAllAsRead('user_001');

      final user2Notifications = await repository.getNotifications('user_002');
      expect(user2Notifications.first.isRead, isFalse);
    });

    test('handles empty notification collections gracefully', () async {
      final emptyRepo = NotificationRepositoryImpl(initialNotifications: []);
      final result = await emptyRepo.getNotifications('user_001');
      expect(result, isEmpty);

      // Safe to call operations on empty repo
      await emptyRepo.markAsRead('non_existent');
      await emptyRepo.markAllAsRead('user_001');
    });

    test('returned collection cannot be mutated to alter repository state', () async {
      final notifications = await repository.getNotifications('user_001');
      expect(() => (notifications as dynamic).add(notification1), throwsUnsupportedError);
    });
  });
}
