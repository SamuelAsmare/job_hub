import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/sample_data/sample_settings.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});

final currentUserIdProvider = Provider<String>((ref) {
  return sampleUserId;
});

class SettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);
    final settings = await repository.getSettings(userId);
    return settings ?? AppSettings(userId: userId);
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(settingsRepositoryProvider);
      await repository.updateSettings(newSettings);
      return newSettings;
    });
  }

  Future<void> toggleNotifications(bool enabled) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(notificationsEnabled: enabled));
  }

  Future<void> toggleEmailNotifications(bool enabled) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(emailNotificationsEnabled: enabled));
  }

  Future<void> togglePushNotifications(bool enabled) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(pushNotificationsEnabled: enabled));
  }

  Future<void> updateThemeMode(String themeMode) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(themeMode: themeMode));
    // Propagate to the global theme provider so MaterialApp reflects the change
    ref.read(appThemeModeProvider.notifier).setThemeModeFromString(themeMode);
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, AppSettings>(() {
  return SettingsNotifier();
});
