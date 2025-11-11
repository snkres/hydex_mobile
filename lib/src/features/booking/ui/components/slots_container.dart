import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SlotsContainer extends StatelessWidget {
  const SlotsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 11,
      runAlignment: WrapAlignment.center,
      children: [
        AnimatedContainer(
          width: AppTextStyles(context).accumulator * 114,

          height: AppTextStyles(context).heightAccumulator * 52,

          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              side: BorderSide(color: AppColors.borderDefault, width: 1),
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
            ),
          ),
          child: Text(
            "12:00 PM",
            style: AppTextStyles(context).secondaryMedium,
          ),
        ),
        AnimatedContainer(
          width: AppTextStyles(context).accumulator * 114,

          height: AppTextStyles(context).heightAccumulator * 52,

          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              side: BorderSide(color: AppColors.borderDefault, width: 1),
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
            ),
          ),
          child: Text(
            "12:00 PM",
            style: AppTextStyles(context).secondaryMedium,
          ),
        ),
        AnimatedContainer(
          width: AppTextStyles(context).accumulator * 114,
          height: AppTextStyles(context).heightAccumulator * 52,

          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              side: BorderSide(color: AppColors.borderDefault, width: 1),
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
            ),
          ),
          child: Text(
            "12:00 PM",
            style: AppTextStyles(context).secondaryMedium,
          ),
        ),
        AnimatedContainer(
          width: AppTextStyles(context).accumulator * 114,

          height: AppTextStyles(context).heightAccumulator * 52,
          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              side: BorderSide(color: AppColors.borderDefault, width: 1),
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("12:00 PM", style: AppTextStyles(context).secondaryMedium),
              Text(
                "Perks Available",
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
