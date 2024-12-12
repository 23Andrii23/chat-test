import 'package:frontend/data/app_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  Function(dynamic)? onMessage;
  Function(dynamic)? onError;
  Function()? onDone;

  bool get isConnected => _channel != null;

  void connect(String username) {
    try {
      final wsUri = Uri.parse(AppConfig.wsUrl)
          .replace(queryParameters: {'username': username});

      _channel = WebSocketChannel.connect(wsUri);

      _channel!.stream.listen(
        (message) {
          if (onMessage != null) onMessage!(message);
        },
        onError: (error) {
          if (onError != null) onError!(error);
        },
        onDone: () {
          _channel = null;
          if (onDone != null) onDone!();
        },
      );
    } catch (e) {
      if (onError != null) onError!(e);
    }
  }

  void send(dynamic message) {
    _channel?.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    disconnect();
    onMessage = null;
    onError = null;
    onDone = null;
  }
}
