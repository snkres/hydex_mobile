import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  init() async {
    if (Platform.isIOS) {
      await _messaging.requestPermission();
      final token = await getToken();
      log("Token $token");
      return;
    }

    await _messaging.requestPermission();
    final token = await getToken();
    log("Token $token");
  }

  Future<String?> getToken() async {
    return _messaging.getToken();
  }
}
