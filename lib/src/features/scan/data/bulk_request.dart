class BulkRequest {
  final String status, bookingID;
  final String? rejectionReason;
  BulkRequest({
    required this.status,
    required this.bookingID,
    this.rejectionReason,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookingId": bookingID,
      "status": status,
      if (rejectionReason != null) "rejectionReason": rejectionReason,
    };
  }
}
