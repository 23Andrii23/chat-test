import 'package:flutter/material.dart';
import 'package:frontend/screens/main_screen/models/chat_message_model.dart';
import 'package:frontend/screens/main_screen/widgets/message_bubble.dart';
import 'package:frontend/screens/main_screen/widgets/message_input.dart';

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
