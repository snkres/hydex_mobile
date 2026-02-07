import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NightLifeSection extends StatelessWidget {
  const NightLifeSection({
    super.key,
    required this.experiences,
    required this.details,
    required this.title,
  });
  final List<Experiences> experiences;
  final List<Detail> details;
  final String? title;
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
                                      e.title ?? "Title",
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

        Visibility(
          visible: details.isNotEmpty,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title?.toUpperCase() ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    fontSize: AppTextStyles(context).accumulator * 16,
                  ),
                ),
              ),
              SizedBox(height: 12),
              CarouselSlider(
                items: details
                    .map(
                      (e) => Column(
                        spacing: 13,
                        children: [
                          SmoothClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            smoothness: 1,
                            child: CachedNetworkImage(
                              imageUrl: e.image,
                              width: 200,
                              height: 200,
                              fit: .cover,
                            ),
                          ),
                          Text(
                            e.title,
                            style: AppTextStyles(context).smallBold,
                          ),
                        ],
                      ),
                    )
                    .toList(),

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
          ),
        ),
      ],
    );
  }
}
