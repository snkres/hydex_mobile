import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SlotsContainer extends StatefulWidget {
  const SlotsContainer({
    super.key,
    required this.selectedDate,
    required this.operatingHours,
    this.startTime,
    this.selectedSlot,
    required this.onSelectSlot,
  });

  final DateTime? selectedDate, startTime, selectedSlot;
  final List<DateTime> operatingHours;
  final void Function(DateTime) onSelectSlot;

  @override
  State<SlotsContainer> createState() => _SlotsContainerState();
}

class _SlotsContainerState extends State<SlotsContainer> {
  bool isEvent() => widget.startTime != null && widget.operatingHours.isEmpty;

  bool isSameDayAsEventStart() {
    final startTime = widget.startTime;
    final selectedDate = widget.selectedDate;

    if (startTime == null) {
      return false;
    }

    return selectedDate?.year == startTime.year &&
        selectedDate?.month == startTime.month &&
        selectedDate?.day == startTime.day;
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  bool isSameDate(DateTime? selectedSlot, DateTime selectedTime) {
    if (selectedSlot == null) {
      return false;
    }
    return selectedSlot.year == selectedTime.year &&
        selectedSlot.month == selectedTime.month &&
        selectedSlot.day == selectedTime.day;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 11,
      runAlignment: WrapAlignment.start,
      children: isEvent()
          ? [
              GestureDetector(
                onTap: () {
                  widget.onSelectSlot.call(widget.startTime ?? DateTime.now());
                },
                child: AnimatedContainer(
                  width: AppTextStyles(context).accumulator * 114,
                  height: AppTextStyles(context).heightAccumulator * 52,
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: isSameDate(widget.selectedSlot, widget.startTime!)
                        ? AppColors.signalBrandTint
                        : Colors.transparent,

                    shape: SmoothRectangleBorder(
                      side: BorderSide(
                        color:
                            isSameDate(widget.selectedSlot, widget.startTime!)
                            ? AppColors.borderBrand
                            : AppColors.borderDefault,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      smoothness: 1,
                    ),
                  ),
                  child: Text(
                    _formatTime(widget.startTime ?? DateTime.now()),
                    style: AppTextStyles(context).secondaryMedium,
                  ),
                ),
              ),
            ]
          : widget.operatingHours
                // --- [START OF CHANGE] ---
                // We filter the list to only include slots where the Year, Month, and Day
                // match the widget.selectedDate.
                .where((slot) => isSameDate(widget.selectedDate, slot))
                // --- [END OF CHANGE] ---
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      widget.onSelectSlot.call(e);
                    },
                    child: AnimatedContainer(
                      width: AppTextStyles(context).accumulator * 114,
                      height: AppTextStyles(context).heightAccumulator * 52,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        // Note: checks if this specific slot is the "selected" one
                        color: isSameDate(widget.selectedSlot, e)
                            ? AppColors.signalBrandTint
                            : Colors.transparent,
                        shape: SmoothRectangleBorder(
                          side: BorderSide(
                            color: isSameDate(widget.selectedSlot, e)
                                ? AppColors.borderBrand
                                : AppColors.borderDefault,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          smoothness: 1,
                        ),
                      ),
                      child: Text(
                        _formatTime(e),
                        style: AppTextStyles(context).secondaryMedium,
                      ),
                    ),
                  ),
                )
                .toList(),
    );
  }
}
