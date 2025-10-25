import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AdventureScreen extends StatelessWidget {
  AdventureScreen({super.key});

  final data = ["Gear", "Meals", "🧭 Guided Tour", "🚙 Off-Road"];
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
                  children: data
                      .map(
                        (e) => SmoothClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          smoothness: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                  ),
                                ),
                              ],
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
            "Main Experience".toUpperCase(),
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
                Text(
                  "Red Sea Yacht Cruise",
                  style: AppTextStyles(context).smallBold,
                ),
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
                Text(
                  "Mountain Hike & Campfire",
                  style: AppTextStyles(context).smallBold,
                ),
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
                Text(
                  "Desert Safari Expedition",
                  style: AppTextStyles(context).smallBold,
                ),
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
