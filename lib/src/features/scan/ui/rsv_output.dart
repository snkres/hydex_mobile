import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/scan/data/scan_response.dart';
import 'package:hydex/src/features/scan/ui/components/cancel_booking_button.dart';
import 'package:hydex/src/features/scan/ui/components/scan_action_buttons.dart';
import 'package:smooth_corner/smooth_corner.dart';

class RsvOutput extends ConsumerWidget {
  const RsvOutput({super.key, required this.data});

  final ScanResponse data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acc = AppTextStyles(context).accumulator;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  BackButton(),
                  Visibility(
                    visible: false,
                    child: CancelBookingButton(bookingId: data.id),
                  ),
                ],
              ),
              Text(
                "RSV#${data.id.substring(0, 7).toUpperCase()}",
                style: TextStyle(
                  fontSize: acc * 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SmoothClipRRect(
                smoothness: 1,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerDim,
                    border: Border.all(color: AppColors.borderDefault),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  "Guest Name",
                                  style: TextStyle(
                                    fontSize: acc * 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  data.fullName,
                                  style: TextStyle(
                                    fontSize: acc * 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${data.email} - ${data.gender ?? ''}",
                                  style: TextStyle(
                                    fontSize: acc * 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          if (data.qrCodeUrl != null &&
                              data.qrCodeUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                data.qrCodeUrl!,
                                width: 79,
                                height: 79,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 79,
                                  height: 79,
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.qr_code,
                                    size: 40,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const Divider(height: 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                    fontSize: acc * 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  DateFormat('EEE').format(data.bookingDate),
                                  style: TextStyle(
                                    fontSize: acc * 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'd MMM yyyy',
                                  ).format(data.bookingDate),
                                  style: TextStyle(
                                    fontSize: acc * 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    fontSize: acc * 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'hh:mm a',
                                  ).format(data.bookingDate),
                                  style: TextStyle(
                                    fontSize: acc * 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (data.phone != null && data.phone!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                      fontSize: acc * 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    data.phone!,
                                    style: TextStyle(
                                      fontSize: acc * 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    "Guest(s)",
                                    style: TextStyle(
                                      fontSize: acc * 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    "1 out of 3",
                                    style: TextStyle(
                                      fontSize: acc * 16,
                                      fontWeight: FontWeight.w700,
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
              ),
              Spacer(),
              ScanActionButtons(bookingId: data.id),
            ],
          ),
        ),
      ),
    );
  }
}
