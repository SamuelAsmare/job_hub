import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageType {
  text,
  image,
  file,
}

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String content,
    required DateTime sentAt,
    @Default(MessageType.text) MessageType type,
    @Default(false) bool isRead,
    String? attachmentName,
  }) = _Message;
}
