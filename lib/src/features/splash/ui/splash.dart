import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:lottie/lottie.dart';

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
  // Returns the destination path to navigate to
  Future<String> _checkUserStatusAndAuth() async {
    try {
      // Check if we have an access token
      final accessToken = await DioHelper.getAccessToken();

      if (accessToken == null) {
        // No token, redirect to onboarding
        return "/boarding";
      }

      // We have a token, try to fetch current user
      try {
        final currentUser = await ref.read(currentUserProvider.future);

        if (currentUser == null) {
          // User data is null, token might be invalid
          await DioHelper.clearTokens();
          return "/boarding";
        }

        final isActive = currentUser.status == UserStatus.active;

        // Send FCM notification in background (don't await)
        ref.read(authServiceProvider).sendFCMNotification().catchError((e) {
          if (kDebugMode) {
            print('⚠️ FCM notification failed: $e');
          }
        });

        if (!isActive) {
          return "/waitlist";
        } else {
          return "/";
        }
      } on UnauthorizedException catch (e) {
        // Token is invalid or expired
        if (kDebugMode) {
          print('🚫 Unauthorized: $e');
        }
        await DioHelper.clearTokens();
        return "/boarding";
      } on TokenExpiredException catch (e) {
        // Token refresh failed
        if (kDebugMode) {
          print('🚫 Token expired: $e');
        }
        await DioHelper.clearTokens();
        return "/boarding";
      } catch (e) {
        // Any other error during user fetch (network, server, etc.)
        if (kDebugMode) {
          print('❌ Error fetching user: $e');
        }
        if (e is ApiException && e.statusCode == 401) {
          await DioHelper.clearTokens();
          return "/boarding";
        }
        // For other errors, still try to go to boarding as fallback
        return "/boarding";
      }
    } catch (e) {
      // Error checking token
      if (kDebugMode) {
        print('❌ Error in auth check: $e');
      }
      return "/boarding";
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

          // Start all checks in parallel during the animation
          Future<String> authCheckFuture = _checkUserStatusAndAuth();

          // Start animation and wait for it to complete
          _lottieController.forward().whenComplete(() async {
            if (!context.mounted) return;

            try {
              // Get the auth check result (should be ready by now)
              final destination = await authCheckFuture;

              if (!context.mounted) return;
              context.go(destination);
            } catch (e) {
              // If any error occurs, fallback to boarding
              if (kDebugMode) {
                print('❌ Error during splash navigation: $e');
              }
              if (!context.mounted) return;
              context.go("/boarding");
            }
          });
        },
      ),
    );
  }
}
