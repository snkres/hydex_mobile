import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';

class CancelBookingButton extends StatelessWidget {
  const CancelBookingButton({super.key, required this.bookingId});

  final String bookingId;

  void _showCancelBottomSheet(BuildContext context) {
    final reasonController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0F12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            final hasText = reasonController.text.isNotEmpty;
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEDEDE).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            const Text(
                              "Cancel this booking?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "This action is irreversible and guest will be notified.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.35),
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          controller: reasonController,
                          maxLines: 4,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: "Cancellation reason",
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                            filled: true,
                            fillColor: AppColors.surfaceContainer,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                        Column(
                          spacing: 12,
                          children: [
                            Consumer(
                              builder: (context, ref, _) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: hasText
                                          ? AppColors.textError
                                          : const Color(0xFF313133),
                                      foregroundColor: hasText
                                          ? Colors.white
                                          : const Color(0xFF808080),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (hasText) {
                                        unawaited(
                                          ref.read(
                                            updateBookingStatusProvider(
                                              id: bookingId,
                                              status: .cancelled,
                                              rejectionReason:
                                                  reasonController.text,
                                            ).future,
                                          ),
                                        );
                                        context.pop();
                                      }
                                    },
                                    child: const Text(
                                      "Yes, cancel booking",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1F1F1F),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text(
                                  "Keep booking",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: .all(Size(115, 39)),
        side: .all(BorderSide(color: AppColors.borderDefault)),
        backgroundColor: .all(Colors.black),
      ),
      onPressed: () => _showCancelBottomSheet(context),
      child: Text(
        "Cancel Booking",
        style: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
