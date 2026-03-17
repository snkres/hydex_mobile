import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final filters = const ["All", "Reservations", "Invites", "Other"];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,

              child: Row(
                children: [
                  const CustomBackButton(),
                  SizedBox(width: 45),
                  SvgPicture.asset(
                    "img/svg/notification.svg",
                    package: "assets",
                  ),
                  SizedBox(width: 8),
                  Text(
                    "My Notifications",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverFillRemaining(
            child: Column(
              children: [
                SizedBox(
                  height: 37,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
