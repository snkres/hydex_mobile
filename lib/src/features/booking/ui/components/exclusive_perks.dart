import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ExclusivePerks extends StatelessWidget {
  const ExclusivePerks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Exclusive Perks on This Date",
            style: AppTextStyles(
              context,
            ).secondaryBold.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 117,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),

            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Text("More details about the perk"),
                        ),
                      );
                    },
                  );
                },
                child: AnimatedContainer(
                  width: 341,
                  duration: Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: Color(0xff1E1E20),
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      smoothness: 1,
                      side: BorderSide(
                        color: AppColors.borderDefault,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Complimentary",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 10,
                                ),
                              ),
                              SvgPicture.asset(
                                "img/svg/terms.svg",
                                package: "assets",
                              ),
                            ],
                          ),
                          Text(
                            "Drinks",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTextStyles(context).accumulator * 24,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Perk Description Perk Description ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),

                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Icon(Icons.circle_outlined, size: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
