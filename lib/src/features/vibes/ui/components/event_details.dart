import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/ui/components/adventures.dart';
import 'package:hydex/src/features/vibes/ui/components/nightlife.dart';
import 'package:hydex/src/features/vibes/ui/components/show.dart';
import 'package:hydex/src/features/vibes/ui/components/sports_section.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:readmore/readmore.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  // <-- track if pinned
  final pageController = PageController();
  bool isBarCollapsed = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliverSnap(
        collapsedBarHeight: 70,
        leading: CustomBackButton(),
        actions: [
          IconButton.filled(
            onPressed: () {},
            icon: SvgPicture.asset("img/svg/share.svg", package: "assets"),
          ),

          SizedBox(width: 9),
          IconButton.filled(
            onPressed: () {},
            icon: SvgPicture.asset("img/svg/favorite.svg", package: "assets"),
          ),
          SizedBox(width: 16),
        ],
        collapsedBackgroundColor: Colors.transparent,
        expandedBackgroundColor: Colors.transparent,
        backdropWidget: Stack(
          children: [
            PageView.builder(
              itemCount: 3,
              controller: pageController,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,

                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tfGVufDB8fDB8fHww&fm=jpg&q=60&w=3000",
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        onCollapseStateChanged: (isCollapsed, scrollingOffset, maxExtent) {
          setState(() {
            isBarCollapsed = isCollapsed;
          });
        },

        expandedContentHeight: (MediaQuery.heightOf(context) / 710) * 507,
        expandedContent: Align(
          alignment: Alignment.bottomCenter,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.white,
              dotColor: Colors.white.withValues(alpha: 0.2),
              dotHeight: 10,
              dotWidth: 6,
            ),
          ),
        ),
        collapsedContent: Center(
          child: Text(
            "Cairo Jazz Club",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            SmoothClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              smoothness: 1,
              child: Container(
                decoration: BoxDecoration(color: AppColors.backgroundBase),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 12, top: 16),
                      child: Row(
                        spacing: 4,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLighter,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "NightLife",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLighter,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "Event",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLighter,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "🔥 Lively",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLighter,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "⏰ Happy Hour",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cairo Jazz Club",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 12),

                          Text(
                            "📍 197, 26th of July Street, Agouza, Giza",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 10,
                        children: [
                          Text(
                            "1.5 KM away",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            "Casual Premium (400)",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 11,
                              color: AppColors.textBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Text(
                                "6 hours",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: AppColors.textSuccess,
                                ),
                              ),
                              Text(
                                "12 Oct, 9:00 PM – 13 Oct, 3:00 AM",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLighter,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                SvgPicture.asset(
                                  "img/svg/directions.svg",
                                  package: "assets",
                                  width: 13,
                                ),
                                Text(
                                  "Directions",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "HYDEX PERKS",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          fontSize: AppTextStyles(context).accumulator * 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TicketWidget(
                        width: (MediaQuery.widthOf(context) / 375) * 282,
                        height: (MediaQuery.heightOf(context) / 710) * 137,
                        color: Colors.red,
                        isCornerRounded: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Complimentary",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Drinks",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 20,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "7:30pm to 10:00pm today",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 11,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Lorem ipsum dolor sit amet,Lorem",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            11,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Book",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            11,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(
                                      "img/svg/book_ticket.svg",
                                      package: "assets",
                                      width: 10,
                                      height: 10,
                                    ),
                                    SizedBox(width: 11),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SmoothClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        smoothness: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              "About the event".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                              ),
                            ),
                            ReadMoreText(
                              "A high-energy night of deep house and live performances A high-energy night of deep house and live performances.",
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              delimiter: "....",
                              colorClickableText: AppColors.textPrimary,
                              trimCollapsedText: 'Read more',
                              moreStyle: AppTextStyles(context).captionBold,
                              lessStyle: AppTextStyles(context).captionBold,
                              trimExpandedText: 'Read less',
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SmoothClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        smoothness: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Organized by".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            SmoothContainer(
                              smoothness: 1,
                              borderRadius: BorderRadiusGeometry.circular(16),
                              color: AppColors.surfaceContainer,
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 17,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmoothContainer(
                                          width: 47,
                                          height: 47,
                                          smoothness: 1,
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        Text(
                                          "Hady El Mawkoos",
                                          style: AppTextStyles(
                                            context,
                                          ).smallMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rating",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            SmoothContainer(
                                              padding: EdgeInsets.all(6),
                                              color: AppColors.signalFunSuccess,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              smoothness: 1,
                                              child: Row(
                                                spacing: 6,
                                                children: [
                                                  Text(
                                                    "4.5",
                                                    style:
                                                        AppTextStyles(
                                                          context,
                                                        ).captionBold.copyWith(
                                                          color: AppColors
                                                              .textSuccess,
                                                        ),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 11,
                                                    color:
                                                        AppColors.textSuccess,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(
                                          color: AppColors.borderDefault,
                                          height: 4,
                                        ),
                                        SizedBox(height: 8),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text(
                                              "Hosted events",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            Text(
                                              "17",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),

                                        Divider(
                                          color: AppColors.borderDefault,
                                          height: 4,
                                        ),
                                        SizedBox(height: 8),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Hosting",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),

                                            Text(
                                              "2.2 Years",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textPrimary,
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
                      ),
                    ),
                    SizedBox(height: 24),

                    // NightLifeSection(),
                    // SportsSection(),
                    // AdventureScreen(),
                    ShowSection(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "VENUE".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              SmoothContainer(
                                width: 32,
                                height: 32,
                                color: Colors.red,
                                smoothness: 1,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cairo Jazz Club",
                                      style: AppTextStyles(context).smallBold,
                                    ),
                                    Text(
                                      "This is a description for cairojazz club",
                                      style: AppTextStyles(context)
                                          .captionRegular
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SmoothContainer(
                                padding: EdgeInsets.all(6),
                                color: AppColors.signalFunSuccess,
                                borderRadius: BorderRadius.circular(6),
                                smoothness: 1,
                                child: Row(
                                  spacing: 6,
                                  children: [
                                    Text(
                                      "4.5",
                                      style: AppTextStyles(context).captionBold
                                          .copyWith(
                                            color: AppColors.textSuccess,
                                          ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 11,
                                      color: AppColors.textSuccess,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return SmoothContainer(
                                width: 180,
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Things to know".toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              ListTile(
                                leading: SvgPicture.asset(
                                  "img/svg/ar_.svg",
                                  width: 15,
                                  height: 15,
                                  package: "assets",
                                ),
                                title: Text(
                                  "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
                                  style: AppTextStyles(context).smallRegular,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Divider(color: AppColors.borderDefault),
                              ),
                              ListTile(
                                leading: SvgPicture.asset(
                                  "img/svg/ar_.svg",
                                  width: 15,
                                  height: 15,
                                  package: "assets",
                                ),
                                title: Text(
                                  "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
                                  style: AppTextStyles(context).smallRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
