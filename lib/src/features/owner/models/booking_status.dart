import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';

enum BookingStatus {
  pending,
  confirmed,
  entered,
  noShow,
  rejected,
  cancelled;

  String get label => switch (this) {
        BookingStatus.pending => 'Pending',
        BookingStatus.confirmed => 'Confirmed',
        BookingStatus.entered => 'Entered',
        BookingStatus.noShow => 'No Show',
        BookingStatus.rejected => 'Rejected',
        BookingStatus.cancelled => 'Cancelled',
      };

  Color get color => switch (this) {
        BookingStatus.pending => AppColors.textWarning,    // #FFB020
        BookingStatus.confirmed => AppColors.textSuccess,  // #2ECC71
        BookingStatus.entered => AppColors.textBrand,      // #A25BFF
        BookingStatus.noShow => AppColors.textError,       // #FF0003
        BookingStatus.rejected => AppColors.textError,     // #FF0003
        BookingStatus.cancelled => AppColors.textSecondary, // #89898F
      };

  static BookingStatus? fromString(String value) => switch (value.toLowerCase()) {
        'pending' => BookingStatus.pending,
        'confirmed' => BookingStatus.confirmed,
        'entered' => BookingStatus.entered,
        'no show' || 'noshow' || 'no_show' => BookingStatus.noShow,
        'rejected' => BookingStatus.rejected,
        'cancelled' || 'canceled' => BookingStatus.cancelled,
        _ => null,
      };
}
