import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../sample_data/sample_settings.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({Map<String, AppSettings>? initialData})
      : _settingsStore = Map<String, AppSettings>.from(initialData ?? sampleSettings);

  final Map<String, AppSettings> _settingsStore;

  @override
  Future<AppSettings?> getSettings(String userId) async {
    // Return a copy or the settings for the requested user
    if (_settingsStore.containsKey(userId)) {
      return _settingsStore[userId];
    }
    // Return sensible default settings for a user if none exist yet
    final defaultSettings = AppSettings(userId: userId);
    _settingsStore[userId] = defaultSettings;
    return defaultSettings;
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    _settingsStore[settings.userId] = settings;
  }
}
