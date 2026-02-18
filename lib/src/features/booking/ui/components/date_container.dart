import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class DateContainer extends StatefulWidget {
  const DateContainer({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    required this.availableDates,
  });

  final DateTime? selectedDate;
  final Function(DateTime)? onDateSelected;
  final List<DateTime> availableDates;

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  final ScrollController _scrollController = ScrollController();
  static const double _itemWidth = 59;
  static const double _separatorWidth = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelected() {
    if (widget.selectedDate == null) return;
    final index = widget.availableDates.indexWhere(
      (d) =>
          d.year == widget.selectedDate!.year &&
          d.month == widget.selectedDate!.month &&
          d.day == widget.selectedDate!.day,
    );
    if (index <= 0) return;
    final offset = index * (_itemWidth + _separatorWidth);
    if (offset > _scrollController.position.maxScrollExtent) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      _scrollController.jumpTo(offset);
    }
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return '';
    }
  }

  bool isSelected(DateTime? date) {
    if (widget.selectedDate == null) return false;

    return date?.day == widget.selectedDate!.day &&
        date?.month == widget.selectedDate!.month &&
        date?.year == widget.selectedDate!.year;
  }

  final List<String> monthNames = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final int currentMonth = widget.selectedDate?.month ?? DateTime.now().month;
    final int monthIndex = currentMonth - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Select Date",
            style: AppTextStyles(
              context,
            ).secondaryBold.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            Transform.rotate(
              angle: -3.14 / 2,
              child: Text(
                monthNames[monthIndex],
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 72,
                child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onDateSelected?.call(
                          widget.availableDates[index],
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 59,
                        height: 60,
                        curve: Curves.easeInOut,
                        decoration: ShapeDecoration(
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                              color: isSelected(widget.availableDates[index])
                                  ? AppColors.borderBrand
                                  : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            smoothness: 1,
                          ),
                          color: isSelected(widget.availableDates[index])
                              ? AppColors.signalBrandTint
                              : AppColors.surfaceContainerLighter,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              widget.availableDates[index].day.toString(),
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 18,
                                color: isSelected(widget.availableDates[index])
                                    ? AppColors.signalBrandSolid
                                    : Colors.white,
                                fontWeight:
                                    isSelected(widget.availableDates[index])
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                            Text(
                              getDayName(widget.availableDates[index].weekday),
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                color: isSelected(widget.availableDates[index])
                                    ? AppColors.signalBrandSolid
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: widget.availableDates.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
