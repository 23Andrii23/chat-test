import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/data/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize();
  runApp(const App());
}
