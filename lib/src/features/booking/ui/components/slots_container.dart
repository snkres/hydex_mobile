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
  bool _showAllSlots = false;
  bool isEvent() => widget.startTime != null && widget.operatingHours.isEmpty;

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  bool isSameDate(DateTime? selectedSlot, DateTime selectedTime) {
    return selectedSlot == selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    if (isEvent()) {
      return Wrap(
        spacing: 9,
        runSpacing: 11,
        runAlignment: WrapAlignment.center,
        children: [
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
                    color: isSameDate(widget.selectedSlot, widget.startTime!)
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
        ],
      );
    }

    final filteredSlots = widget.operatingHours
        .where((slot) => DateUtils.isSameDay(widget.selectedDate, slot))
        .toList();

    final visibleSlots = _showAllSlots
        ? filteredSlots
        : filteredSlots.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          spacing: 9,
          runSpacing: 11,
          runAlignment: WrapAlignment.center,
          children: visibleSlots
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
        ),
        if (filteredSlots.length > 6) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                _showAllSlots = !_showAllSlots;
              });
            },
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  _showAllSlots ? "View fewer slots" : "View all slots",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  _showAllSlots
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: AppTextStyles(context).accumulator * 20,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
