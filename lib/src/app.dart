import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/routes/routes.dart';
import 'package:hydex/core/ui/theme.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(offlineSyncListenerProvider);
    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
    );
  }
}
