import 'dart:developer';

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
import 'package:hydex/core/ui/widgets/adaptive_image.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/location/ui/location_required.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/event_details.dart';
import 'package:hydex/src/features/vibes/ui/details_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
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
    final featuredEvents = ref.watch(getBannersProvider(type: .featured));
    final promotionalEvents = ref.watch(getBannersProvider(type: .promotional));

    final categories = ref.watch(getEventCategoriesProvider);
    return Scaffold(
      body: LocationRequired(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getBannersProvider(type: .featured));
            ref.invalidate(getBannersProvider(type: .promotional));
            ref.invalidate(getEventCategoriesProvider);

            await Future.wait([
              ref.read(getBannersProvider(type: .featured).future),
              ref.read(getBannersProvider(type: .promotional).future),
              ref.read(getEventCategoriesProvider.future),
            ]);
          },
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
                                    onTap: () {
                                      if (data[index].assignment.targetType
                                              .toValue() ==
                                          AssignmentStatus.vendor.toValue()) {
                                        context.pushNamed(
                                          "vendor_detail",
                                          pathParameters: {
                                            "id": data[index]
                                                .assignment
                                                .vendor!
                                                .id,
                                          },
                                        );
                                      } else {
                                        context.pushNamed(
                                          "event_detail",
                                          pathParameters: {
                                            "id": data[index]
                                                .assignment
                                                .event!
                                                .id,
                                          },
                                        );
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ImageOrVideoWidget(
                                            url:
                                                data[index].video ??
                                                data[index].image ??
                                                "",
                                          ),
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
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     context.push("/location");
                                    //   },
                                    //   child: Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //       vertical: 8,
                                    //       horizontal: 12,
                                    //     ),
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white.withValues(
                                    //         alpha: 0.2,
                                    //       ),
                                    //       borderRadius: BorderRadius.circular(
                                    //         100,
                                    //       ),
                                    //     ),
                                    //     child: Row(
                                    //       children: [
                                    //         Icon(
                                    //           Icons.keyboard_arrow_down,
                                    //           size: 20,
                                    //         ),
                                    //         Text(
                                    //           "Egypt",
                                    //           style: TextStyle(
                                    //             fontSize:
                                    //                 AppTextStyles(
                                    //                   context,
                                    //                 ).accumulator *
                                    //                 14,
                                    //             fontWeight: FontWeight.w500,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    GestureDetector(
                                      onTap: () =>
                                          context.push("/notifications"),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white
                                            .withValues(alpha: 0.2),
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
                  loading: () => Shimmer.fromColors(
                    baseColor: AppColors.backgroundOverlay,
                    highlightColor: AppColors.buttonSecondary,
                    child: Container(color: Colors.red, height: 350),
                  ),
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
                                return SizedBox(
                                  height: constraints.maxWidth > 600
                                      ? 130 * 1.5
                                      : 130,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            context.push("/happening_tonight"),
                                        child: SmoothContainer(
                                          width: 150,
                                          height: 130,
                                          color: AppColors.surfaceContainer,
                                          smoothness: 1,
                                          padding: EdgeInsets.all(12),
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              LottieBuilder.asset(
                                                "json/fire.json",
                                                package: "assets",
                                                height: 24,
                                              ),
                                              Spacer(),
                                              Text(
                                                "Happening",
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textSecondary,
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
                                      ),
                                      SizedBox(width: 6),
                                      GestureDetector(
                                        onTap: () =>
                                            context.push("/happening_nearby"),

                                        child: SmoothContainer(
                                          width: 150,
                                          height: 110,
                                          color: AppColors.surfaceContainer,

                                          smoothness: 1,
                                          padding: EdgeInsets.all(12),
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
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
                                                  color:
                                                      AppColors.textSecondary,

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
                                      ),
                                      SizedBox(width: 6),
                                      GestureDetector(
                                        onTap: () =>
                                            context.push("/", extra: 1),
                                        child: SmoothContainer(
                                          width: 150,
                                          height: 130,
                                          color: AppColors.surfaceContainer,

                                          smoothness: 1,
                                          padding: EdgeInsets.all(12),
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Spacer(),
                                              Text(
                                                "Search &",
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textSecondary,

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
                                            (e) => GestureDetector(
                                              onTap: () {
                                                if (e.assignment.targetType ==
                                                    AssignmentStatus.event) {
                                                  context.push(
                                                    "/event/${e.assignment.event?.id}",
                                                  );
                                                } else {
                                                  context.push(
                                                    "/vendor/${e.assignment.vendor?.id}",
                                                  );
                                                }
                                              },
                                              child: SmoothClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                smoothness: 1,
                                                child: e.image != null
                                                    ? Container(
                                                        width: 320,
                                                        color: AppColors
                                                            .surfaceContainer,
                                                        child: AdaptiveImage(
                                                          imageData: e.image!,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 320,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .surfaceContainer,
                                                        ),
                                                      ),
                                              ),
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

                            SizedBox(height: 43.5),

                            AllVendorsWidget(),
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
                                                  onTap: () => context.push(
                                                    "/category",
                                                    extra: data[index],
                                                  ),

                                                  heading: data[index].name,
                                                  endText:
                                                      data[index].description,
                                                  image:
                                                      data[index].image ?? "",
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
                                    return SizedBox(
                                      height: 300,
                                      child: ListView.separated(
                                        itemCount: 4,
                                        separatorBuilder: (_, _) =>
                                            SizedBox(height: 12),
                                        padding: .symmetric(horizontal: 16),
                                        itemBuilder: (context, index) =>
                                            Shimmer.fromColors(
                                              baseColor:
                                                  AppColors.backgroundOverlay,
                                              highlightColor:
                                                  AppColors.buttonSecondary,
                                              child: SmoothContainer(
                                                smoothness: 1,
                                                width: double.infinity,
                                                color:
                                                    AppColors.backgroundOverlay,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                      ),
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
      ),
    );
  }
}

class AllVendorsWidget extends ConsumerWidget {
  const AllVendorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendors = ref.watch(getVendorsProvider(page: 1));

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover Venues",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "Unforgettable places. Trusted hosts.",
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
                onPressed: () => context.push("/vendors"),

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

        vendors.when(
          data: (data) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: data.length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return OpenContainer(
                    closedColor: AppColors.backgroundBase,
                    closedElevation: 0,
                    closedBuilder: (context, _) {
                      return SizedBox(
                        width: 240,
                        child: EventContainer(
                          heading: data[index].name,
                          description: data[index].location.address,
                          image: data[index].media.first,
                          tag:
                              data[index].category?.name ??
                              data[index].tags.first,
                          avatarImage: data[index].logo,
                          date: data[index].priceType.label,
                        ),
                      );
                    },
                    openBuilder: (context, _) =>
                        VendorDetailsScreen(id: data[index].id),
                  );
                },
              ),
            );
          },
          error: (e, s) {
            log("Error Vendor:", error: e, stackTrace: s);
            return Text("Error");
          },
          loading: () {
            return SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: .horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 12),

                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.backgroundOverlay,
                    highlightColor: AppColors.buttonSecondary,
                    child: SmoothContainer(
                      color: Colors.green,
                      width: 240,
                      borderRadius: BorderRadius.circular(24),
                      smoothness: 1,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class AllEventsWidget extends ConsumerWidget {
  const AllEventsWidget({super.key});
  final pageSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(getEventsProvider(page: 1));
    final user = ref.watch(currentUserProvider);
    return Column(
      children: [
        eventsAsync.when(
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
                                  fontSize:
                                      AppTextStyles(context).accumulator * 18,
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
                        onPressed: () => context.push("/events"),
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
                            EventDetailScreen(id: event.id),
                        closedColor: Colors.transparent,
                        closedElevation: 0,
                        closedBuilder: (context, _) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: EventContainer(
                            tag:
                                event.category?.name ??
                                event.tags.first.capitalize(),
                            avatarImage: event.vendor.logo,

                            date: event.startTime.formatDate(),
                            heading: event.name,
                            image: event.media.firstOrNull,
                            description: event.location.address,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () {
            return Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.backgroundOverlay,
                          highlightColor: AppColors.buttonSecondary,

                          child: Container(
                            height: 35,
                            width: 200,
                            decoration: ShapeDecoration(
                              color: AppColors.backgroundOverlay,
                              shape: RoundedSuperellipseBorder(
                                borderRadius: .circular(12),
                              ),
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: AppColors.backgroundOverlay,
                          highlightColor: AppColors.buttonSecondary,

                          child: Container(
                            height: 35,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundOverlay,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 240,
                    child: ListView.separated(
                      scrollDirection: .horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: AppColors.backgroundOverlay,
                          highlightColor: AppColors.buttonSecondary,
                          child: SmoothContainer(
                            color: Colors.green,
                            width: 330,
                            borderRadius: BorderRadius.circular(24),
                            smoothness: 1,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          error: (e, s) {
            log("Events Error", error: e, stackTrace: s);
            return Text("Error");
          },
        ),
      ],
    );
  }
}

class ImageOrVideoWidget extends StatefulWidget {
  const ImageOrVideoWidget({super.key, required this.url});

  final String url;

  @override
  State<ImageOrVideoWidget> createState() => _ImageOrVideoWidgetState();
}

class _ImageOrVideoWidgetState extends State<ImageOrVideoWidget> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  bool get isVideo {
    return widget.url.toLowerCase().endsWith('.mp4');
  }

  @override
  void initState() {
    super.initState();

    if (isVideo) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..setLooping(true)
        ..setVolume(0);

      _videoController!.initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController!.play();
        });
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
      return _isVideoInitialized
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController!.value.size.width,
                  height: _videoController!.value.size.height,
                  child: VideoPlayer(_videoController!),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: double.infinity,
      child: AdaptiveImage(imageData: widget.url),
    );
  }
}

class CuratedContainer extends StatelessWidget {
  const CuratedContainer({
    super.key,
    required this.heading,
    required this.endText,
    required this.image,
    required this.onTap,
  });
  final String heading, endText;
  final String image;
  final Color containerColor = AppColors.surfaceContainer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SmoothClipRRect(
        smoothness: 1,
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 135,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AdaptiveImage(imageData: image),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,

                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            heading,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            endText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 11,
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: TextButton.icon(
                        onPressed: onTap,
                        iconAlignment: .end,
                        style: ButtonStyle(
                          backgroundColor: .all(
                            Colors.black.withValues(alpha: 0.3),
                          ),
                        ),
                        label: Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .w600,
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          fontWeight: .w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
    this.avatarImage,
    this.discount,
    this.width = 330,

    required this.date,
  });
  final VoidCallback? onView;
  final String heading, date;
  final String? image, tag, description, avatarImage;
  final int? discount;
  final double width;
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
              height: MediaQuery.heightOf(context) * 0.28,
              width: width,
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
              width: width,
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
                                avatarImage != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                              avatarImage!,
                                            ),
                                      )
                                    : CircleAvatar(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 16,
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
                                  AppColors.buttonSecondary,
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
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      date,
                                      maxLines: 1,
                                      overflow: .ellipsis,
                                      style: TextStyle(
                                        color: AppColors.textBrand,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            11,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        "img/svg/favorite.svg",
                                        package: "assets",
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                heading,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
