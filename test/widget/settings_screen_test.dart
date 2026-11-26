import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:job_hub/features/settings/domain/models/app_settings.dart';
import 'package:job_hub/features/settings/presentation/providers/settings_provider.dart';
import 'package:job_hub/features/settings/presentation/screens/settings_screen.dart';

void main() {
  Widget createTestWidget({
    required SettingsRepositoryImpl repository,
    String userId = 'user_001',
  }) {
    return ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(repository),
        currentUserIdProvider.overrideWithValue(userId),
      ],
      child: const MaterialApp(
        home: SettingsScreen(),
      ),
    );
  }

  group('SettingsScreen Widget Tests', () {
    testWidgets('renders screen title and initial settings correctly', (tester) async {
      final repository = SettingsRepositoryImpl(
        initialData: {
          'user_001': const AppSettings(
            userId: 'user_001',
            notificationsEnabled: true,
            emailNotificationsEnabled: true,
            pushNotificationsEnabled: true,
            language: 'en',
            themeMode: 'light',
          ),
        },
      );

      await tester.pumpWidget(createTestWidget(repository: repository));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('PREFERENCES'), findsAtLeast(1));
      expect(find.text('NOTIFICATIONS'), findsOneWidget);
      expect(find.text('Enable Notifications'), findsOneWidget);
      expect(find.text('Email Notifications'), findsOneWidget);
      expect(find.text('Push Notifications'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Theme Mode'), findsOneWidget);
      
      // Scroll to account section
      await tester.scrollUntilVisible(
        find.text('User Account'),
        50.0,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('User Account'), findsOneWidget);
      expect(find.text('user_001'), findsOneWidget);
    });

    testWidgets('toggling notifications updates UI', (tester) async {
      final repository = SettingsRepositoryImpl(
        initialData: {
          'user_001': const AppSettings(
            userId: 'user_001',
            notificationsEnabled: true,
            emailNotificationsEnabled: true,
            pushNotificationsEnabled: true,
            language: 'en',
            themeMode: 'light',
          ),
        },
      );

      await tester.pumpWidget(createTestWidget(repository: repository));
      await tester.pumpAndSettle();

      // Find switch for Enable Notifications and tap it
      final enableSwitch = find.byType(Switch).first;
      await tester.tap(enableSwitch);
      await tester.pumpAndSettle();

      // When notifications are disabled, sub-switches are hidden
      expect(find.text('Email Notifications'), findsNothing);
      expect(find.text('Push Notifications'), findsNothing);

      final updatedSettings = await repository.getSettings('user_001');
      expect(updatedSettings?.notificationsEnabled, false);
    });
  });
}
