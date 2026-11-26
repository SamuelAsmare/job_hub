import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';

@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String participantOneId,
    required String participantTwoId,
    required String participantOneName,
    required String participantTwoName,
    String? participantOnePhoto,
    String? participantTwoPhoto,
    String? lastMessage,
    DateTime? lastMessageAt,
    @Default(0) int unreadCount,
  }) = _Conversation;
}
