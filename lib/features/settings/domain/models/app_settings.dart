import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    required String userId,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool emailNotificationsEnabled,
    @Default(true) bool pushNotificationsEnabled,
    @Default('light') String themeMode,
  }) = _AppSettings;
}
