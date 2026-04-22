import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/models/booking_status.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BookingCardData {
  final String id;
  final String name;
  final String date;
  final String type;
  final String status;

  const BookingCardData({
    required this.id,
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
  });

  final BookingCardData booking;
  final AppTextStyles styles;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        BookingStatus.fromString(booking.status)?.color ?? AppColors.textWarning;

    return SmoothContainer(
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
              Opacity(
                opacity: 0.3,
                child: Text(
                  booking.id,
                  style: TextStyle(
                    fontFamily: styles.fontFamily,
                    fontSize: styles.accumulator * 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 20 / 14,
                  ),
                ),
              ),
              Row(
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
              Text(
                '${booking.type} guest',
                style: TextStyle(
                  fontSize: styles.accumulator * 11,
                  color: AppColors.textSecondary,
                  height: 16 / 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
