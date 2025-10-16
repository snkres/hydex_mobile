import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VendorDetailsScreen extends StatelessWidget {
  VendorDetailsScreen({super.key});

  final pageController = PageController();
  final data = [
    "🍸 Full Bar",
    "🕺 Dance Floor",
    "🌃 Rooftop",
    "👔 Smart Casual",
    "🎧 DJ Set",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: (MediaQuery.heightOf(context) / 710) * 507,
                  child: PageView.builder(
                    itemCount: 3,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        color: index % 2 == 0 ? Colors.red : Colors.amber,
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomBackButton(),
                            Spacer(),
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
                            SizedBox(width: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, -50),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withValues(alpha: 0.2),
                      dotHeight: 10,
                      dotWidth: 6,
                    ),
                  ),
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
                            padding: const EdgeInsets.only(
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
                                    color: AppColors.surfaceContainerLighter,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    "NightLife",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
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
                                    color: AppColors.surfaceContainerLighter,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    "🔥 Lively",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
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
                                    color: AppColors.surfaceContainerLighter,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    "⏰ Happy Hour",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cairo Jazz Club",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            24,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(height: 12),

                                    Text(
                                      "📍 197, 26th of July Street, Agouza, Giza",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
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
                                        style: AppTextStyles(context)
                                            .captionBold
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
                          SizedBox(height: 8),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "1.5 KM away",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  "Casual Premium (400)",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 11,
                                    color: AppColors.textBrand,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Open",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                        color: AppColors.textSuccess,
                                      ),
                                    ),
                                    Text(
                                      "6:30 PM to 03:29 AM",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "HYDEX PERKS",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TicketWidget(
                              width: (MediaQuery.widthOf(context) / 375) * 282,
                              height:
                                  (MediaQuery.heightOf(context) / 710) * 137,
                              color: Colors.red,
                              isCornerRounded: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            AppTextStyles(context).accumulator *
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
                                            AppTextStyles(context).accumulator *
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
                                            AppTextStyles(context).accumulator *
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
                                          padding: const EdgeInsets.symmetric(
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
                                              fontWeight: FontWeight.w700,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SmoothClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              smoothness: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  Text(
                                    "About".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          16,
                                    ),
                                  ),
                                  Text(
                                    "Enjoy a smooth nightlife experience at one of Egypt’s most iconic clubs, vibrant music, crafted cocktails, and unforgettable evenings.",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SmoothClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              smoothness: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Experiences".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                      fontSize:
                                          AppTextStyles(context).accumulator *
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
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.surfaceContainer,
                                              borderRadius:
                                                  BorderRadius.circular(100),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Upcoming Events".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),

                          SizedBox(
                            height: 202,
                            child: ListView.separated(
                              itemCount: 3,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 330,
                                  child: EventContainer(
                                    heading: "Zeft Funk x Moenes x Jess ",
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Menu & Cuisines".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 16,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "🍽️ North Indian, Birarny, Seafood, Kebab, Italian, Chinese, Bevareges",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          SizedBox(
                            height: 196,
                            child: ListView.separated(
                              itemCount: 3,
                              padding: const EdgeInsets.symmetric(
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
                                      borderRadius: BorderRadius.circular(24),
                                      smoothness: 1,
                                    ),
                                    Text(
                                      "Happy Hour",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Gallery",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          GridView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              return SmoothContainer(
                                color: Colors.red,
                                width: 165,

                                borderRadius: BorderRadius.circular(24),
                                smoothness: 1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
