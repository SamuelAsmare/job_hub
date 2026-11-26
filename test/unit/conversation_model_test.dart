import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/messaging/domain/models/conversation.dart';

void main() {
  group('Conversation model', () {
    test('creates a conversation with default unread count', () {
      final lastMessageAt = DateTime(2026, 11, 26);

      final conversation = Conversation(
        id: 'conversation-1',
        participantOneId: 'user-1',
        participantTwoId: 'user-2',
        participantOneName: 'Job Seeker',
        participantTwoName: 'Employer',
        lastMessage: 'Hello!',
        lastMessageAt: lastMessageAt,
      );

      expect(conversation.id, 'conversation-1');
      expect(conversation.participantOneName, 'Job Seeker');
      expect(conversation.participantTwoName, 'Employer');
      expect(conversation.unreadCount, 0);
      expect(conversation.lastMessageAt, lastMessageAt);
    });

    test('stores profile photos and unread count', () {
      const conversation = Conversation(
        id: 'conversation-2',
        participantOneId: 'user-1',
        participantTwoId: 'user-2',
        participantOneName: 'Sara',
        participantTwoName: 'Employer',
        participantOnePhoto: 'https://example.com/sara.png',
        participantTwoPhoto: 'https://example.com/employer.png',
        unreadCount: 3,
      );

      expect(conversation.participantOnePhoto, isNotNull);
      expect(conversation.participantTwoPhoto, isNotNull);
      expect(conversation.unreadCount, 3);
    });
  });
}
