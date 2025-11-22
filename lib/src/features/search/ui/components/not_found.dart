
import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:lottie/lottie.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 74),

          LottieBuilder.asset(
            "json/empty_box.json",
            package: "assets",
            width: 125,
            height: 125,
          ),
          SizedBox(height: 4),
          Text(
            "Hmm… nothing matches your search",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 8),

          SizedBox(
            width: 245,
            child: Text(
              "Try adjusting your filters or search with another word.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,

                fontSize: AppTextStyles(context).accumulator * 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
