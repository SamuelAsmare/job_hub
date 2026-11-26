import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/messaging/domain/models/message.dart';

void main() {
  group('Message model', () {
    test('creates a text message with default values', () {
      final sentAt = DateTime(2026, 11, 26);

      final message = Message(
        id: 'message-1',
        conversationId: 'conversation-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'Hello!',
        sentAt: sentAt,
      );

      expect(message.id, 'message-1');
      expect(message.content, 'Hello!');
      expect(message.type, MessageType.text);
      expect(message.isRead, false);
      expect(message.sentAt, sentAt);
    });

    test('supports image and file message types', () {
      final imageMessage = Message(
        id: 'message-2',
        conversationId: 'conversation-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'image-reference',
        sentAt: DateTime(2026, 11, 26),
        type: MessageType.image,
      );

      final fileMessage = Message(
        id: 'message-3',
        conversationId: 'conversation-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'resume.pdf',
        sentAt: DateTime(2026, 11, 26),
        type: MessageType.file,
        isRead: true,
      );

      expect(imageMessage.type, MessageType.image);
      expect(fileMessage.type, MessageType.file);
      expect(fileMessage.isRead, true);
    });
  });
}
