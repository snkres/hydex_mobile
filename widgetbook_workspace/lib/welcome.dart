import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';

import 'package:hydex/src/features/auth/welcome/presentation/welcome.dart';

@widgetbook.UseCase(name: 'Default', type: WelcomeScreen)
Widget buildSignUpScreen(BuildContext context) {
  return ProviderScope(child: WelcomeScreen(appbar: FakeAppBar()));
}
