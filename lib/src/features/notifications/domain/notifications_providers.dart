import 'dart:async';
import 'package:hydex/src/features/notifications/data/notification.dart';
import 'package:hydex/core/network/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'notifications_providers.g.dart';

@riverpod
Future<List<AppNotification>> getNotifications(Ref ref) async {
  final link = ref.keepAlive();
  Timer(const Duration(seconds: 30), link.close);

  final response = await DioHelper.get("/notifications/user");

  final notifications = response.data["data"]["notifications"] as List;
  return notifications
      .map((e) => AppNotificationMapper.fromMap(e as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<void> markAllNotificationsAsRead(Ref ref) async {
  await DioHelper.patch("/notifications/user/mark-all-read");
}
