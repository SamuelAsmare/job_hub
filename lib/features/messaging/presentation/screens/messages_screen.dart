import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../domain/models/conversation.dart';
import '../providers/message_provider.dart';

class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: false,
      ),
      body: conversationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              const Text('Could not load conversations.'),
              TextButton(
                onPressed: () {
                  ref.invalidate(conversationsProvider(userId));
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
        data: (conversations) {
          if (conversations.isEmpty) {
            return const _EmptyMessagesState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(conversationsProvider(userId));
              await ref.read(conversationsProvider(userId).future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: conversations.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 76,
              ),
              itemBuilder: (context, index) {
                return _ConversationTile(
                  conversation: conversations[index],
                  currentUserId: userId,
                  onTap: () {
                    context.push(RouteNames.chatPath(conversations[index].id));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.conversation,
    required this.currentUserId,
    required this.onTap,
  });

  final Conversation conversation;
  final String currentUserId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isParticipantOne = conversation.participantOneId == currentUserId;

    final participantName = isParticipantOne
        ? conversation.participantTwoName
        : conversation.participantOneName;

    final participantPhoto = isParticipantOne
        ? conversation.participantTwoPhoto
        : conversation.participantOnePhoto;

    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            participantPhoto != null ? NetworkImage(participantPhoto) : null,
        child: participantPhoto == null
            ? Text(
                participantName.isNotEmpty
                    ? participantName[0].toUpperCase()
                    : '?',
              )
            : null,
      ),
      title: Text(
        participantName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          conversation.lastMessage ?? 'Start a conversation',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (conversation.lastMessageAt != null)
            Text(
              _formatTime(conversation.lastMessageAt!),
              style: theme.textTheme.bodySmall,
            ),
          const SizedBox(height: 6),
          if (conversation.unreadCount > 0)
            CircleAvatar(
              radius: 11,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                conversation.unreadCount > 99
                    ? '99+'
                    : '${conversation.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    }

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

class _EmptyMessagesState extends StatelessWidget {
  const _EmptyMessagesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your conversations with employers and job seekers '
              'will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
