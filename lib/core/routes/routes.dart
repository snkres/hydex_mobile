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
import 'package:hydex/src/features/booking/ui/create_booking.dart';
import 'package:hydex/src/features/booking/ui/summary.dart';
import 'package:hydex/src/features/contact/ui/contacts.dart';
import 'package:hydex/src/features/loading/ui/loading.dart';
import 'package:hydex/src/features/location/ui/location_screen.dart';
import 'package:hydex/src/features/notifications/ui/notifications_screen.dart';
import 'package:hydex/src/features/vibes/ui/details_screen.dart';
import 'package:hydex/src/features/waitlist/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);
  final routes = GoRouter(
    initialLocation: '/boarding',
    redirect: (context, state) async {
      final isAuthenticated = await DioHelper.getAccessToken() != null;
      final currentRoute = state.uri.path;
      if (isAuthenticated) {
        if (currentRoute != "/boarding") {
          return null;
        }
        return "/create-booking"; //TODO: Change to home route
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) =>
            BaseScreen(initialTab: state.extra as int?),
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
        path: "/create-booking",
        builder: (context, state) => CreateBooking(),
      ),
      GoRoute(path: "/summary", builder: (context, state) => SummaryBooking()),
      GoRoute(path: "/contacts", builder: (context, state) => ContactsScreen()),
      GoRoute(
        path: "/details",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: VendorDetailsScreen(),
            transitionDuration: Duration(milliseconds: 600),
            reverseTransitionDuration: Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // Luxury curved animation
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubicEmphasized,
                    reverseCurve: Curves.easeOutCubic,
                  );

                  // Fade transition
                  final fadeAnimation = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(curvedAnimation);

                  // Scale transition (slight zoom)
                  final scaleAnimation = Tween<double>(
                    begin: 0.92,
                    end: 1.0,
                  ).animate(curvedAnimation);

                  // Slide transition (subtle upward movement)
                  final slideAnimation = Tween<Offset>(
                    begin: Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(curvedAnimation);

                  return SlideTransition(
                    position: slideAnimation,
                    child: ScaleTransition(
                      scale: scaleAnimation,
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: child,
                      ),
                    ),
                  );
                },
          );
        },
      ),

      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
      ),
      GoRoute(
        path: "/loading",
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: "/terms",
        builder: (context, state) => const TermsAndConditions(),
      ),
      GoRoute(path: "/location", builder: (context, state) => LocationScreen()),
      GoRoute(
        path: "/notifications",
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
