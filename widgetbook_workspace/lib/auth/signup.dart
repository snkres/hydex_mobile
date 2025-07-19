import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';
import 'package:hydex/src/features/auth/signup/presentation/providers/signup_providers.dart';

import 'package:hydex/src/features/auth/signup/presentation/signup.dart';

@widgetbook.UseCase(name: 'Default', type: SignUpScreen)
Widget buildSignUpScreen(BuildContext context) {
  return ProviderScope(
    child: SignUpScreen(
      appbar: FakeAppBar(),
      showError: context.knobs.boolean(label: "Show Error"),
    ),
  );
}
