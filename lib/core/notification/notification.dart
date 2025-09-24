import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    if (Platform.isIOS) {
      // Ensure iOS is registered for APNS
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null) {
        log("APNS token is not available yet. iOS may still be registering.");
        return;
      }
      log("APNS Token: $apnsToken");
    }

    // Get FCM token (works on both iOS & Android)
    final token = await getToken();
    log("FCM Token: $token");
  }

  Future<String?> getToken() async {
    return _messaging.getToken();
  }

}
