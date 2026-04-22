import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class EventCardData {
  final String id;
  final String name;
  final String date;
  final String? tag;
  final int sold;
  final int total;
  final String revenue;

  EventCardData({
    required this.id,
    required this.name,
    required this.date,
    this.tag,
    required this.sold,
    required this.total,
    required this.revenue,
  });
}

enum EventStatus { active, pending, rejected, past }

class ActiveEventCard extends StatelessWidget {
  final EventCardData event;
  final AppTextStyles styles;
  final VoidCallback? onTap;
  final EventStatus? status;

  const ActiveEventCard({
    super.key,
    required this.event,
    required this.styles,
    this.onTap,
    this.status,
  });

  String get _statusLabel => switch (status) {
    EventStatus.active => '• Active Event',
    EventStatus.pending => '• Pending Event',
    EventStatus.rejected => '• Rejected Event',
    EventStatus.past => '• Past Event',
    null => 'Event',
  };

  Color get _statusColor => switch (status) {
    EventStatus.active => AppColors.textSuccess,
    EventStatus.pending => AppColors.textWarning,
    EventStatus.rejected => AppColors.textError,
    _ => AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final progress = event.sold / event.total;

    return GestureDetector(
      onTap: onTap,
      child: SmoothContainer(
        padding: const EdgeInsets.all(16),
        color: AppColors.containerDim,
        smoothness: 1,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$_statusLabel ${event.id}',
                        style: TextStyle(
                          fontSize: styles.accumulator * 12,
                          color: _statusColor,
                          height: 16 / 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        event.name,
                        style: styles.secondaryBold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.date,
                        style: TextStyle(
                          fontSize: styles.accumulator * 11,
                          color: AppColors.textSecondary,
                          height: 16 / 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (event.tag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLighter,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      event.tag!,
                      style: TextStyle(
                        fontSize: styles.accumulator * 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 16 / 11,
                      ),
                    ),
                  ),
              ],
            ),
            if (status == EventStatus.active || status == null) ...[
              SizedBox(height: styles.accumulator * 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${event.sold}/${event.total} sold',
                    style: styles.smallMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    event.revenue,
                    style: styles.smallMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: AppColors.surfaceContainerLighter,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.buttonSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
