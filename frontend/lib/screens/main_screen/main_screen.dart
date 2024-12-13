import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/login_screen/login_screen.dart';
import 'package:frontend/screens/main_screen/repository/main_screen.repository.dart';
import 'package:frontend/screens/main_screen/widgets/chat_view.dart';

class MainScreen extends ConsumerStatefulWidget {
  final String username;
  const MainScreen({required this.username, super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
    final chatProvider =
        ref.watch(mainScreenRepositoryProvider(widget.username));

    ref.listen(mainScreenRepositoryProvider(widget.username), (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
        data: (data) {
          if (data.messages.isNotEmpty) {
            _scrollToBottom();
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ref
                  .read(mainScreenRepositoryProvider(widget.username).notifier)
                  .disconnect();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: chatProvider.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
        data: (chatState) => ChatView(
          messages: chatState.messages,
          messageController: _messageController,
          scrollController: _scrollController,
          onSendMessage: (message) {
            ref
                .read(mainScreenRepositoryProvider(widget.username).notifier)
                .sendMessage(message);
          },
        ),
      ),
    );
  }
}
