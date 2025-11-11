import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/location/ui/location_required.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/event_details.dart';
import 'package:hydex/src/features/vibes/ui/details_screen.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class VibesScreen extends ConsumerStatefulWidget {
  const VibesScreen({super.key});

  @override
  ConsumerState<VibesScreen> createState() => _VibesScreenState();
}

class _VibesScreenState extends ConsumerState<VibesScreen> {
  final headingPageController = PageController();
  int currentIndex = 0;
  int adIndex = 0;

  @override
  void dispose() {
    headingPageController.dispose();
    super.dispose();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMMM y hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final featuredEvents = ref.watch(
      getBannersProvider(type: BannerType.featured),
    );
    final promotionalEvents = ref.watch(
      getBannersProvider(type: BannerType.promotional),
    );

    final categories = ref.watch(getEventCategoriesProvider);

    return Scaffold(
      body: LocationRequired(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              featuredEvents.when(
                data: (data) {
                  if (data.isEmpty) {
                    return SizedBox(height: 100);
                  }
                  return Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            height: constraints.maxWidth > 600
                                ? 350 * 1.5
                                : 350,
                            child: PageView.builder(
                              itemCount: data.length,
                              controller: headingPageController,
                              onPageChanged: (value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => context.push("/event/details"),
                                  child: Stack(
                                    children: [
                                      ImageOrVideoWidget(
                                        videoURL: data[index].video,
                                        imageURL: data[index].image,
                                      ),
                                      Container(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 60,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              data[index].subtitle,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              data[index].headline,
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  formatDateTime(
                                                    data[index]
                                                        .campaignStartDate,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        12,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                            ),
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .textInverse,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        "Reserve",
                                                        style: AppTextStyles(context)
                                                            .smallSemibold
                                                            .copyWith(
                                                              color: AppColors
                                                                  .textInverse,
                                                            ),
                                                      ),
                                                    ],
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
                              },
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 145,
                        left: 16,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: headingPageController,
                            count: data.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white.withValues(alpha: 0.2),
                              dotHeight: 10,
                              dotWidth: 6,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 16,
                        right: 16,
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HYDEX",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                              Row(
                                spacing: 12,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.push("/location");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 20,
                                          ),
                                          Text(
                                            "Egypt",
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => context.push("/notifications"),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      child: SvgPicture.asset(
                                        "img/svg/notification.svg",
                                        package: "assets",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                error: (e, s) => Center(child: Text("Error")),
                loading: () =>
                    Center(child: CircularProgressIndicator.adaptive()),
              ),
              Transform.translate(
                offset: Offset(0, -45),
                child: Container(
                  width: MediaQuery.widthOf(context),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundBase,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff232325),
                        offset: Offset(0, -3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 600) {
                                return SizedBox(
                                  height: 130 * 1.5,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    children: [
                                      SmoothContainer(
                                        width: 150 * 1.5,
                                        height: 130 * 1.5,
                                        color: AppColors.surfaceContainer,
                                        smoothness: 1,
                                        padding: EdgeInsets.all(12),
                                        borderRadius: BorderRadius.circular(24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "img/svg/fire.svg",
                                              package: "assets",
                                              colorFilter: ColorFilter.mode(
                                                AppColors.buttonPrimary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Happening",
                                              style: TextStyle(
                                                color: AppColors.textSecondary,
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                              ),
                                            ),
                                            Text(
                                              "Tonight",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      SmoothContainer(
                                        width: 150 * 1.5,
                                        height: 130 * 1.5,
                                        color: AppColors.surfaceContainer,

                                        smoothness: 1,
                                        padding: EdgeInsets.all(12),
                                        borderRadius: BorderRadius.circular(24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "img/svg/location_pin.svg",
                                              package: "assets",
                                            ),
                                            Spacer(),
                                            Text(
                                              "Happening",
                                              style: TextStyle(
                                                color: AppColors.textSecondary,

                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                              ),
                                            ),
                                            Text(
                                              "Near me",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      SmoothContainer(
                                        width: 150 * 1.5,
                                        height: 130 * 1.5,
                                        color: AppColors.surfaceContainer,

                                        smoothness: 1,
                                        padding: EdgeInsets.all(12),
                                        borderRadius: BorderRadius.circular(24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spacer(),
                                            Text(
                                              "Search &",
                                              style: TextStyle(
                                                color: AppColors.textSecondary,

                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                              ),
                                            ),
                                            Text(
                                              "Explore",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: 130,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  children: [
                                    SmoothContainer(
                                      width: 150,
                                      height: 130,
                                      color: AppColors.surfaceContainer,
                                      smoothness: 1,
                                      padding: EdgeInsets.all(12),
                                      borderRadius: BorderRadius.circular(24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            height: 24,
                                            "img/svg/fire.svg",
                                            package: "assets",
                                            colorFilter: ColorFilter.mode(
                                              AppColors.buttonPrimary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Happening",
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.w100,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "Tonight",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    SmoothContainer(
                                      width: 150,
                                      height: 110,
                                      color: AppColors.surfaceContainer,

                                      smoothness: 1,
                                      padding: EdgeInsets.all(12),
                                      borderRadius: BorderRadius.circular(24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            height: 24,
                                            "img/svg/location_pin.svg",
                                            package: "assets",
                                          ),
                                          Spacer(),
                                          Text(
                                            "Happening",
                                            style: TextStyle(
                                              color: AppColors.textSecondary,

                                              fontWeight: FontWeight.w100,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "Near me",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    SmoothContainer(
                                      width: 150,
                                      height: 130,
                                      color: AppColors.surfaceContainer,

                                      smoothness: 1,
                                      padding: EdgeInsets.all(12),
                                      borderRadius: BorderRadius.circular(24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            "Search &",
                                            style: TextStyle(
                                              color: AppColors.textSecondary,

                                              fontWeight: FontWeight.w100,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "Explore",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          AllEventsWidget(),
                          promotionalEvents.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return SizedBox.shrink();
                              }
                              return Column(
                                children: [
                                  SizedBox(height: 24),
                                  CarouselSlider(
                                    items: data
                                        .map(
                                          (e) => OpenContainer(
                                            closedColor:
                                                AppColors.backgroundBase,
                                            closedElevation: 0,
                                            closedBuilder: (context, _) {
                                              return SmoothClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                smoothness: 1,
                                                child: e.image != null
                                                    ? Container(
                                                        width: 320,
                                                        color: AppColors
                                                            .surfaceContainer,
                                                        child: _buildImage(
                                                          e.image!,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 320,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .surfaceContainer,
                                                        ),
                                                      ),
                                              );
                                            },
                                            openBuilder: (context, _) =>
                                                SizedBox.shrink(),
                                          ),
                                        )
                                        .toList(),

                                    options: CarouselOptions(
                                      height: 107,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration: Duration(
                                        milliseconds: 800,
                                      ),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          adIndex = index;
                                        });
                                      },
                                      enlargeFactor: 0.3,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  SizedBox(height: 17),
                                  Center(
                                    child: AnimatedSmoothIndicator(
                                      count: data.length,
                                      activeIndex: adIndex,
                                      effect: ExpandingDotsEffect(
                                        activeDotColor: Colors.white,
                                        dotColor: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        dotHeight: 10,
                                        dotWidth: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (e, s) {
                              log(
                                "[Error Promotional]",
                                error: e,
                                stackTrace: s,
                              );
                              return Center(child: Text("Error"));
                            },
                            loading: () =>
                                Center(child: CircularProgressIndicator()),
                          ),

                          SizedBox(height: 42),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Explore our vendors",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Unforgettable places. Trusted hosts.",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            14,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStatePropertyAll(
                                      AppColors.textPrimary,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Explore all",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),

                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              itemCount: 3,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return OpenContainer(
                                  closedColor: AppColors.backgroundBase,
                                  closedElevation: 0,
                                  closedBuilder: (context, _) {
                                    return SizedBox(
                                      width: 240,
                                      child: EventContainer(
                                        heading: "Heading Test",
                                        description: "description",
                                        image:
                                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                                        tag: "Sports",
                                        avatarImage:
                                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                                        date: "date",
                                      ),
                                    );
                                  },
                                  openBuilder: (context, _) =>
                                      VendorDetailsScreen(),
                                );
                              },
                            ),
                          ),
                          Column(
                            children: [
                              categories.when(
                                data: (data) {
                                  if (data.isEmpty) {
                                    return SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        SizedBox(height: 41),

                                        Text(
                                          "HydeX Curated",
                                          style: TextStyle(
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "The finest venues and events in one place.",
                                          style: TextStyle(
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                14,
                                            color: Color(0xff858585),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          spacing: 12,
                                          children: [
                                            for (
                                              int index = 0;
                                              index < data.length;
                                              index++
                                            ) ...[
                                              CuratedContainer(
                                                reverse: index % 2 == 0,
                                                heading: data[index].name,
                                                endText:
                                                    data[index].description,
                                                image: data[index].image ?? "",
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                error: (e, s) {
                                  log(
                                    "[Event Categories]",
                                    error: e,
                                    stackTrace: s,
                                  );
                                  return Text("Error");
                                },
                                loading: () {
                                  return Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllEventsWidget extends ConsumerWidget {
  const AllEventsWidget({super.key});
  final pageSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch one page (or a merged list if you handle pagination manually)
    final eventsAsync = ref.watch(getEventsProvider(page: 1));
    final user = ref.watch(currentUserProvider);
    return eventsAsync.when(
      data: (events) {
        if (events.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user.when(
                        skipError: true,
                        error: (error, stackTrace) => Text("Error Name"),
                        loading: () => Container(),
                        data: (data) => Text.rich(
                          TextSpan(
                            text: "${data?.fullName}, ",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 18,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [
                              TextSpan(
                                text: "Your Picks",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Personalized plans just for you",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        AppColors.textPrimary,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Discover all",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return OpenContainer(
                    openBuilder: (context, _) =>
                        EventDetailScreen(event: event),
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    closedBuilder: (context, _) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: EventContainer(
                        tag: event.tags.firstOrNull,
                        discount: 50,
                        avatarImage: event.media.first,
                        date: event.createdAt.formatDate(),
                        heading: event.name,
                        image: event.media.firstOrNull,
                        description: event.description,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => SizedBox.shrink(),
      error: (e, s) {
        debugPrint("Events Error: $e");
        return const Center(child: Text('Failed to load events'));
      },
    );
  }
}

class ImageOrVideoWidget extends StatefulWidget {
  const ImageOrVideoWidget({super.key, this.videoURL, this.imageURL});
  final String? videoURL;
  final String? imageURL;

  @override
  State<ImageOrVideoWidget> createState() => _ImageOrVideoWidgetState();
}

class _ImageOrVideoWidgetState extends State<ImageOrVideoWidget> {
  late final VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoURL != null) {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoURL!),
      );
      _videoController.setLooping(true);
      _videoController.setVolume(0);
      _videoController.initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController.play();
        });
      });
    }
  }

  @override
  void dispose() {
    if (widget.videoURL != null) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoURL != null) {
      return _isVideoInitialized
          ? VideoPlayer(_videoController)
          : const Center(child: CircularProgressIndicator());
    }

    if (widget.imageURL != null) {
      return SizedBox(
        height: double.infinity,
        child: _buildImage(widget.imageURL!),
      );
    }

    return SizedBox.shrink();
  }
}

class CuratedContainer extends StatelessWidget {
  const CuratedContainer({
    super.key,
    this.reverse = false,
    required this.heading,
    required this.endText,
    required this.image,
  });
  final bool reverse;
  final String heading, endText;
  final String image;
  final Color containerColor = AppColors.surfaceContainer;
  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      smoothness: 1,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(color: containerColor),
        child: IntrinsicHeight(
          child: reverse
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: 134,
                          child: _buildImage(image),
                        ),
                        Container(
                          width: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                containerColor.withValues(alpha: 0.5),
                                containerColor,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   text,
                            //   style: TextStyle(
                            //     fontSize: AppTextStyles(context).accumulator * 14,
                            //     fontWeight: FontWeight.w100,
                            //   ),
                            // ),
                            Text(
                              heading,
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              endText,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   text,
                            //   style: TextStyle(
                            //     fontSize: AppTextStyles(context).accumulator * 14,
                            //     fontWeight: FontWeight.w100,
                            //   ),
                            // ),
                            Expanded(
                              child: Text(
                                heading,
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),

                            Text(
                              endText,
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: 134,
                          child: _buildImage(image),
                        ),
                        Container(
                          width: 134,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.transparent,
                                containerColor.withValues(alpha: 0.5),
                                containerColor,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
    this.onView,
    required this.heading,
    this.description,
    required this.image,
    this.tag,
    required this.avatarImage,
    this.discount,

    required this.date,
  });
  final VoidCallback? onView;
  final String heading, date, avatarImage;
  final String? image, tag, description;
  final int? discount;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onView,
      child: SmoothClipRRect(
        borderRadius: BorderRadius.circular(24),
        smoothness: 1,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CachedNetworkImage(
              imageUrl: image ?? '',
              width: 330,
              height: MediaQuery.heightOf(context) * 0.28,

              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.4),
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 330,
              height: MediaQuery.heightOf(context) * 0.28,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tag != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    avatarImage,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.72),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tag!,
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Spacer(),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Visibility(
                        visible: discount != null,
                        child: SmoothClipRRect(
                          smoothness: 1,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 120,

                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff201233),
                                  AppColors.buttonPrimary,
                                ],
                              ),
                            ),
                            child: Text(
                              "$discount% OFF Entry Fees",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    date,
                                    style: TextStyle(
                                      color: AppColors.textBrand,
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          11,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      "img/svg/favorite.svg",
                                      package: "assets",
                                      width: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                heading,
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              description != null
                                  ? SizedBox(
                                      width: 250,
                                      child: Text(
                                        description!,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize:
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
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
    );
  }
}

final Map<String, Uint8List> _imageCache = {};
Widget _buildImage(String imageData) {
  if (imageData.startsWith('data:image') ||
      (!imageData.startsWith('http://') && !imageData.startsWith('https://'))) {
    // Base64 image - decode once and cache
    try {
      // Check cache first
      if (!_imageCache.containsKey(imageData)) {
        String base64String = imageData;
        if (imageData.contains(',')) {
          base64String = imageData.split(',')[1];
        }
        _imageCache[imageData] = base64Decode(base64String);
      }

      return Image.memory(
        _imageCache[imageData]!,

        fit: BoxFit.cover,
        gaplessPlayback: true, // Prevents flickering during rebuilds
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      );
    } catch (e) {
      return Center(
        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
      );
    }
  } else {
    // URL image
    return SizedBox(
      child: CachedNetworkImage(
        imageUrl: imageData,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      ),
    );
  }
}
