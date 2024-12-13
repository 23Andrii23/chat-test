import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback onSend;

  const LoginInput({
    required this.textEditingController,
    required this.onSend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (_) => onSend(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        if (value.length < 3) {
          return 'Username must be at least 3 characters long';
        }
        if (value.length > 20) {
          return 'Username must be less than 20 characters';
        }
        if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
          return 'Username can only contain letters, numbers and underscore';
        }
        return null;
      },
    );
  }
}
