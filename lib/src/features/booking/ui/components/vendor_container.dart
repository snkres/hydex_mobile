import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class VendorContainer extends StatelessWidget {
  const VendorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      borderRadius: .circular(26),
      color: Color(0xff1E1E20),
      padding: .all(16),
      margin: .symmetric(horizontal: 16),
      smoothness: 1,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Vendor Name",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "Cairo Jazz Club",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "📍 197, 26th of July Street, Agouza, Giza",
            style: AppTextStyles(
              context,
            ).captionRegular.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Date and Time",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "25 Oct at 9:00 PM",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),

          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Number of Passes",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "3 VIP Experience",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}

class VenueContainer extends StatelessWidget {
  const VenueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      borderRadius: .circular(26),
      color: Color(0xff1E1E20),
      padding: .all(16),
      margin: .symmetric(horizontal: 16),
      smoothness: 1,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Venue",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "Cairo Jazz Club",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),

          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Location",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  "197, 26th of July Street, Agouza, Giza",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 16,
                    fontWeight: .w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLighter,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      SvgPicture.asset(
                        "img/svg/directions.svg",
                        package: "assets",
                        width: 13,
                      ),
                      Text(
                        "Directions",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Number of Passes",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "3 VIP Experience",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}
