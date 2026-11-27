import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:job_hub/features/settings/domain/models/app_settings.dart';

void main() {
  group('SettingsRepositoryImpl', () {
    late SettingsRepositoryImpl repository;

    setUp(() {
      repository = SettingsRepositoryImpl(
        initialData: {
          'user_001': const AppSettings(
            userId: 'user_001',
            notificationsEnabled: true,
            emailNotificationsEnabled: true,
            pushNotificationsEnabled: false,
            themeMode: 'light',
          ),
          'user_002': const AppSettings(
            userId: 'user_002',
            notificationsEnabled: false,
            emailNotificationsEnabled: false,
            pushNotificationsEnabled: false,
            themeMode: 'dark',
          ),
        },
      );
    });

    test('getSettings returns settings for requested user', () async {
      final settings = await repository.getSettings('user_001');

      expect(settings, isNotNull);
      expect(settings?.userId, 'user_001');
      expect(settings?.notificationsEnabled, true);
      expect(settings?.pushNotificationsEnabled, false);
      expect(settings?.themeMode, 'light');
    });

    test('getSettings generates default settings for a new user without existing settings', () async {
      final settings = await repository.getSettings('user_new');

      expect(settings, isNotNull);
      expect(settings?.userId, 'user_new');
      expect(settings?.notificationsEnabled, true);
      expect(settings?.themeMode, 'light');
    });

    test('updateSettings updates the intended user settings', () async {
      const updated = AppSettings(
        userId: 'user_001',
        notificationsEnabled: false,
        emailNotificationsEnabled: false,
        pushNotificationsEnabled: true,
        themeMode: 'dark',
      );

      await repository.updateSettings(updated);

      final retrieved = await repository.getSettings('user_001');
      expect(retrieved, updated);
    });

    test('updating one user settings does not modify another user settings', () async {
      const updated = AppSettings(
        userId: 'user_001',
        notificationsEnabled: false,
        emailNotificationsEnabled: false,
        pushNotificationsEnabled: false,
        themeMode: 'system',
      );

      await repository.updateSettings(updated);

      final user1 = await repository.getSettings('user_001');
      final user2 = await repository.getSettings('user_002');

      expect(user1?.themeMode, 'system');
      expect(user2?.themeMode, 'dark');
      expect(user2?.userId, 'user_002');
    });
  });
}
