import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class ReviewBooking extends StatelessWidget {
  const ReviewBooking({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(
          context,
        ).viewInsets.bottom, // Adjusts for keyboard
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 44,
              decoration: BoxDecoration(
                color: Color(0xffDEDEDE),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 22),
          Text(
            "Review Your Booking",
            style: AppTextStyles(context).primaryBold,
          ),
          SizedBox(height: 8),
          Text(
            "Cairo Jazz Club — Live Music Night",
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "img/svg/calendar_2.svg",
              package: "assets",
              width: 20,
            ),
            title: Text(
              "Date",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Text(
              "Fri, 13 Sept",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "img/svg/guests.svg",
              package: "assets",
              width: 26,
            ),
            title: Text(
              "Guests",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Text(
              "4 people",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "img/svg/location.svg",
                        package: "assets",
                        width: 20,
                      ),
                      SizedBox(height: 14),
                      Text(
                        "197, 26th of July St, Agouza, Giza",
                        style: AppTextStyles(context).captionMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "img/svg/fee.svg",
                        package: "assets",
                        width: 20,
                      ),
                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: "400",
                          style: AppTextStyles(
                            context,
                          ).primaryMedium.copyWith(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: " EGP",
                              style: AppTextStyles(context).captionMedium,
                            ),
                            TextSpan(
                              text: " / per person",
                              style: AppTextStyles(context).captionRegular,
                            ),
                          ],
                        ),
                        style: AppTextStyles(context).primaryMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          Column(
            children: [
              PrimaryButton(
                onTap: () async {
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                title: "Confirm Booking",
              ),
              TextButton(
                onPressed: () {
                  controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(
                  "Edit Booking",
                  style: AppTextStyles(context).smallBold.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
