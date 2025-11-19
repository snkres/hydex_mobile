import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class UpcomingEvent extends StatelessWidget {
  const UpcomingEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ListView.separated(
        separatorBuilder: (_, _) =>
            Column(children: [Divider(), SizedBox(height: 16)]),
        itemCount: 3,
        itemBuilder: (context, index) => UpcomingEventContainer(),
      ),
    );
  }
}

class UpcomingEventContainer extends StatelessWidget {
  const UpcomingEventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: 48,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    side: BorderSide(color: AppColors.borderBrand, width: 1),
                    borderRadius: BorderRadius.circular(16),
                    smoothness: 1,
                  ),
                  color: AppColors.signalBrandTint,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      "16",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 18,
                        color: AppColors.signalBrandSolid,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "SAT",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 14,
                        color: AppColors.signalBrandSolid,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          "Midnight Soirée",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 16,
                            fontWeight: .w600,
                          ),
                        ),
                        Text(
                          "Nov 16 • 10:00 PM",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextStyles(context).accumulator * 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: .symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.signalFunSuccess,
                        borderRadius: .circular(100),
                      ),
                      child: Text(
                        "Confirmed",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                          color: AppColors.textSuccess,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          spacing: 16,
          children: [
            Row(
              spacing: 4.5,
              children: [
                SvgPicture.asset(
                  "img/svg/location.svg",
                  package: "assets",
                  width: 15,
                ),
                Text(
                  "The Vault, Zamalek",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextStyles(context).accumulator * 14,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 4.5,

              children: [
                SvgPicture.asset(
                  "img/svg/guests.svg",
                  package: "assets",
                  width: 15,
                ),
                Text(
                  "Booked for 2",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextStyles(context).accumulator * 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        PrimaryButton(
          onTap: () async {
            context.push("/profile-summary");
          },
          title: "View details",
          bgColor: AppColors.buttonTertiary,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
