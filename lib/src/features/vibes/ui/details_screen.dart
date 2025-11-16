import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/vibes/ui/components/gallery.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VendorDetailsScreen extends StatefulWidget {
  const VendorDetailsScreen({super.key});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  // <-- track if pinned
  final pageController = PageController();
  bool isBarCollapsed = false;
  final data = [
    "🍸 Full Bar",
    "🕺 Dance Floor",
    "🌃 Rooftop",
    "👔 Smart Casual",
    "🎧 DJ Set",
  ];
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  bool _isCollapsedFromSheet = false;
  final double _collapseThreshold = 0.98;

  @override
  void initState() {
    super.initState();
    _sheetController.addListener(() {
      final bool next = _sheetController.size >= _collapseThreshold;
      if (next != _isCollapsedFromSheet) {
        setState(() {
          _isCollapsedFromSheet = next;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: FloatingActionButton.large(
        elevation: 0,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return PickGuestSheet(
                onPressed: () => context.push("/create-booking"),
              );
            },
          );
        },
        child: Text("Book"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N7x8cmFuZG9tfGVufDB8fDB8fHww&fm=jpg&q=60&w=3000",
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),

          NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                title: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _isCollapsedFromSheet
                      ? Text("Blah blah", key: ValueKey('title'))
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
                actions: [
                  IconButton.filled(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "img/svg/share.svg",
                      package: "assets",
                    ),
                  ),

                  SizedBox(width: 9),
                  IconButton.filled(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "img/svg/favorite.svg",
                      package: "assets",
                    ),
                  ),
                ],
              ),
            ],
            body: DraggableScrollableSheet(
              controller: _sheetController,
              maxChildSize: .98,
              initialChildSize: .3,
              minChildSize: .3,
              snap: true,
              snapSizes: const [0.6, 0.8, 0.98], // tweak as you like

              builder: (context, scrollController) => Material(
                color: Colors.transparent,

                child: SmoothClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  smoothness: 1,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          SmoothClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            smoothness: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.backgroundBase,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      bottom: 12,
                                      top: 16,
                                    ),
                                    child: Row(
                                      spacing: 4,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .surfaceContainerLighter,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: Text(
                                            "NightLife",
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .surfaceContainerLighter,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: Text(
                                            "🔥 Lively",
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .surfaceContainerLighter,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: Text(
                                            "⏰ Happy Hour",
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cairo Jazz Club",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(height: 12),

                                            Text(
                                              "📍 197, 26th of July Street, Agouza, Giza",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SmoothContainer(
                                          padding: EdgeInsets.all(6),
                                          color: AppColors.signalFunSuccess,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          smoothness: 1,
                                          child: Row(
                                            spacing: 6,
                                            children: [
                                              Text(
                                                "4.5",
                                                style: AppTextStyles(context)
                                                    .captionBold
                                                    .copyWith(
                                                      color:
                                                          AppColors.textSuccess,
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
                                  SizedBox(height: 8),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Text(
                                          "1.5 KM away",
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
                                          "Casual Premium (400)",
                                          style: TextStyle(
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                11,
                                            color: AppColors.textBrand,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              "Open",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color: AppColors.textSuccess,
                                              ),
                                            ),
                                            Text(
                                              "6:30 PM to 03:29 AM",
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
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
                                            color: AppColors
                                                .surfaceContainerLighter,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
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
                                                      AppTextStyles(
                                                        context,
                                                      ).accumulator *
                                                      12,
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "HYDEX PERKS",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: TicketWidget(
                                      width:
                                          (MediaQuery.widthOf(context) / 375) *
                                          282,
                                      height:
                                          (MediaQuery.heightOf(context) / 710) *
                                          137,
                                      color: Colors.red,
                                      isCornerRounded: true,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 12),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              "Complimentary",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    10,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              "Drinks",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    20,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              "7:30pm to 10:00pm today",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    11,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                          AppTextStyles(
                                                            context,
                                                          ).accumulator *
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          AppTextStyles(
                                                            context,
                                                          ).accumulator *
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: SmoothClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      smoothness: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 8,
                                        children: [
                                          Text(
                                            "About".toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textSecondary,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  16,
                                            ),
                                          ),
                                          ReadMoreText(
                                            "Enjoy a smooth nightlife experience at one of Egypt’s most iconic clubs, vibrant music, crafted cocktails, and unforgettable evenings.Enjoy a smooth nightlife experience at one of Egypt’s most iconic clubs, vibrant music, crafted cocktails, and unforgettable evenings.Enjoy a smooth nightlife experience at one of Egypt’s most iconic clubs, vibrant music, crafted cocktails, and unforgettable evenings.Enjoy a smooth nightlife experience at one of Egypt’s most iconic clubs, vibrant music, crafted cocktails, and unforgettable evenings.",
                                            trimMode: TrimMode.Line,
                                            trimLines: 3,
                                            delimiter: "....",
                                            colorClickableText:
                                                AppColors.textPrimary,
                                            trimCollapsedText: 'Read more',
                                            moreStyle: AppTextStyles(
                                              context,
                                            ).captionBold,
                                            lessStyle: AppTextStyles(
                                              context,
                                            ).captionBold,
                                            trimExpandedText: 'Read less',
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  14,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: SmoothClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      smoothness: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Experiences".toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textSecondary,
                                              fontSize:
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: data
                                                .map(
                                                  (e) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .surfaceContainer,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            100,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                        fontSize:
                                                            AppTextStyles(
                                                              context,
                                                            ).accumulator *
                                                            12,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Upcoming Events".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  SizedBox(
                                    height: 202,
                                    child: ListView.separated(
                                      itemCount: 3,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 8),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: 330,
                                          child: EventContainer(
                                            heading:
                                                "Zeft Funk x Moenes x Jess ",
                                            discount: 40,
                                            image:
                                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                                            avatarImage:
                                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                                            date: "Sat, 4 Oct, 5:00PM",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Menu & Cuisines".toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textSecondary,
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                16,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "🍽️ North Indian, Birarny, Seafood, Kebab, Italian, Chinese, Bevareges",
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  SizedBox(
                                    height: 200,
                                    child: ListView.separated(
                                      itemCount: 3,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),

                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 8),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          spacing: 12,
                                          children: [
                                            SmoothContainer(
                                              width: 165,
                                              height: 168,
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              smoothness: 1,
                                            ),
                                            Text(
                                              "Happy Hour",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Gallery",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  GridView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 12,
                                          crossAxisSpacing: 12,
                                        ),
                                    itemBuilder: (context, index) {
                                      return OpenContainer(
                                        closedColor: Colors.transparent,
                                        openBuilder: (context, action) =>
                                            Gallery(),
                                        closedBuilder: (context, _) {
                                          return SmoothContainer(
                                            color: Colors.red,
                                            width: 165,

                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            smoothness: 1,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 110,
                  color: AppColors.backgroundBase.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
