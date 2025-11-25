import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:lottie/lottie.dart';

class HappeningNearby extends StatelessWidget {
  const HappeningNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            collapsedHeight: 150,

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(54),
              child: SizedBox(
                height: 54,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ), // Add spacing between chips
                    child: CustomChip(
                      title: index == 0 ? "All" : "Category $index",
                      isSelected: index == 0,
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              "Happening Nearby",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 15,
                fontWeight: .w900,
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    spacing: 8,
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(
                        "Happening Nearby",
                        style: TextStyle(
                          color: Colors
                              .white, // Ensure text contrasts with the purple
                          fontWeight: FontWeight.w900,
                          fontSize:
                              AppTextStyles(context).accumulator *
                              16, // Size will scale automatically
                        ),
                      ),
                      Text(
                        "Discover experiences happening within reach.",
                        style: TextStyle(
                          color: AppColors
                              .textSecondary, // Ensure text contrasts with the purple

                          fontSize: AppTextStyles(context).accumulator * 9,
                        ),
                      ),
                    ],
                  ),
                  LottieBuilder.asset(
                    "json/location_anim.json",
                    package: "assets",
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16.0,
                bottom: 60.0,
                top: 100,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFA25BFF),
                          Color(0xFF251343),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -25),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        "img/svg/pattern.svg",
                        fit: BoxFit.cover,
                        width: .infinity,
                        package: "assets",
                        // Use withOpacity for older Flutter, withValues for 3.27+
                        color: AppColors.backgroundBase.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: .only(top: 10, left: 16, right: 16),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),

              itemBuilder: (context, index) => EventContainer(
                width: double.infinity,
                heading: "heading",
                tag: "Night Life",
                image: "image",
                date: "Date",
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
