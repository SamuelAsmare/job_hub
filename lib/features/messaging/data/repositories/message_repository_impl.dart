import '../../domain/models/conversation.dart';
import '../../domain/models/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_local_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl(this._dataSource);

  final MessageLocalDataSource _dataSource;

  @override
  Future<Conversation> getOrCreateConversation({
    required String currentUserId,
    required String currentUserName,
    required String otherUserId,
    required String otherUserName,
  }) {
    return _dataSource.getOrCreateConversation(
      currentUserId: currentUserId,
      currentUserName: currentUserName,
      otherUserId: otherUserId,
      otherUserName: otherUserName,
    );
  }

  @override
  Future<List<Conversation>> getConversations(String userId) {
    return _dataSource.getConversations(userId);
  }

  @override
  Future<List<Message>> getMessages(String conversationId) {
    return _dataSource.getMessages(conversationId);
  }

  @override
  Future<void> sendMessage(Message message) async {
    if (message.content.trim().isEmpty) {
      throw ArgumentError('Message content cannot be empty.');
    }

    await _dataSource.sendMessage(message);
  }

  @override
  Future<void> markMessagesAsRead(
    String conversationId,
    String userId,
  ) {
    return _dataSource.markMessagesAsRead(conversationId, userId);
  }

  @override
  Future<int> getUnreadMessageCount(String userId) {
    return _dataSource.getUnreadMessageCount(userId);
  }
}
