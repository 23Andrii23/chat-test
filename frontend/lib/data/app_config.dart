import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class AppConfig {
  static late String baseUrl;
  static late String wsUrl;
  static late String httpUrl;

  static void initialize() {
    if (kIsWeb) {
      baseUrl = 'localhost';
      wsUrl = 'wss://$baseUrl:8080';
      httpUrl = 'http://$baseUrl:8080';
    } else {
      if (Platform.isAndroid) {
        baseUrl = '10.0.2.2';
      } else {
        baseUrl = 'localhost';
      }
      wsUrl = 'ws://$baseUrl:8080';
      httpUrl = 'http://$baseUrl:8080';
    }
  }
}
