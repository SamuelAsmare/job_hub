import '../../domain/models/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../sample_data/sample_notifications.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final List<Notification> _notifications;

  NotificationRepositoryImpl({List<Notification>? initialNotifications})
      : _notifications = List<Notification>.from(
          initialNotifications ?? sampleNotifications,
        );

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    final userNotifications = _notifications
        .where((notification) => notification.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List<Notification>.unmodifiable(userNotifications);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    for (int i = 0; i < _notifications.length; i++) {
      if (_notifications[i].userId == userId && !_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
  }
}
