import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String userName;
  const Avatar({required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[300],
      ),
      child: Center(
        child: Text(
          userName[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
