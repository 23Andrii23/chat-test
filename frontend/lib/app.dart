import 'package:flutter/material.dart';

import 'screens/login_screen/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.blue[300],
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
