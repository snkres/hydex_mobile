import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/models/booking_status.dart';
import 'package:hydex/src/features/owner/models/scan_type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BookingCardData {
  final String id;
  final String name;
  final String date;
  final String type;
  final String code;
  final String status;

  const BookingCardData({
    required this.id,
    required this.code,
    required this.name,
    required this.date,
    required this.type,
    required this.status,
  });
}

class OwnerBookingCard extends StatelessWidget {
  const OwnerBookingCard({
    super.key,
    required this.booking,
    required this.styles,
    this.rsv,
  });

  final BookingCardData booking;
  final AppTextStyles styles;
  final String? rsv;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        BookingStatus.fromString(booking.status)?.color ??
        AppColors.textWarning;

    return GestureDetector(
      onTap: () => context.push(
        "/scan/ticket/${booking.id}",

        extra: rsv != null ? ScanType.reservation : ScanType.booking,
      ),
      child: SmoothContainer(
        padding: const EdgeInsets.all(16),
        color: AppColors.containerDim,
        smoothness: 1,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Opacity(
                    opacity: 0.3,
                    child: Text(
                      booking.code,
                      style: TextStyle(
                        fontFamily: styles.fontFamily,
                        fontSize: styles.accumulator * 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 20 / 14,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: rsv == null,
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        booking.status,
                        style: TextStyle(
                          fontSize: styles.accumulator * 11,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                          height: 16 / 11,
                        ),
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: rsv != null,
                  child: Container(
                    width: 43,
                    height: 28,
                    alignment: .center,
                    decoration: BoxDecoration(
                      borderRadius: .circular(100),
                      color: AppColors.surfaceContainerLighter,
                    ),
                    child: Text(
                      rsv?.toUpperCase() ?? "",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 11,
                        fontWeight: .w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              booking.name,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 20 / 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  booking.date,
                  style: TextStyle(
                    fontSize: styles.accumulator * 11,
                    color: AppColors.textSecondary,
                    height: 16 / 11,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '${booking.type} guest',
                        style: TextStyle(
                          fontSize: styles.accumulator * 11,
                          color: AppColors.textSecondary,
                          height: 16 / 11,
                        ),
                      ),
                      Visibility(
                        visible: rsv != null,
                        child: Row(
                          children: [
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              booking.status,
                              style: TextStyle(
                                fontSize: styles.accumulator * 11,
                                fontWeight: FontWeight.w500,
                                color: statusColor,
                                height: 16 / 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
