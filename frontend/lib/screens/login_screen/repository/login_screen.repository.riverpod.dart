import 'dart:convert';

import 'package:frontend/data/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'login_screen.repository.riverpod.g.dart';

@riverpod
class LoginScreenRepository extends _$LoginScreenRepository {
  @override
  Future<void> build() async {
    return;
  }

  Future<bool> login(String username) async {
    state = const AsyncLoading();

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.httpUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username}),
      );

      if (response.statusCode == 200) {
        state = const AsyncData(null);
        return true;
      } else {
        final error = json.decode(response.body)['error'];
        state = AsyncError(error ?? 'Login failed', StackTrace.current);
        return false;
      }
    } catch (e, stackTrace) {
      state = AsyncError('Connection error: $e', stackTrace);
      return false;
    }
  }
}
