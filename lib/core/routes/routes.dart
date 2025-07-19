import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/auth/signup/presentation/signup.dart';
import 'package:hydex/src/features/auth/verify_phone/presentation/verify_phone.dart';
import 'package:hydex/src/features/auth/welcome/presentation/personal_info.dart';
import 'package:hydex/src/features/auth/welcome/presentation/welcome.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

class AppRoutes {
  Ref ref;
  AppRoutes(this.ref);

  final routes = GoRouter(
    initialLocation: '/personal_info',
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SignUpScreen()),
      GoRoute(
        path: "/verify_phone",
        builder: (context, state) => const VerifyPhone(),
      ),
      GoRoute(
        path: "/welcome",
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: "/personal_info",
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      
    ],
  );
}

@riverpod
GoRouter goRouter(Ref ref) {
  return AppRoutes(ref).routes;
}
