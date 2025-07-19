import 'package:hydex/src/features/auth/signup/data/type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_providers.g.dart';

@riverpod
class TypeNotifier extends _$TypeNotifier {
  @override
  UserType? build() {
    return null;
  }

  void change(UserType value) => state = value;
}
