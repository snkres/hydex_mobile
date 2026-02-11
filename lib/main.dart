
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/cache/cache_helper.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/notification/notification.dart';
import 'package:hydex/firebase_options.dart';
import 'package:hydex/src/app.dart' show MyApp;
import 'package:device_preview/device_preview.dart';
import 'package:lottie/lottie.dart' show AssetLottie;
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await AssetLottie('json/splash.json', package: "assets").load();
  await AuthService.initialize();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await (FirebaseNotifications().init());
  } catch (e) {}

  if (kDebugMode) {
    runApp(
      DevicePreview(
        builder: (context) {
          return ProviderScope(child: const MyApp());
        },
      ),
    );
  } else {
    await SentryFlutter.init((options) {
      options.dsn =
          'https://fa54dbd5e75020b3a743a3b127cdccb9@o4510173263036416.ingest.de.sentry.io/4510181346705488';
      options.sendDefaultPii = true;
    }, appRunner: () => runApp(ProviderScope(child: const MyApp())));
  }
}
