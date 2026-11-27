import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:job_hub/features/notifications/domain/models/notification.dart';
import 'package:job_hub/features/notifications/domain/repositories/notification_repository.dart';
import 'package:job_hub/features/notifications/presentation/providers/notification_provider.dart';
import 'package:job_hub/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:job_hub/core/theme/app_theme.dart';

class FailingNotificationRepository implements NotificationRepository {
  @override
  Future<List<Notification>> getNotifications(String userId) async {
    throw Exception('Failed to connect to notification server');
  }

  @override
  Future<void> markAllAsRead(String userId) async {}

  @override
  Future<void> markAsRead(String notificationId) async {}
}

void main() {
  group('NotificationsScreen Widget Tests', () {
    late Notification unreadNotification;
    late Notification readNotification;

    setUp(() {
      unreadNotification = Notification(
        id: 'notif_unread',
        userId: 'user_001',
        title: 'Interview Scheduled',
        message: 'Your interview with Google is scheduled for tomorrow.',
        type: 'application_status',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      readNotification = Notification(
        id: 'notif_read',
        userId: 'user_001',
        title: 'Welcome to JobHub',
        message: 'Explore open vacancies and apply today.',
        type: 'system',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      );
    });

    Widget createWidgetUnderTest(NotificationRepository repository) {
      return ProviderScope(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(repository),
          currentNotificationUserIdProvider.overrideWithValue('user_001'),
        ],
        child: const MaterialApp(
          home: NotificationsScreen(),
        ),
      );
    }

    testWidgets(
        'renders populated notifications with distinguishably styled unread items',
        (tester) async {
      final repository = NotificationRepositoryImpl(
        initialNotifications: [unreadNotification, readNotification],
      );

      await tester.pumpWidget(createWidgetUnderTest(repository));
      await tester.pumpAndSettle();

      // Screen title and subtitle
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('UPDATES & ALERTS'), findsOneWidget);

      // Both notification titles and messages appear
      expect(find.text('Interview Scheduled'), findsOneWidget);
      expect(find.text('Your interview with Google is scheduled for tomorrow.'),
          findsOneWidget);
      expect(find.text('Welcome to JobHub'), findsOneWidget);
      expect(
          find.text('Explore open vacancies and apply today.'), findsOneWidget);

      // Unread badge indicator
      expect(find.text('1 new'), findsOneWidget);

      // Individual mark as read button exists for unread item only
      expect(find.text('Mark as read'), findsOneWidget);

      // Mark all read action button is shown when unread notifications exist
      expect(find.text('Mark all read'), findsOneWidget);
    });

    testWidgets('tapping individual mark as read marks notification as read',
        (tester) async {
      final repository = NotificationRepositoryImpl(
        initialNotifications: [unreadNotification],
      );

      await tester.pumpWidget(createWidgetUnderTest(repository));
      await tester.pumpAndSettle();

      expect(find.text('Mark as read'), findsOneWidget);

      await tester.tap(find.text('Mark as read'));
      await tester.pumpAndSettle();

      // Once marked as read, individual mark as read button disappears
      expect(find.text('Mark as read'), findsNothing);
      expect(find.text('Mark all read'), findsNothing);
    });

    testWidgets('tapping mark all read marks all notifications as read',
        (tester) async {
      final repository = NotificationRepositoryImpl(
        initialNotifications: [unreadNotification],
      );

      await tester.pumpWidget(createWidgetUnderTest(repository));
      await tester.pumpAndSettle();

      expect(find.text('Mark all read'), findsOneWidget);

      await tester.tap(find.text('Mark all read'));
      await tester.pumpAndSettle();

      expect(find.text('Mark all read'), findsNothing);
      expect(find.text('Mark as read'), findsNothing);
    });

    testWidgets('renders empty state when there are no notifications',
        (tester) async {
      final repository = NotificationRepositoryImpl(
        initialNotifications: [],
      );

      await tester.pumpWidget(createWidgetUnderTest(repository));
      await tester.pumpAndSettle();

      expect(find.text('No notifications yet'), findsOneWidget);
      expect(
        find.text(
            'We will notify you about updates to your job applications and recruiter messages.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);
    });

    testWidgets('notifications empty state uses dark theme colors',
        (tester) async {
      final repository = NotificationRepositoryImpl(initialNotifications: []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationRepositoryProvider.overrideWithValue(repository),
            currentNotificationUserIdProvider.overrideWithValue('user_001'),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            home: const NotificationsScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final title = tester.widget<Text>(find.text('Notifications'));
      expect(title.style?.color, AppTheme.darkTheme.colorScheme.onSurface);
    });

    testWidgets('renders error state and retry button on failure',
        (tester) async {
      final failingRepository = FailingNotificationRepository();

      await tester.pumpWidget(createWidgetUnderTest(failingRepository));
      await tester.pumpAndSettle();

      expect(find.text('Failed to load notifications'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
