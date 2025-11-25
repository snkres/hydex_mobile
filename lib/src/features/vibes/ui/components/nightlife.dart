import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/ui/components/sports_section.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NightLifeSection extends StatelessWidget {
  const NightLifeSection({super.key, required this.experiences});
  final List<Experiences> experiences;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SmoothClipRRect(
            borderRadius: BorderRadius.circular(16),
            smoothness: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Experience Details".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    fontSize: AppTextStyles(context).accumulator * 16,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: experiences
                      .map(
                        (e) => IntrinsicWidth(
                          child: SmoothClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            smoothness: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainer,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8),
                                    color: AppColors.buttonSecondary,
                                    child: Text(
                                      e.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            9,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      e.description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Line-UP".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              fontSize: AppTextStyles(context).accumulator * 16,
            ),
          ),
        ),
        SizedBox(height: 12),
        CarouselSlider(
          items: [
            Column(
              spacing: 13,
              children: [
                SmoothClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  smoothness: 1,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
                Text("DJ ToTo", style: AppTextStyles(context).smallBold),
              ],
            ),
            Column(
              spacing: 13,
              children: [
                SmoothClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  smoothness: 1,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                ),
                Text("DJ ToTo", style: AppTextStyles(context).smallBold),
              ],
            ),
            Column(
              spacing: 13,
              children: [
                SmoothClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  smoothness: 1,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.amber),
                  ),
                ),
                Text("DJ ToTo", style: AppTextStyles(context).smallBold),
              ],
            ),
          ],

          options: CarouselOptions(
            height: 245,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,

            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
