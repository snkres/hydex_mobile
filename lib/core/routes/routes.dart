import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/boarding/ui/boarding.dart';
import 'package:hydex/src/features/boarding/ui/create_pass.dart';
import 'package:hydex/src/features/boarding/ui/describe.dart';
import 'package:hydex/src/features/boarding/ui/nationality.dart';
import 'package:hydex/src/features/boarding/ui/otp.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
import 'package:hydex/src/features/boarding/ui/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);

  final routes = GoRouter(
    initialLocation: '/waitlist',
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
          GoRoute(path: "ulike", builder: (context, state) => const Describe()),
          GoRoute(
            path: "waitlist",
            builder: (context, state) => const WaitlistScreen(),
          ),
        ],
      ),
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
