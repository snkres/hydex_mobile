import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/cache/cache_helper.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/notification/notification.dart';
import 'package:hydex/firebase_options.dart';
import 'package:hydex/src/app.dart' show MyApp;
import 'package:device_preview/device_preview.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  await CacheHelper.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://32c622c74f363e4bb9e092dd8263ad6b@o4510022729269248.ingest.de.sentry.io/4510022730711120';
      // Adds request headers and IP for users,
      // visit: https://docs.sentry.io/platforms/dart/data-management/data-collected/ for more info
      options.sendDefaultPii = true;
    },
    appRunner: () => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) {
          return ProviderScope(child: const MyApp());
        },
      ),
    ),
  );
  AuthService.initialize();
  if (!Platform.isLinux) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await FirebaseNotifications().init();
}
