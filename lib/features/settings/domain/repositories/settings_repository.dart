import '../models/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings?> getSettings(String userId);
  Future<void> updateSettings(AppSettings settings);
}
