import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/messaging/data/datasources/message_local_datasource.dart';
import 'package:job_hub/features/messaging/data/repositories/message_repository_impl.dart';
import 'package:job_hub/features/messaging/domain/models/conversation.dart';
import 'package:job_hub/features/messaging/domain/models/message.dart';

void main() {
  late MessageLocalDataSource dataSource;
  late MessageRepositoryImpl repository;

  final now = DateTime(2026, 11, 26, 14);

  Conversation createConversation() {
    return Conversation(
      id: 'conversation-1',
      participantOneId: 'user-1',
      participantTwoId: 'user-2',
      participantOneName: 'Job Seeker',
      participantTwoName: 'Employer',
      lastMessage: 'Hello',
      lastMessageAt: now,
    );
  }

  Message createMessage({
    String id = 'message-1',
    String content = 'Hello!',
    String senderId = 'user-1',
    String receiverId = 'user-2',
    bool isRead = false,
  }) {
    return Message(
      id: id,
      conversationId: 'conversation-1',
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      sentAt: now,
      isRead: isRead,
    );
  }

  setUp(() {
    dataSource = MessageLocalDataSource(
      initialConversations: [createConversation()],
      initialMessages: [
        createMessage(),
        createMessage(
          id: 'message-2',
          content: 'How are you?',
          senderId: 'user-2',
          receiverId: 'user-1',
        ),
      ],
    );

    repository = MessageRepositoryImpl(dataSource);
  });

  group('MessageRepository', () {
    test('creates a conversation between two users', () async {
      final conversation = await repository.getOrCreateConversation(
        currentUserId: 'new-seeker',
        currentUserName: 'New Seeker',
        otherUserId: 'new-employer',
        otherUserName: 'New Employer',
      );

      expect(conversation.participantOneId, 'new-seeker');
      expect(conversation.participantTwoId, 'new-employer');
      expect(conversation.participantOneName, 'New Seeker');
      expect(conversation.participantTwoName, 'New Employer');
      expect(
        await repository.getConversations('new-seeker'),
        contains(conversation),
      );
    });

    test('reuses an existing conversation for the same participants', () async {
      final first = await repository.getOrCreateConversation(
        currentUserId: 'user-1',
        currentUserName: 'Job Seeker',
        otherUserId: 'user-2',
        otherUserName: 'Employer',
      );
      final second = await repository.getOrCreateConversation(
        currentUserId: 'user-2',
        currentUserName: 'Employer',
        otherUserId: 'user-1',
        otherUserName: 'Job Seeker',
      );

      expect(second.id, first.id);
      expect(await repository.getConversations('user-1'), hasLength(1));
    });

    test('rejects a conversation with the same participant twice', () async {
      expect(
        () => repository.getOrCreateConversation(
          currentUserId: 'user-1',
          currentUserName: 'Job Seeker',
          otherUserId: 'user-1',
          otherUserName: 'Job Seeker',
        ),
        throwsArgumentError,
      );
    });

    test('loads conversations belonging to a user', () async {
      final conversations = await repository.getConversations('user-1');

      expect(conversations, hasLength(1));
      expect(conversations.first.id, 'conversation-1');
    });

    test('loads messages in chronological order', () async {
      final messages = await repository.getMessages('conversation-1');

      expect(messages, hasLength(2));
      expect(messages.first.id, 'message-1');
    });

    test('sends a new message successfully', () async {
      final message = createMessage(
        id: 'message-3',
        content: 'Thank you!',
      );

      await repository.sendMessage(message);

      final messages = await repository.getMessages('conversation-1');

      expect(messages, hasLength(3));
      expect(messages.last.content, 'Thank you!');
    });

    test('rejects an empty message', () async {
      final message = createMessage(content: '   ');

      expect(
        () => repository.sendMessage(message),
        throwsArgumentError,
      );
    });

    test('marks received messages as read', () async {
      await repository.markMessagesAsRead(
        'conversation-1',
        'user-1',
      );

      final messages = await repository.getMessages('conversation-1');

      final receivedMessages =
          messages.where((message) => message.receiverId == 'user-1');

      expect(receivedMessages.every((message) => message.isRead), isTrue);
    });

    test('counts unread messages for a user', () async {
      final count = await repository.getUnreadMessageCount('user-2');

      expect(count, 1);
    });
  });
}
