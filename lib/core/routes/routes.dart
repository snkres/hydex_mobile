import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/cache/cache_helper.dart';
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
    initialLocation: '/',
    redirect: (context, state) async {
      final waitlist = CacheHelper.getBool("waitlist") ?? false;
      if (waitlist) {
        return "/waitlist";
      }
      return null;
    },
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

  // ALTERNATIVE APPROACH: More granular control with route-specific redirects
  final routesAlternative = GoRouter(
    initialLocation: '/',
    routes: [
      // Main boarding screen
      GoRoute(path: "/", builder: (context, state) => const BoardingScreen()),

      // Auth routes (no redirect)
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(path: "/otp", builder: (context, state) => const OtpScreen()),
      GoRoute(
        path: "/otp/email",
        builder: (context, state) => const OtpEmailScreen(),
      ),

      // Registration flow routes with conditional redirect
      GoRoute(
        path: "/verify_email",
        redirect: (context, state) async {
          final token = await DioHelper.getAccessToken();
          final waitlist = CacheHelper.getBool("waitlist") ?? false;

          if (waitlist && token != null) {
            return '/waitlist';
          }
          return null;
        },
        builder: (context, state) => const VerifyEmailScreen(),
      ),

      GoRoute(
        path: "/password",
        redirect: (context, state) async {
          final token = await DioHelper.getAccessToken();
          final waitlist = CacheHelper.getBool("waitlist") ?? false;

          if (waitlist && token != null) {
            return '/waitlist';
          }
          return null;
        },
        builder: (context, state) => const CreatePassword(),
      ),

      // Apply same pattern to other registration routes...
      GoRoute(
        path: "/tellus",
        redirect: (context, state) async {
          final token = await DioHelper.getAccessToken();
          final waitlist = CacheHelper.getBool("waitlist") ?? false;

          if (waitlist && token != null) {
            return '/waitlist';
          }
          return null;
        },
        builder: (context, state) => const Tellus(),
      ),

      // Continue with other routes...
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

      // Other auth routes
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

  // BEST APPROACH: Using route groups for cleaner organization
  final routesBestApproach = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final token = await DioHelper.getAccessToken();
      final waitlist = CacheHelper.getBool("waitlist") ?? false;
      final currentPath = state.uri.path;

      // Don't redirect if already on target route
      if (currentPath == '/waitlist') return null;

      // Define which routes are always accessible
      final publicRoutes = {
        '/',
        '/login',
        '/otp',
        '/otp/email',
        '/forget-password',
        '/forgot-password',
        '/forgot-response',
        '/terms',
      };

      // If on waitlist with token, redirect to waitlist unless on public route
      if (waitlist && token != null && !publicRoutes.contains(currentPath)) {
        return '/waitlist';
      }

      // If on waitlist without token, only allow public routes
      if (waitlist && token == null && !publicRoutes.contains(currentPath)) {
        return '/';
      }

      return null;
    },
    routes: [
      // Public routes (always accessible)
      GoRoute(path: "/", builder: (context, state) => const BoardingScreen()),
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: "/terms",
        builder: (context, state) => const TermsAndConditions(),
      ),

      // Auth flow routes
      GoRoute(path: "/otp", builder: (context, state) => const OtpScreen()),
      GoRoute(
        path: "/otp/email",
        builder: (context, state) => const OtpEmailScreen(),
      ),
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

      // Registration flow (protected by redirect)
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
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
