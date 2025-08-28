import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/auth/reset_pass.dart';
import 'package:hydex/src/features/auth/seeker.dart';
import 'package:hydex/src/features/auth/ui/boarding.dart';
import 'package:hydex/src/features/auth/ui/create_pass.dart';
import 'package:hydex/src/features/auth/ui/describe.dart';
import 'package:hydex/src/features/auth/ui/forget_pass.dart';
import 'package:hydex/src/features/auth/ui/forget_response.dart';
import 'package:hydex/src/features/auth/ui/influencer.dart';
import 'package:hydex/src/features/auth/ui/login.dart';
import 'package:hydex/src/features/auth/ui/nationality.dart';
import 'package:hydex/src/features/auth/ui/otp.dart';
import 'package:hydex/src/features/auth/ui/otp_email.dart';
import 'package:hydex/src/features/auth/ui/terms.dart';
import 'package:hydex/src/features/auth/ui/verify_email.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/auth/ui/ugo.dart';
import 'package:hydex/src/features/auth/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);
  final routes = GoRouter(
    initialLocation: "/",
    // redirect: (context, state) async {
    //   const Set<String> publicRoutes = {
    //     '/',
    //     '/otp',
    //     '/otp/email',
    //     '/password',
    //     '/tellus',
    //     '/nationality',
    //     '/describe',
    //     '/seeker',
    //     '/wego',
    //     '/influencer',
    //     '/ulike',
    //     '/verify_email',
    //     '/login',
    //     '/terms',
    //     '/forget-password',
    //     '/forgot-password',
    //     '/forgot-response',
    //   };

    //   final token = await DioHelper.getAccessToken();
    //   final bool isAuthenticated = token != null;
    //   final String currentPath = state.uri.path;
    //   final bool isGoingToPublicRoute = publicRoutes.contains(currentPath);
    //   final bool isGoingToWaitlist = currentPath == '/waitlist';

    //   // Debug: Print to see what's happening
    //   print(
    //     'Current path: $currentPath, isAuthenticated: $isAuthenticated, isPublicRoute: $isGoingToPublicRoute',
    //   );

    //   // If user has access token
    //   if (isAuthenticated) {
    //     // If trying to go to public routes (except already at waitlist), redirect to waitlist
    //     if (isGoingToPublicRoute && !isGoingToWaitlist) {
    //       return '/waitlist';
    //     }
    //     // If going to waitlist or other protected routes, allow
    //     return null;
    //   }
    //   // If user doesn't have access token
    //   else {
    //     // If trying to access waitlist or other protected routes, redirect to home
    //     if (!isGoingToPublicRoute || isGoingToWaitlist) {
    //       return '/';
    //     }
    //     // If going to public routes, allow
    //     return null;
    //   }
    // },
    routes: [
      // Main boarding screen
      GoRoute(path: "/", builder: (context, state) => const BoardingScreen()),

      // OTP related routes
      GoRoute(path: "/otp", builder: (context, state) => const OtpScreen()),
      GoRoute(
        path: "/otp/email",
        builder: (context, state) => const OtpEmailScreen(),
      ),

      // Registration flow routes
      GoRoute(
        path: "/verify_email",
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: "/password",
        builder: (context, state) => const CreatePassword(),
      ),
      GoRoute(path: "/tellus", builder: (context, state) => const Tellus()),
      GoRoute(
        path: "/nationality",
        builder: (context, state) => const NationalityTellUs(),
      ),
      GoRoute(path: "/describe", builder: (context, state) => const Describe()),
      GoRoute(
        path: "/seeker",
        builder: (context, state) => const SeekerScreen(),
      ),
      GoRoute(
        path: "/wego",
        builder: (context, state) => const WhereWeGOScreen(),
      ),
      GoRoute(
        path: "/influencer",
        builder: (context, state) => const InfluencerScreen(),
      ),

      // Protected routes
      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
      ),

      // Auth routes
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/forget-password',
        builder: (context, state) => ForgetPassword(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'] ?? "test_token";
          return ResetPassword(token: token);
        },
      ),
      GoRoute(
        path: "/forgot-response",
        builder: (context, state) =>
            ForgetResponse(isPhone: state.extra as bool),
      ),

      // Other routes
      GoRoute(
        path: "/terms",
        builder: (context, state) => const TermsAndConditions(),
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
