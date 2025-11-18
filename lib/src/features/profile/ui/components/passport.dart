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
          SmoothContainer(
            padding: .all(16),
            smoothness: 1,
            color: Colors.red,
            borderRadius: .circular(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CircleAvatar(),
                SizedBox(height: 32),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "Cairo Jazz Club",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 18,
                        fontWeight: .w900,
                      ),
                    ),
                    Text(
                      "01",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 18,
                        fontWeight: .w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,

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
    );
  }
}
