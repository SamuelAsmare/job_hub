import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/message_local_datasource.dart';
import '../../data/repositories/message_repository_impl.dart';
import '../../domain/models/conversation.dart';
import '../../domain/models/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../../data/datasources/message_socket_service.dart';

final messageLocalDataSourceProvider = Provider<MessageLocalDataSource>((ref) {
  return MessageLocalDataSource();
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final dataSource = ref.watch(messageLocalDataSourceProvider);
  return MessageRepositoryImpl(dataSource);
});

final conversationsProvider =
    FutureProvider.family<List<Conversation>, String>((ref, userId) {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getConversations(userId);
});

final conversationMessagesProvider =
    FutureProvider.family<List<Message>, String>((ref, conversationId) {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getMessages(conversationId);
});

final unreadMessageCountProvider =
    FutureProvider.family<int, String>((ref, userId) {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getUnreadMessageCount(userId);
});

final messageActionsProvider = Provider<MessageActions>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return MessageActions(repository);
});

class MessageActions {
  const MessageActions(this._repository);

  final MessageRepository _repository;

  Future<Conversation> getOrCreateConversation({
    required String currentUserId,
    required String currentUserName,
    required String otherUserId,
    required String otherUserName,
  }) {
    return _repository.getOrCreateConversation(
      currentUserId: currentUserId,
      currentUserName: currentUserName,
      otherUserId: otherUserId,
      otherUserName: otherUserName,
    );
  }

  Future<void> sendMessage(Message message) {
    return _repository.sendMessage(message);
  }

  Future<void> markMessagesAsRead(
    String conversationId,
    String userId,
  ) {
    return _repository.markMessagesAsRead(conversationId, userId);
  }
}

final messageSocketServiceProvider = Provider<MessageSocketService>((ref) {
  final service = MessageSocketService();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

final socketConnectionStateProvider =
    StreamProvider<SocketConnectionState>((ref) {
  final service = ref.watch(messageSocketServiceProvider);

  return service.connectionStateStream;
});
