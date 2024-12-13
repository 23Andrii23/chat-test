// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:frontend/screens/login_screen/login_screen.dart';
// import 'package:frontend/screens/main_screen/models/chat_message_model.dart';
// import 'package:frontend/screens/main_screen/widgets/message_bubble.dart';
// import 'package:frontend/service/websocket_service.dart';
//
// class MainScreen extends StatefulWidget {
//   final String username;
//   const MainScreen({required this.username, super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   // final TextEditingController _messageController = TextEditingController();
//   // final WebSocketService _websocketService = WebSocketService();
//   // final List<ChatMessage> _messages = [];
//   // final ScrollController _scrollController = ScrollController();
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _setupWebSocketListeners();
//   // }
//   //
//   // void _setupWebSocketListeners() {
//   //   _websocketService.onError = (error) {
//   //     setState(() {});
//   //     _showError('Connection lost: $error');
//   //   };
//   //
//   //   _websocketService.onDone = () {
//   //     _showError('Connection closed');
//   //   };
//   //
//   //   _websocketService.onMessage = (message) {
//   //     try {
//   //       final data = json.decode(message);
//   //       setState(() {
//   //         _messages.add(ChatMessage.fromJson(data, widget.username));
//   //       });
//   //     } catch (e) {
//   //       debugPrint('Error processing message: $e');
//   //     } finally {
//   //       _scrollToBottom();
//   //     }
//   //   };
//   //
//   //   _websocketService.connect(widget.username);
//   // }
//   //
//   // void _sendMessage() {
//   //   if (_messageController.text.isEmpty) return;
//   //
//   //   final message = {
//   //     'type': 'message',
//   //     'sender': widget.username,
//   //     'message': _messageController.text,
//   //     'timestamp': DateTime.now().toIso8601String(),
//   //   };
//   //
//   //   try {
//   //     _websocketService.send(json.encode(message));
//   //     _messageController.clear();
//   //   } catch (e) {
//   //     _showError('Failed to send message: $e');
//   //   }
//   // }
//   //
//   // void _showError(String message) {
//   //   if (!mounted) return;
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text(message),
//   //       backgroundColor: Colors.red,
//   //     ),
//   //   );
//   // }
//   //
//   // void _scrollToBottom() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     if (_scrollController.hasClients) {
//   //       _scrollController.animateTo(
//   //         _scrollController.position.maxScrollExtent,
//   //         duration: const Duration(milliseconds: 300),
//   //         curve: Curves.easeOut,
//   //       );
//   //     }
//   //   });
//   // }
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text('Chat', style: TextStyle(color: Colors.white)),
//   //       backgroundColor: Theme.of(context).colorScheme.primary,
//   //       actions: [
//   //         IconButton(
//   //           icon: const Icon(Icons.logout, color: Colors.white),
//   //           onPressed: () {
//   //             _websocketService.disconnect();
//   //             Navigator.of(context).pushReplacement(
//   //               MaterialPageRoute(builder: (context) => LoginScreen()),
//   //             );
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //     body: SafeArea(
//   //       child: Column(
//   //         children: [
//   //           Expanded(
//   //             child: ListView.builder(
//   //               controller: _scrollController,
//   //               padding: const EdgeInsets.all(8),
//   //               itemCount: _messages.length,
//   //               itemBuilder: (context, index) {
//   //                 final message = _messages[index];
//   //                 return MessageBubble(message: message);
//   //               },
//   //             ),
//   //           ),
//   //           Container(
//   //             padding: const EdgeInsets.all(8),
//   //             decoration: BoxDecoration(
//   //               color: Theme.of(context).cardColor,
//   //               boxShadow: [
//   //                 BoxShadow(
//   //                   offset: const Offset(0, -2),
//   //                   blurRadius: 4,
//   //                   color: Colors.black.withOpacity(0.1),
//   //                 ),
//   //               ],
//   //             ),
//   //             child: Row(
//   //               children: [
//   //                 Expanded(
//   //                   child: TextField(
//   //                     controller: _messageController,
//   //                     decoration: InputDecoration(
//   //                       hintText: 'Type a message',
//   //                       border: OutlineInputBorder(
//   //                         borderRadius: BorderRadius.circular(16),
//   //                       ),
//   //                       contentPadding: const EdgeInsets.symmetric(
//   //                         horizontal: 16,
//   //                         vertical: 8,
//   //                       ),
//   //                     ),
//   //                     maxLines: null,
//   //                     textCapitalization: TextCapitalization.sentences,
//   //                     onSubmitted: (_) => _sendMessage(),
//   //                   ),
//   //                 ),
//   //                 const SizedBox(width: 8),
//   //                 IconButton(
//   //                   icon: const Icon(Icons.send),
//   //                   onPressed: _sendMessage,
//   //                   color: Theme.of(context).primaryColor,
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // @override
//   // void dispose() {
//   //   _websocketService.dispose();
//   //   _messageController.dispose();
//   //   _scrollController.dispose();
//   //   super.dispose();
//   // }
// }

// lib/screens/chat_screen/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/login_screen/login_screen.dart';
import 'package:frontend/screens/main_screen/models/chat_message_model.dart';
import 'package:frontend/screens/main_screen/repository/main_screen.repository.dart';
import 'package:frontend/screens/main_screen/widgets/message_bubble.dart';
import 'package:frontend/screens/main_screen/widgets/message_input.dart';

class MainScreen extends ConsumerWidget {
  final String username;
  const MainScreen({required this.username, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = TextEditingController();
    final scrollController = ScrollController();

    void scrollToBottom() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    final chatProvider = ref.watch(mainScreenRepositoryProvider(username));

    ref.listen(mainScreenRepositoryProvider(username), (previous, next) {
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
            scrollToBottom();
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
                  .read(mainScreenRepositoryProvider(username).notifier)
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
          messageController: messageController,
          scrollController: scrollController,
          onSendMessage: (message) {
            ref
                .read(mainScreenRepositoryProvider(username).notifier)
                .sendMessage(message);
          },
        ),
      ),
    );
  }
}

// Винесемо UI чату в окремий віджет для кращої організації коду
class ChatView extends StatelessWidget {
  final List<ChatMessage> messages;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final Function(String) onSendMessage;

  const ChatView({
    required this.messages,
    required this.messageController,
    required this.scrollController,
    required this.onSendMessage,
    super.key,
  });

  void _sendMessage() {
    if (messageController.text.isEmpty) return;
    onSendMessage(messageController.text);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          MessageInput(
            controller: messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
