import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:lottie/lottie.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    this.heading = "Hmm… nothing matches your search",
    this.description =
        "Try adjusting your filters or search with another word.",
  });
  final String heading, description;
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
            heading,
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 8),

          SizedBox(
            width: 245,
            child: Text(
              description,
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
