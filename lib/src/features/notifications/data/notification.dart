import 'package:dart_mappable/dart_mappable.dart';

part 'notification.mapper.dart';

@MappableClass()
class AppNotification with AppNotificationMappable {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });
}
