import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart' as app_providers;
import '../../../../core/router/route_names.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../jobs/presentation/providers/job_provider.dart';
import '../providers/message_provider.dart';

class StartConversationScreen extends ConsumerStatefulWidget {
  const StartConversationScreen({
    required this.jobId,
    super.key,
  });

  final String jobId;

  @override
  ConsumerState<StartConversationScreen> createState() =>
      _StartConversationScreenState();
}

class _StartConversationScreenState
    extends ConsumerState<StartConversationScreen> {
  Object? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startConversation();
    });
  }

  Future<void> _startConversation() async {
    setState(() {
      _error = null;
    });

    try {
      final job = await ref.read(jobByIdProvider(widget.jobId).future);
      if (job == null) {
        throw StateError('Job not found.');
      }

      final currentUserId = ref.read(app_providers.currentUserIdProvider);
      if (currentUserId == null) {
        throw StateError('Sign in before messaging an employer.');
      }

      final currentUser = ref.read(currentUserProvider);
      final conversation =
          await ref.read(messageActionsProvider).getOrCreateConversation(
                currentUserId: currentUserId,
                currentUserName: currentUser?.fullName ?? 'Job Seeker',
                otherUserId: job.employerId,
                otherUserName: job.companyName,
              );

      if (!mounted) return;

      ref.invalidate(conversationsProvider(currentUserId));
      context.replace(RouteNames.chatPath(conversation.id));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Starting conversation')),
      body: Center(
        child: _error == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Could not start conversation: $_error',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _startConversation,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
