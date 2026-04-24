import 'package:dart_mappable/dart_mappable.dart';

part 'vendor_sales.mapper.dart';

@MappableClass()
class VendorSales with VendorSalesMappable {
  final VendorSalesRevenue venueRevenue;
  final VendorSalesRevenue eventTicketRevenue;
  final int totalGuests;
  final double averageRevenuePerGuest;
  final List<dynamic> dailyRevenue;

  VendorSales({
    required this.venueRevenue,
    required this.eventTicketRevenue,
    required this.totalGuests,
    required this.averageRevenuePerGuest,
    required this.dailyRevenue,
  });
}

@MappableClass()
class VendorSalesRevenue with VendorSalesRevenueMappable {
  final double amount;
  final String currency;

  VendorSalesRevenue({required this.amount, required this.currency});
}
