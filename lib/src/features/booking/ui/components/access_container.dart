import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:smooth_corner/smooth_corner.dart';

final VipCountProvider = StateProvider<int>((ref) => ref.watch(guestsProvider));

class AccessSection extends StatelessWidget {
  const AccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Choose Your Access",
            style: AppTextStyles(
              context,
            ).secondaryBold.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 12),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: ShapeDecoration(
            color: Color(0xff1E1E20),
            shape: SmoothRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
              side: BorderSide(color: AppColors.borderDefault, width: 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Standard Access",
                        style: AppTextStyles(context).secondaryBold,
                      ),
                      SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "1,700 ",
                              style: AppTextStyles(context).smallBold,
                            ),
                            TextSpan(
                              text: "EGP",
                              style: AppTextStyles(context).captionMedium
                                  .copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: AppColors.textInverse,
                          fontSize: AppTextStyles(context).accumulator * 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text(
                "Enjoy full access to the event with general seating or entry.",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: 20),

              Text(
                "Includes:",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Event access",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Complimentary welcome drink",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Standard seating area",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: ShapeDecoration(
            color: Color(0xff1E1E20),
            shape: SmoothRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              smoothness: 1,
              side: BorderSide(color: AppColors.borderDefault, width: 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "VIP Experience",
                        style: AppTextStyles(context).secondaryBold,
                      ),
                      SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "1,700 ",
                              style: AppTextStyles(context).smallBold,
                            ),
                            TextSpan(
                              text: "EGP",
                              style: AppTextStyles(context).captionMedium
                                  .copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final vpCount = ref.watch(VipCountProvider);
                      return Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (vpCount > 1) {
                                  ref
                                      .read(VipCountProvider.notifier)
                                      .update((state) => state - 1);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.transparent,
                                ),
                              ),
                              icon: Transform.translate(
                                offset: const Offset(0, -6), // move up
                                child: const Icon(
                                  Icons.minimize,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              vpCount.toString(),
                              style: AppTextStyles(
                                context,
                              ).smallMedium.copyWith(color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(VipCountProvider.notifier)
                                    .update((state) => state + 1);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.transparent,
                                ),
                              ),
                              icon: const Icon(Icons.add, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text(
                "Enjoy full access to the event with general seating or entry.",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: 20),

              Text(
                "Includes:",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Event access",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Complimentary welcome drink",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                "\u2022 Standard seating area",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
