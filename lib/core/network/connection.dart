import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection.g.dart';

@Riverpod(keepAlive: true)
Stream<InternetStatus> connectivityStatus(Ref ref) {
  return InternetConnection().onStatusChange;
}
