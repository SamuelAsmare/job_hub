import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/conversation.dart';
import '../../domain/models/message.dart';
import '../providers/message_provider.dart';
import '../../data/datasources/message_socket_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    required this.conversation,
    required this.currentUserId,
    super.key,
  });

  final Conversation conversation;
  final String currentUserId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isSending = false;

  String get _otherParticipantName {
    final conversation = widget.conversation;

    return conversation.participantOneId == widget.currentUserId
        ? conversation.participantTwoName
        : conversation.participantOneName;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markMessagesAsRead();
    });
  }

  Future<void> _markMessagesAsRead() async {
    final repository = ref.read(messageActionsProvider);

    try {
      await repository.markMessagesAsRead(
        widget.conversation.id,
        widget.currentUserId,
      );

      if (!mounted) return;

      ref.invalidate(
        conversationMessagesProvider(widget.conversation.id),
      );
      ref.invalidate(
        unreadMessageCountProvider(widget.currentUserId),
      );
    } catch (_) {
      // Keep the chat available if marking messages as read fails.
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();

    if (content.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    final isParticipantOne =
        widget.conversation.participantOneId == widget.currentUserId;

    final receiverId = isParticipantOne
        ? widget.conversation.participantTwoId
        : widget.conversation.participantOneId;

    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      conversationId: widget.conversation.id,
      senderId: widget.currentUserId,
      receiverId: receiverId,
      content: content,
      sentAt: DateTime.now(),
    );

    try {
      await ref.read(messageActionsProvider).sendMessage(message);

      if (!mounted) return;

      _messageController.clear();

      ref.invalidate(
        conversationMessagesProvider(widget.conversation.id),
      );
      ref.invalidate(
        conversationsProvider(widget.currentUserId),
      );

      await ref.read(
        conversationMessagesProvider(widget.conversation.id).future,
      );

      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not send message: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(
      conversationMessagesProvider(widget.conversation.id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_otherParticipantName),
      ),
      body: Column(
        children: [
          const _ConnectionStatus(),
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load messages.'),
                    TextButton(
                      onPressed: () {
                        ref.invalidate(
                          conversationMessagesProvider(
                            widget.conversation.id,
                          ),
                        );
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Text('Start your conversation.'),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    return _MessageBubble(
                      message: message,
                      isMine: message.senderId == widget.currentUserId,
                    );
                  },
                );
              },
            ),
          ),
          _MessageInput(
            controller: _messageController,
            isSending: _isSending,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _ConnectionStatus extends ConsumerWidget {
  const _ConnectionStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionAsync = ref.watch(socketConnectionStateProvider);
    final theme = Theme.of(context);

    final state = connectionAsync.when(
      data: (state) => state,
      loading: () => SocketConnectionState.disconnected,
      error: (error, stackTrace) => SocketConnectionState.error,
    );

    final (label, color, icon) = switch (state) {
      SocketConnectionState.connecting => (
          'Connecting...',
          Colors.orange,
          Icons.sync,
        ),
      SocketConnectionState.connected => (
          'Connected',
          Colors.green,
          Icons.wifi,
        ),
      SocketConnectionState.disconnected => (
          'Not connected',
          Colors.grey,
          Icons.wifi_off,
        ),
      SocketConnectionState.error => (
          'Connection error',
          theme.colorScheme.error,
          Icons.error_outline,
        ),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: color.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isMine,
  });

  final Message message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = isMine
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;

    final foregroundColor =
        isMine ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.content,
                style: TextStyle(color: foregroundColor),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _formatTime(message.sentAt),
              style: TextStyle(
                color: foregroundColor.withValues(alpha: 0.75),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) {
                  if (!isSending) onSend();
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: isSending ? null : onSend,
              icon: isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
