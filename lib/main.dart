import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/firebase_options.dart';
import 'package:hydex/src/app.dart' show MyApp;
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isLinux) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return ProviderScope(child: const MyApp());
      },
    ),
  );
  AuthService.initialize();
}
