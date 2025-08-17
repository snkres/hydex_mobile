import 'package:hydex/core/network/user/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usertype_provider.g.dart';

@Riverpod(keepAlive: true)
class UserTypeNotifier extends _$UserTypeNotifier {
  @override
  Role build() {
    return Role.none;
  }

  void change(Role type) => state = type;
}
