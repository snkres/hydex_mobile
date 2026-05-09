import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.isRead = true,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
  });

  final String title;
  final String subtitle;
  final String timestamp;
  final bool isRead;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SmoothContainer(
          smoothness: 1,
          borderRadius: BorderRadius.circular(24),
          color: AppColors.containerDim,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: styles.fontFamily,
                        fontSize: styles.accumulator * 14,
                        fontWeight: FontWeight.w700,
                        color: isRead
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        height: 20 / 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: styles.fontFamily,
                        fontSize: styles.accumulator * 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        height: 16 / 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      timestamp,
                      style: TextStyle(
                        fontFamily: styles.fontFamily,
                        fontSize: styles.accumulator * 11,
                        fontWeight: FontWeight.w500,
                        color: isRead
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        height: 16 / 11,
                      ),
                    ),
                    if (actionLabel != null) ...[
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: onAction,
                        child: SmoothContainer(
                          smoothness: 1,
                          borderRadius: BorderRadius.circular(24),
                          color: AppColors.textPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            actionLabel!,
                            style: TextStyle(
                              fontFamily: styles.fontFamily,
                              fontSize: styles.accumulator * 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textInverse,
                              height: 16 / 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
