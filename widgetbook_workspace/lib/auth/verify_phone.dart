import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';

import 'package:hydex/src/features/auth/verify_phone/presentation/verify_phone.dart';

@widgetbook.UseCase(name: 'Verify Phone', type: VerifyPhone)
Widget buildSignUpScreen(BuildContext context) {
  return ProviderScope(child: VerifyPhone(appbar: FakeAppBar()));
}
