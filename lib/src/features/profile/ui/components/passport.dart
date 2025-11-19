import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:smooth_corner/smooth_corner.dart';

class Passport extends StatefulWidget {
  const Passport({super.key});

  @override
  State<Passport> createState() => _PassportState();
}

class _PassportState extends State<Passport> {
  final filters = const ["All", "Reservations", "Invites", "Other"];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "24",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 30,
                      fontWeight: .w700,
                    ),
                  ),
                  Text(
                    "Total Experiences",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset("img/svg/routing.svg", package: "assets"),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 37,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return CustomChip(
                  title: filters[index],
                  isSelected: selectedFilter == filters[index],
                  onTap: () {
                    setState(() {
                      selectedFilter = filters[index];
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: filters.length,
            ),
          ),
          SizedBox(height: 16),
          SmoothClipRRect(
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFFA25BFF),

                              Color.fromARGB(255, 105, 59, 165),

                              Color(0xFF251343),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          "img/svg/pattern.svg",
                          package: "assets",
                          fit: BoxFit.cover,
                          color: AppColors.backgroundBase.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // foreground content
                SmoothContainer(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cairo Jazz Club",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "01",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nightlife",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 14,
                            ),
                          ),
                          Text(
                            "Visit(s)",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
