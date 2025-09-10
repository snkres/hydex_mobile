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
import 'package:hydex/src/features/vibes/ui/details_screen.dart';
import 'package:hydex/src/features/waitlist/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);
  final routes = GoRouter(
    initialLocation: '/waitlist',
    redirect: (context, state) async {
      final isAuthenticated = await DioHelper.getAccessToken() != null;
      final currentRoute = state.uri.path;
      if (isAuthenticated) {
        if (currentRoute != "/boarding") {
          return null;
        }
        return "/";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => BaseScreen(initialTab: state.extra as int?),
      ),
      GoRoute(
        path: "/boarding",
        builder: (context, state) => const BoardingScreen(),
      ),

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
      GoRoute(
        path: "/details",
        builder: (context, state) => DetailsScreen(id: state.extra as String),
      ),
      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
      ),
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
