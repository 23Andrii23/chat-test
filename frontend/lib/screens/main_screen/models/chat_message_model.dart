enum MessageType { user, system }

class ChatMessage {
  final String sender;
  final String message;
  final bool isMe;
  final DateTime timestamp;
  final MessageType type;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.isMe,
    required this.timestamp,
    this.type = MessageType.user,
  });

  factory ChatMessage.fromJson(
      Map<String, dynamic> json, String currentUsername) {
    return ChatMessage(
      sender: json['sender'],
      message: json['message'],
      isMe: json['sender'] == currentUsername,
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'] == 'system' ? MessageType.system : MessageType.user,
    );
  }
}
