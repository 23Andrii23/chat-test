import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/login_screen/repository/login_screen.repository.riverpod.dart';
import 'package:frontend/screens/login_screen/widgets/login_input.dart';
import 'package:frontend/screens/main_screen/main_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginScreenRepositoryProvider);

    ref.listen(loginScreenRepositoryProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: loginProvider.when(
        data: (_) => Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginInput(
                  textEditingController: _usernameController,
                  onSend: () => _handleLogin(context, ref),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _handleLogin(context, ref),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(180, 48),
                  ),
                  child: const Text('Connect'),
                ),
              ],
            ),
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Connecting...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        error: (_, __) => Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginInput(
                  textEditingController: _usernameController,
                  onSend: () => _handleLogin(context, ref),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _handleLogin(context, ref),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(180, 48),
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final success = await ref
          .read(loginScreenRepositoryProvider.notifier)
          .login(_usernameController.text);

      if (success && context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(
              username: _usernameController.text,
            ),
          ),
        );
      }
    }
  }

  void dispose() {
    _usernameController.dispose();
  }
}
