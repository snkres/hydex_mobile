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
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/ui/components/ban_hady.dart';
import 'package:hydex/src/features/booking/ui/create_booking.dart';
import 'package:hydex/src/features/booking/ui/summary.dart';
import 'package:hydex/src/features/category/ui/category_details.dart';
import 'package:hydex/src/features/contact/ui/contacts.dart';
import 'package:hydex/src/features/events/ui/events.dart';
import 'package:hydex/src/features/location/ui/location_screen.dart';
import 'package:hydex/src/features/notifications/ui/notifications_screen.dart';
import 'package:hydex/src/features/owner/ui/events.dart';
import 'package:hydex/src/features/owner/ui/home.dart';
import 'package:hydex/src/features/owner/ui/login.dart';
import 'package:hydex/src/features/owner/ui/owner_venue.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/ui/profile_screen.dart';
import 'package:hydex/src/features/profile_summary/ui/profile_summary.dart';
import 'package:hydex/src/features/scan/ui/scan.dart';
import 'package:hydex/src/features/splash/ui/splash.dart';
import 'package:hydex/src/features/vendors/ui/vendors.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/ui/components/event_details.dart';
import 'package:hydex/src/features/vibes/ui/details_screen.dart';
import 'package:hydex/src/features/vibes/ui/happening_nearby.dart';
import 'package:hydex/src/features/vibes/ui/happening_tonight.dart';
import 'package:hydex/src/features/waitlist/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);
  final routes = GoRouter(
    initialLocation: '/splash',

    routes: [
      GoRoute(path: "/splash", builder: (context, state) => SplashScreen()),
      GoRoute(
        path: "/",
        builder: (context, state) =>
            BaseScreen(initialTab: state.extra as int?),
      ),
      GoRoute(path: "/profile", builder: (context, state) => ProfileScreen()),

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

      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: "/owner/login",

        builder: (context, state) {
          final token = state.uri.queryParameters['token'] ?? "test_token";
          return OwnerLogin(token: token);
        },
      ),
      GoRoute(
        path: "/owner/home",
        builder: (context, state) => const OwnerHomeScreen(),
      ),
      GoRoute(
        path: "/owner/events",
        builder: (context, state) => const OwnerEvents(),
      ),
      GoRoute(
        path: "/owner/venue",
        builder: (context, state) => const OwnerVenues(),
      ),
      GoRoute(
        path: "/owner/scan",
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
        path: '/forget-password',
        builder: (context, state) => ForgetPassword(),
      ),
      GoRoute(
        path: '/profile-summary',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return ProfileSummary(
            event: args['event'] as UpcomingEvent,
            isHistory: args['isHistory'] as bool? ?? false,
          );
        },
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
        builder: (context, state) =>
            CreateBooking(book: state.extra as CreateBook),
      ),
      GoRoute(path: "/summary", builder: (context, state) => SummaryBooking()),
      GoRoute(path: "/contacts", builder: (context, state) => ContactsScreen()),

      GoRoute(
        path: "/waitlist",
        builder: (context, state) => const WaitlistScreen(),
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
      GoRoute(
        path: "/notifications",
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: "/happening_tonight",
        builder: (context, state) => const HappeningTonight(),
      ),
      GoRoute(
        path: "/happening_nearby",
        builder: (context, state) => const HappeningNearby(),
      ),
      GoRoute(path: "/events", builder: (context, state) => const AllEvents()),
      GoRoute(
        path: "/vendors",
        builder: (context, state) => const AllVendors(),
      ),
      GoRoute(
        path: "/event/:id",
        name: "event_detail",
        builder: (context, state) =>
            EventDetailScreen(id: state.pathParameters["id"] as String),
      ),
      GoRoute(
        path: "/vendor/:id",
        name: "vendor_detail",
        builder: (context, state) =>
            VendorDetailsScreen(id: state.pathParameters["id"] as String),
      ),
      GoRoute(path: "/hady", builder: (context, state) => BanHady()),
      GoRoute(
        path: "/category",
        name: "category_detail",
        builder: (context, state) {
          final category = state.extra as EventCategory;
          return CategoryDetails(
            category: category,
            subCategories: category.subCategories ?? [],
          );
        },
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  final router = AppRoutes(ref).routes;

  // Wire up force logout so 503 (and failed token refresh) navigates to boarding
  DioHelper.onForceLogout = () {
    router.go('/boarding');
  };

  return router;
}
