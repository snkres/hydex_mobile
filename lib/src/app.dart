import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/routes/routes.dart';
import 'package:hydex/core/ui/theme.dart';
import 'package:device_preview/device_preview.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      routerConfig: ref.watch(goRouterProvider),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
    );
  }
}
