import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/profile/ui/components/back_container.dart';
import 'package:hydex/src/features/profile/ui/components/front_container.dart';
import 'package:hydex/src/features/profile/ui/components/history.dart';
import 'package:hydex/src/features/profile/ui/components/passport.dart';
import 'package:hydex/src/features/profile/ui/components/upcoming_event.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
    // _tabController.addListener(checkIfUserInHistory);
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
    final currentUser = ref.watch(currentUserProvider);
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
                              // SizedBox(height: 36),
                              // SmoothContainer(
                              //   width: 67,
                              //   height: 67,
                              //   color: Colors.red,
                              //   borderRadius: .circular(16),
                              //   smoothness: 1,
                              // ),
                              SizedBox(height: 28),
                              FlipCard(
                                rotateSide: .right,
                                controller: FlipCardController(),
                                frontWidget: FrontContainer(
                                  name: data?.fullName ?? "",
                                  nationality: data?.nationality ?? "",
                                  createdAt: data?.createdAt ?? .now(),
                                ),
                                backWidget: BackContainer(),
                                onTapFlipping: true,
                                animationDuration: Duration(milliseconds: 600),
                              ),

                              // Text(
                              //   data?.fullName ?? "",
                              //   style: TextStyle(
                              //     fontSize:
                              //         AppTextStyles(context).accumulator * 24,
                              //     fontWeight: .w600,
                              //   ),
                              // ),
                              SizedBox(height: 36),
                              // Visibility(
                              //   visible: isUserInHistory,
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: 16,
                              //     ),
                              //     child: Row(
                              //       spacing: 8,
                              //       children: [
                              //         Expanded(
                              //           child: SmoothContainer(
                              //             borderRadius: .circular(16),
                              //             side: BorderSide(
                              //               color: AppColors.borderDefault,
                              //             ),
                              //             smoothness: 1,
                              //             padding: .all(12),
                              //             child: Column(
                              //               crossAxisAlignment: .start,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       .spaceBetween,
                              //                   children: [
                              //                     Text(
                              //                       "Upcoming",
                              //                       style: TextStyle(
                              //                         fontSize:
                              //                             AppTextStyles(
                              //                               context,
                              //                             ).accumulator *
                              //                             14,
                              //                         color: AppColors
                              //                             .textSecondary,
                              //                       ),
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       "img/svg/calendar.svg",
                              //                       package: "assets",
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 SizedBox(height: 16),
                              //                 Text(
                              //                   upcoming.toString(),
                              //                   style: TextStyle(
                              //                     fontWeight: .w600,
                              //                     fontSize:
                              //                         AppTextStyles(
                              //                           context,
                              //                         ).accumulator *
                              //                         18,
                              //                     color: AppColors.textPrimary,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: SmoothContainer(
                              //             borderRadius: .circular(16),
                              //             side: BorderSide(
                              //               color: AppColors.borderDefault,
                              //             ),
                              //             smoothness: 1,
                              //             padding: .all(12),
                              //             child: Column(
                              //               crossAxisAlignment: .start,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       .spaceBetween,
                              //                   children: [
                              //                     Text(
                              //                       "Invites",
                              //                       style: TextStyle(
                              //                         fontSize:
                              //                             AppTextStyles(
                              //                               context,
                              //                             ).accumulator *
                              //                             14,
                              //                         color: AppColors
                              //                             .textSecondary,
                              //                       ),
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       "img/svg/invites.svg",
                              //                       package: "assets",
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 SizedBox(height: 16),
                              //                 Text(
                              //                   "0",
                              //                   style: TextStyle(
                              //                     fontWeight: .w600,
                              //                     fontSize:
                              //                         AppTextStyles(
                              //                           context,
                              //                         ).accumulator *
                              //                         18,
                              //                     color: AppColors.textPrimary,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
                      // Tab(text: "Passport"),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,

              children: [UpcomingEventSection(), History()],
            ),
          );
        },
        error: (e, s) => Center(child: Text("Error")),
        loading: () => Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
