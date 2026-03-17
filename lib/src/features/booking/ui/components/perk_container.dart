import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';

class PerkContainer extends StatelessWidget {
  const PerkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),

        separatorBuilder: (context, index) => SizedBox(width: 4),
        itemBuilder: (context, index) {
          return Container(
            width: 361,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xff1E1E20),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "img/svg/ticket_discount.svg",
                  package: "assets",
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Flat 25% Off",
                      style: AppTextStyles(context).smallBold,
                    ),
                    Text(
                      "Available on Thu, Nov 24 at 12:00 PM",
                      style: AppTextStyles(
                        context,
                      ).captionRegular.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
