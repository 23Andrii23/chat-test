import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/main_screen/models/chat_message_model.dart';
import 'package:frontend/service/websocket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen.repository.g.dart';
part 'main_screen.repository.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    @Default([]) List<ChatMessage> messages,
    @Default('') String error,
  }) = _MainScreenState;
}

@riverpod
class MainScreenRepository extends _$MainScreenRepository {
  WebSocketService? _websocketService;

  @override
  FutureOr<MainScreenState> build(String username) {
    _setupWebSocket(username);

    ref.onDispose(() {
      _websocketService?.dispose();
    });

    return const MainScreenState();
  }

  void _setupWebSocket(String username) {
    state = const AsyncLoading();

    try {
      _websocketService = WebSocketService();

      _websocketService!.onMessage = (message) {
        try {
          final data = json.decode(message);
          final newMessage = ChatMessage.fromJson(data, username);
          state.whenData((currentState) {
            state = AsyncData(currentState.copyWith(
              messages: [...currentState.messages, newMessage],
            ));
          });
        } catch (e) {
          debugPrint('Error processing message: $e');
        }
      };

      _websocketService!.onError = (error) {
        state = AsyncError('Connection lost: $error', StackTrace.current);
      };

      _websocketService!.onDone = () {
        state = AsyncError('Connection closed', StackTrace.current);
      };

      _websocketService!.connect(username);
      state = const AsyncData(MainScreenState());
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  void sendMessage(String message) {
    if (message.isEmpty) return;

    final messageData = {
      'type': 'message',
      'sender': username,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    };

    try {
      _websocketService?.send(json.encode(messageData));
    } catch (e) {
      state = AsyncError('Failed to send message: $e', StackTrace.current);
    }
  }

  void disconnect() {
    _websocketService?.disconnect();
    _websocketService = null;
  }
}
