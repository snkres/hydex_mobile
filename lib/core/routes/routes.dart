import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/boarding/seeker.dart';
import 'package:hydex/src/features/boarding/ui/boarding.dart';
import 'package:hydex/src/features/boarding/ui/create_pass.dart';
import 'package:hydex/src/features/boarding/ui/describe.dart';
import 'package:hydex/src/features/boarding/ui/influencer.dart';
import 'package:hydex/src/features/boarding/ui/nationality.dart';
import 'package:hydex/src/features/boarding/ui/otp.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
import 'package:hydex/src/features/boarding/ui/ugo.dart';
import 'package:hydex/src/features/boarding/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);
  final routes = GoRouter(
    redirect: (context, state) async {
      // Define the set of public routes that don't require authentication.
      const Set<String> publicRoutes = {
        '/',
        '/otp',
        '/password',
        '/tellus',
        '/nationality',
        '/describe',
        '/seeker',
        '/wego',
        '/influencer',
        '/ulike',
      };

      final token = await DioHelper.getAccessToken();
      final bool isAuthenticated = token != null;
      final String currentPath = state.uri.path;

      // Check if the path the user is trying to access is a public route.
      final bool isGoingToPublicRoute = publicRoutes.contains(currentPath);

      // If the user is NOT authenticated and trying to access a PROTECTED route,
      // redirect them to the root (boarding screen).
      if (!isAuthenticated && !isGoingToPublicRoute) {
        return '/';
      }

      // If the user IS authenticated and trying to access a PUBLIC route,
      // redirect them to their main screen (e.g., '/waitlist').
      // This prevents logged-in users from seeing the login/signup flow again.
      if (isAuthenticated && isGoingToPublicRoute) {
        return '/waitlist';
      }

      // In all other cases, no redirect is needed:
      // - User is authenticated and accessing a protected route.
      // - User is not authenticated and accessing a public route.
      return null;
    },
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
          GoRoute(path: "ulike", builder: (context, state) => const Describe()),
        ],
      ),
      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
