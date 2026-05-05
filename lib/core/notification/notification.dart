import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null) {
        return;
      }
      log("APNS Token: $apnsToken");
    }

    final token = await getToken();
    log("FCM Token: $token");
  }

  Future<String?> getToken() async {
    return _messaging.getToken();
  }
}
