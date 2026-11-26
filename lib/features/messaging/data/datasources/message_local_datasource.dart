
import '../../domain/models/conversation.dart';
import '../../domain/models/message.dart';

class MessageLocalDataSource {
  MessageLocalDataSource({
    List<Conversation>? initialConversations,
    List<Message>? initialMessages,
  })  : _conversations = List.of(initialConversations ?? []),
        _messages = List.of(initialMessages ?? []);

  final List<Conversation> _conversations;
  final List<Message> _messages;

  Future<List<Conversation>> getConversations(String userId) async {
    final conversations = _conversations
        .where(
          (conversation) =>
              conversation.participantOneId == userId ||
              conversation.participantTwoId == userId,
        )
        .toList();

    conversations.sort((a, b) {
      final aDate = a.lastMessageAt ?? DateTime(2000);
      final bDate = b.lastMessageAt ?? DateTime(2000);
      return bDate.compareTo(aDate);
    });

    return List.unmodifiable(conversations);
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final messages = _messages
        .where((message) => message.conversationId == conversationId)
        .toList()
      ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

    return List.unmodifiable(messages);
  }

  Future<void> sendMessage(Message message) async {
    _messages.add(message);

    final index = _conversations.indexWhere(
      (conversation) => conversation.id == message.conversationId,
    );

    if (index == -1) return;

    _conversations[index] = _conversations[index].copyWith(
      lastMessage: message.content,
      lastMessageAt: message.sentAt,
    );
  }

  Future<void> markMessagesAsRead(
    String conversationId,
    String userId,
  ) async {
    for (var i = 0; i < _messages.length; i++) {
      final message = _messages[i];

      if (message.conversationId == conversationId &&
          message.receiverId == userId &&
          !message.isRead) {
        _messages[i] = message.copyWith(isRead: true);
      }
    }
  }

  Future<int> getUnreadMessageCount(String userId) async {
    return _messages
        .where(
          (message) => message.receiverId == userId && !message.isRead,
        )
        .length;
  }
}
