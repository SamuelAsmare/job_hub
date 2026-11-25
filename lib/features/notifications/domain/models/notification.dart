import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String userId,
    required String title,
    required String message,
    required String type,
    required bool isRead,
    required DateTime createdAt,
  }) = _Notification;
}

/// Type alias to prevent naming collisions with Flutter's [Notification] class.
typedef AppNotification = Notification;
