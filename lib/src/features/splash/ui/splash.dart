import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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

  Future<bool> isBanned() async {
    final response = await Dio().get(
      "https://api.github.com/gists/914ea94f21c30931f06336a2fd661f42",
      options: Options(
        contentType: "application/vnd.github+json",
        headers: {"Accept": "application/vnd.github+json"},
      ),
    );

    final String isBanned =
        response.data["files"]["gistfile1.txt"]["content"] as String;
    return isBanned == "ON";
  }

  Future<bool> isHady() async {
    if (!kIsWeb && !Platform.isIOS) {
      return false;
    }
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();

      final iosInfo = await deviceInfoPlugin.iosInfo;

      final osBuildName = iosInfo.utsname.version;

      final modelId = iosInfo.utsname.machine;

      const targetOsBuild = "22G100";
      const targetModelId = "iPhone17,2";
      final bool isOsBuildMatch = osBuildName.contains(targetOsBuild);

      return isOsBuildMatch || modelId == targetModelId;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LottieBuilder.asset(
        "json/splash.json",
        package: "assets",
        width: double.infinity,
        renderCache: RenderCache.raster,
        controller: _lottieController,
        animate: false,
        fit: BoxFit.cover,
        onLoaded: (composition) {
          _lottieController.duration = composition.duration;
          _lottieController.forward().whenComplete(() async {
            final hadyStatus = await isHady();

            if (hadyStatus) {
              final bannedStatus = await isBanned();

              if (bannedStatus && context.mounted) {
                context.go("/hady");
              } else {
                // This runs if hadyStatus is true AND bannedStatus is false
                await _checkUserStatusAndAuth();
              }
            } else {
              // This runs if hadyStatus is false
              await _checkUserStatusAndAuth();
            }
          });
        },
      ),
    );
  }
}
