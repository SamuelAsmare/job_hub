import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/notifications/domain/models/notification.dart'
    show AppNotification;
import 'package:job_hub/features/notifications/domain/repositories/notification_repository.dart';
import 'package:job_hub/features/notifications/presentation/providers/notification_provider.dart';
import 'package:job_hub/features/notifications/presentation/screens/notifications_screen.dart';

class FakeNotificationRepository implements NotificationRepository {
  @override
  Future<List<AppNotification>> getNotifications(String userId) async => [];

  @override
  Future<void> markAsRead(String notificationId) async {}

  @override
  Future<void> markAllAsRead(String userId) async {}
}

void main() {
  testWidgets('shows the notifications empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(
            FakeNotificationRepository(),
          ),
        ],
        child: const MaterialApp(
          home: NotificationsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('No notifications yet'), findsOneWidget);
    expect(
      find.text(
        'We will notify you about updates to your job applications and recruiter messages.',
      ),
      findsOneWidget,
    );
  });
}
