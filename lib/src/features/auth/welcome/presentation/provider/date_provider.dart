import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_provider.g.dart';

enum LifeStyle { worker, student }

@riverpod
class LifeNotifier extends _$LifeNotifier {
  @override
  LifeStyle? build() {
    return null;
  }

  void change(LifeStyle value) => state = value;
}
