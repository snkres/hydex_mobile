import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class DateContainer extends StatefulWidget {
  const DateContainer({super.key});

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  DateTime selectedDate = DateTime.now();

  final List<DateTime> dates = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );

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

  bool isSelected(DateTime date) {
    return date.day == selectedDate.day &&
        date.month == selectedDate.month &&
        date.year == selectedDate.year;
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
                monthNames[selectedDate.month - 1],
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
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = dates[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 59,
                        height: 60,
                        curve: Curves.easeInOut,
                        decoration: ShapeDecoration(
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                              color: isSelected(dates[index])
                                  ? AppColors.borderBrand
                                  : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            smoothness: 1,
                          ),
                          color: isSelected(dates[index])
                              ? AppColors.signalBrandTint
                              : AppColors.surfaceContainerLighter,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              dates[index].day.toString(),
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 18,
                                color: isSelected(dates[index])
                                    ? AppColors.signalBrandSolid
                                    : Colors.white,
                                fontWeight: isSelected(dates[index])
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                            Text(
                              getDayName(dates[index].weekday),
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                color: isSelected(dates[index])
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
                  itemCount: dates.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
