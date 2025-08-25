import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/auth/seeker.dart';
import 'package:hydex/src/features/auth/ui/boarding.dart';
import 'package:hydex/src/features/auth/ui/create_pass.dart';
import 'package:hydex/src/features/auth/ui/describe.dart';
import 'package:hydex/src/features/auth/ui/influencer.dart';
import 'package:hydex/src/features/auth/ui/login.dart';
import 'package:hydex/src/features/auth/ui/nationality.dart';
import 'package:hydex/src/features/auth/ui/otp.dart';
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
    //     '/password',
    //     '/tellus',
    //     '/nationality',
    //     '/describe',
    //     '/seeker',
    //     '/wego',
    //     '/influencer',
    //     '/ulike',
    //   };

    //   final token = await DioHelper.getAccessToken();
    //   final bool isAuthenticated = token != null;
    //   final String currentPath = state.uri.path;

    //   final bool isGoingToPublicRoute = publicRoutes.contains(currentPath);

    //   if (!isAuthenticated && !isGoingToPublicRoute) {
    //     return '/';
    //   }
    //   if (isAuthenticated && isGoingToPublicRoute) {
    //     return '/waitlist';
    //   }
    //   return null;
    // },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const BoardingScreen(),
        routes: [
          GoRoute(path: "otp", builder: (context, state) => const OtpScreen()),
          GoRoute(
            path: "password",
            builder: (context, state) => const CreatePassword(),
          ),
          GoRoute(path: "tellus", builder: (context, state) => const Tellus()),
          GoRoute(
            path: "nationality",
            builder: (context, state) => const NationalityTellUs(),
          ),
          GoRoute(
            path: "describe",
            builder: (context, state) => const Describe(),
          ),
          GoRoute(
            path: "seeker",
            builder: (context, state) => const SeekerScreen(),
          ),
          GoRoute(
            path: "wego",
            builder: (context, state) => const WhereWeGOScreen(),
          ),
          GoRoute(
            path: "influencer",
            builder: (context, state) => const InfluencerScreen(),
          ),
        ],
      ),
      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
      ),
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];

          return SizedBox.shrink();
        },
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
