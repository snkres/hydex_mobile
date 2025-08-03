import 'package:hydex/src/features/boarding/data/usertype.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usertype_provider.g.dart';

@riverpod
class UserTypeNotifier extends _$UserTypeNotifier {
  @override
  UserType build() {
    return UserType.none;
  }

  void change(UserType type) => state = type;
}
