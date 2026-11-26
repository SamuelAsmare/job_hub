import '../models/conversation.dart';
import '../models/message.dart';

abstract interface class MessageRepository {
  Future<List<Conversation>> getConversations(String userId);

  Future<List<Message>> getMessages(String conversationId);

  Future<void> sendMessage(Message message);

  Future<void> markMessagesAsRead(
    String conversationId,
    String userId,
  );

  Future<int> getUnreadMessageCount(String userId);
}