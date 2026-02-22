import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile/ui/components/back_container.dart';
import 'package:hydex/src/features/profile/ui/components/front_container.dart';
import 'package:hydex/src/features/profile/ui/components/history.dart';
import 'package:hydex/src/features/profile/ui/components/passport.dart';
import 'package:hydex/src/features/profile/ui/components/upcoming_event.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  bool isUserInHistory = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(checkIfUserInHistory);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void checkIfUserInHistory() {
    if (_tabController.index != 0) {
      setState(() {
        isUserInHistory = true;
      });
    } else {
      setState(() {
        isUserInHistory = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(getProfileProvider);
    return Scaffold(
      body: currentUser.when(
        data: (data) {
          return NestedScrollView(
            headerSliverBuilder: (context, builder) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: isUserInHistory ? 330 : 240,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: .infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "img/profile_light.png",
                                package: "assets",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SafeArea(
                          child: Column(
                            children: [
                              SizedBox(height: 28),
                              GestureDetector(
                                onTap: () => HapticFeedback.heavyImpact(),
                                child: FlipCard(
                                  rotateSide: .right,
                                  axis: .vertical,
                                  controller: FlipCardController(),
                                  frontWidget: FrontContainer(
                                    name: data.user.fullName.capitalize(),
                                    id: data.user.id
                                        .substring(0, 7)
                                        .toUpperCase(),
                                    nationality: data.user.nationality,
                                    createdAt: data.user.createdAt,
                                  ),
                                  backWidget: BackContainer(),
                                  onTapFlipping: true,
                                  animationDuration: Duration(
                                    milliseconds: 600,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),
                              Visibility(
                                visible: isUserInHistory,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      gradient: RadialGradient(
                                        radius: 2.7,
                                        colors: [
                                          Color(0xff511C96),
                                          Color(0xff101010),
                                        ],
                                      ),
                                      shape: RoundedSuperellipseBorder(
                                        borderRadius: .circular(16),
                                      ),
                                    ),
                                    padding: .symmetric(vertical: 16),
                                    child: IntrinsicHeight(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: .center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: .center,
                                              children: [
                                                Text(
                                                  data.summary.upcomingCount
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: .w600,
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        18,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "Upcoming",
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        14,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 32),

                                            SizedBox(
                                              height: 30,
                                              child: VerticalDivider(
                                                color: Colors.black.withValues(
                                                  alpha: 0.2,
                                                ),
                                                thickness: 1,

                                                width: 1,
                                              ),
                                            ),
                                            SizedBox(width: 32),
                                            Column(
                                              mainAxisAlignment: .center,
                                              children: [
                                                Text(
                                                  data.summary.invitesCount
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: .w600,
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        18,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "Invites",
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        14,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
                    controller: _tabController,
                    overlayColor: .all(Colors.transparent),

                    tabs: [
                      Tab(text: "Upcoming Events"),
                      Tab(text: "History"),
                      Tab(text: "Passport"),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,

              children: [UpcomingEventSection(), History(), Passport()],
            ),
          );
        },
        error: (e, s) {
          log("Couldn't load profile", error: e, stackTrace: s);
          return Center(child: Text("Error"));
        },
        loading: () => Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
