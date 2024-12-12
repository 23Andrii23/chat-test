import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String username;
  const MainScreen({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(child: Text(username)),
    );
  }
}
