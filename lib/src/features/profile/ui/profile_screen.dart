import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/profile/ui/components/history.dart';
import 'package:hydex/src/features/profile/ui/components/passport.dart';
import 'package:hydex/src/features/profile/ui/components/upcoming_event.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, builder) {
            return [
              SliverAppBar(
                toolbarHeight: 220,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          "img/svg/pattern.svg",
                          fit: BoxFit.cover,
                          package: "assets",
                          color: AppColors.backgroundBase.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            SizedBox(height: 36),
                            SmoothContainer(
                              width: 67,
                              height: 67,
                              color: Colors.red,
                              borderRadius: .circular(16),
                              smoothness: 1,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Hady Soliman",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 24,
                                fontWeight: .w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Hydex Member",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelColor: Colors.white,
                  indicatorColor: AppColors.signalBrandSolid,

                  tabs: [
                    Tab(text: "Upcoming Events"),
                    Tab(text: "History"),
                    Tab(text: "Passport"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [UpcomingEvent(), History(), Passport()]),
        ),
      ),
    );
  }
}
