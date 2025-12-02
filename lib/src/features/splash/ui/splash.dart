import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/auth/ui/boarding.dart';
import 'package:hydex/src/features/auth/ui/waitlist.dart';
import 'package:hydex/src/features/loading/ui/loading.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // 1. Define the AnimationController
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  // Handles User Status (release mode logic) and final Authentication
  Future<void> _checkUserStatusAndAuth() async {
    // Use a variable to track the final destination based on all checks
    String destinationPath = "/boarding";

    try {
      // B. Final Authentication Check (Only reached if not redirected to /waitlist)
      final accessToken = await DioHelper.getAccessToken();

      final isAuthenticated = accessToken != null;
      if (isAuthenticated) {
        final currentUser = await ref.read(currentUserProvider.future);
        final isActive = currentUser?.status == UserStatus.active;
        ref.read(authServiceProvider).sendFCMNotification();
        if (!isActive) {
          destinationPath = "/waitlist";
        } else {
          destinationPath = "/";
        }
      } else {
        destinationPath = "/boarding";
      }

      if (!mounted) return;

      context.go(destinationPath);
    } catch (e) {
      if (mounted) context.go("/boarding"); // Fallback to safe screen
    }
  }

  // Renamed and made private
  Future<bool> isHady() async {
    try {
      final response = await Dio().get("https://api.ipify.org?format=json");
      if (response.statusCode == 200) {
        final ip = response.data["ip"];
        return ip == "196.153.169.31";
      }
    } catch (_) {}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LottieBuilder.asset(
        "json/splash.json",
        package: "assets",
        width: double.infinity,
        renderCache: RenderCache.raster,
        // 3. Assign the controller to the LottieBuilder
        controller: _lottieController,
        // Set repeat to false since we are listening for one cycle
        animate: false,
        fit: BoxFit.cover,
        // 4. Use onLoaded to ensure we have the animation duration
        onLoaded: (composition) {
          // Set the controller duration to the animation's intrinsic duration
          _lottieController.duration = composition.duration;
          // Start the animation immediately
          _lottieController.forward().whenComplete(() async {
            if (await isHady() && context.mounted) {
              context.go("/hady");
            } else {
              await _checkUserStatusAndAuth();
            }
          });
        },
      ),
    );
  }
}
