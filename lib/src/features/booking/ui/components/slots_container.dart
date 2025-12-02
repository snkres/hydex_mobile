import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SlotsContainer extends StatefulWidget {
  const SlotsContainer({
    super.key,
    required this.selectedDate,
    this.operatingHours,
    this.startTime,
  });

  final DateTime selectedDate;
  final Map<String, OperatingHours>? operatingHours;
  final DateTime? startTime;

  @override
  State<SlotsContainer> createState() => _SlotsContainerState();
}

class _SlotsContainerState extends State<SlotsContainer> {
  bool isEvent() => widget.startTime != null;

  bool isSameDayAsEventStart() {
    final startTime = widget.startTime;
    final selectedDate = widget.selectedDate;

    if (startTime == null) {
      return false;
    }

    return selectedDate.year == startTime.year &&
        selectedDate.month == startTime.month &&
        selectedDate.day == startTime.day;
  }

  // 🎯 NEW: Time formatting function
  String _formatTime(DateTime time) {
    // 'h': 1-12 hour format (no leading zero)
    // 'mm': minutes with leading zero
    // 'a': AM/PM marker
    return DateFormat('h:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final shouldShowEventTime = isEvent() && isSameDayAsEventStart();

    return Wrap(
      spacing: 9,
      runSpacing: 11,
      runAlignment: WrapAlignment.start,
      children: shouldShowEventTime
          ? [
              AnimatedContainer(
                width: AppTextStyles(context).accumulator * 114,
                height: AppTextStyles(context).heightAccumulator * 52,
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    side: BorderSide(color: AppColors.borderDefault, width: 1),
                    borderRadius: BorderRadius.circular(16),
                    smoothness: 1,
                  ),
                ),
                child: Text(
                  _formatTime(widget.startTime!),
                  style: AppTextStyles(context).secondaryMedium,
                ),
              ),
            ]
          : [],
    );
  }
}
