import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:job_hub/features/settings/domain/models/app_settings.dart';
import 'package:job_hub/features/settings/presentation/providers/settings_provider.dart';

void main() {
  group('SettingsProvider', () {
    late ProviderContainer container;
    late SettingsRepositoryImpl repository;

    setUp(() {
      repository = SettingsRepositoryImpl(
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

      container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
          currentUserIdProvider.overrideWithValue('user_001'),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('loads initial settings for current user', () async {
      final initial = await container.read(settingsProvider.future);

      expect(initial.userId, 'user_001');
      expect(initial.notificationsEnabled, true);
      expect(initial.language, 'en');
      expect(initial.themeMode, 'light');
    });

    test('toggleNotifications updates provider state and repository', () async {
      await container.read(settingsProvider.future);

      await container.read(settingsProvider.notifier).toggleNotifications(false);

      final state = container.read(settingsProvider).value;
      expect(state?.notificationsEnabled, false);

      final inRepo = await repository.getSettings('user_001');
      expect(inRepo?.notificationsEnabled, false);
    });

    test('updateLanguage updates provider state and repository', () async {
      await container.read(settingsProvider.future);

      await container.read(settingsProvider.notifier).updateLanguage('am');

      final state = container.read(settingsProvider).value;
      expect(state?.language, 'am');

      final inRepo = await repository.getSettings('user_001');
      expect(inRepo?.language, 'am');
    });

    test('updateThemeMode updates provider state and repository', () async {
      await container.read(settingsProvider.future);

      await container.read(settingsProvider.notifier).updateThemeMode('dark');

      final state = container.read(settingsProvider).value;
      expect(state?.themeMode, 'dark');

      final inRepo = await repository.getSettings('user_001');
      expect(inRepo?.themeMode, 'dark');
    });
  });
}
