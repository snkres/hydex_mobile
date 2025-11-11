import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    if (kReleaseMode) {
      ref.read(authServiceProvider).sendFCMNotification();

      final user = await ref.read(currentUserProvider.future);
      final status = user?.status;

      if (status != null && status == UserStatus.active) {
        if (mounted) context.go("/");
      } else {
        if (mounted) context.go("/waitlist");
      }
    } else {
      ref.read(authServiceProvider).sendFCMNotification();

      context.go("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
  }
}
