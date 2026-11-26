import '../../domain/models/app_settings.dart';

const sampleUserId = 'user_001';

final sampleSettings = <String, AppSettings>{
  sampleUserId: const AppSettings(
    userId: sampleUserId,
    notificationsEnabled: true,
    emailNotificationsEnabled: true,
    pushNotificationsEnabled: true,
    language: 'en',
    themeMode: 'light',
  ),
};
