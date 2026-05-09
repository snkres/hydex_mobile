import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydex/src/features/owner/models/event_status.dart';
import 'package:hydex/src/features/vibes/data/location.dart';

part 'owner_event.mapper.dart';

@MappableClass()
class OwnerEvent with OwnerEventMappable {
  final String id;
  final String displayCode;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final String? timeLabel;
  final Location? location;

  @MappableField(key: 'uiStatus')
  final EventStatus status;
  final OwnerEventSales sales;
  final OwnerEventRevenue revenue;

  OwnerEvent({
    required this.id,
    required this.displayCode,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.timeLabel,
    required this.status,
    required this.sales,
    required this.revenue,
    this.location,
  });
}

@MappableClass()
class OwnerEventSales with OwnerEventSalesMappable {
  final int sold;
  final int capacity;

  OwnerEventSales({required this.sold, required this.capacity});
}

@MappableClass()
class OwnerEventRevenue with OwnerEventRevenueMappable {
  final double amount;
  final String currency;

  OwnerEventRevenue({required this.amount, required this.currency});
}
