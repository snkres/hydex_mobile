import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/ui/components/confirm_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/create_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final List<String> data = const [
    "• Friday Night Live with DJ Ahmed",
    "• Saturday Groove Session with DJ Sara",
    "• Sunday Chill Vibes with DJ Omar",
  ];
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        EventContainer(),
                        SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "img/svg/location.svg",
                                      package: "assets",
                                      width: 20,
                                    ),
                                    SizedBox(height: 14),
                                    Text(
                                      "197, 26th of July St, Agouza, Giza",
                                      style: AppTextStyles(
                                        context,
                                      ).captionMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "img/svg/date.svg",
                                      package: "assets",
                                      width: 20,
                                    ),
                                    SizedBox(height: 14),
                                    Text(
                                      "Daily, 8:00 PM – 3:00 AM",
                                      style: AppTextStyles(
                                        context,
                                      ).captionMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        Container(
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 8,
                                children: [
                                  SvgPicture.asset(
                                    "img/svg/fee.svg",
                                    package: "assets",
                                    width: 24,
                                  ),
                                  Text(
                                    "Entry fee",
                                    style: AppTextStyles(context).captionMedium,
                                  ),
                                ],
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "400",
                                  style: AppTextStyles(context).primaryMedium
                                      .copyWith(fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text: " EGP",
                                      style: AppTextStyles(
                                        context,
                                      ).captionMedium,
                                    ),
                                    TextSpan(
                                      text: " / per person",
                                      style: AppTextStyles(
                                        context,
                                      ).captionRegular,
                                    ),
                                  ],
                                ),
                                style: AppTextStyles(context).primaryMedium,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),

                        Container(
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "img/svg/party.svg",
                                    package: "assets",
                                    width: 22,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Upcoming Nights",
                                    style: AppTextStyles(context).secondaryBold,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  3,
                                  (index) => Text(
                                    data[index],
                                    style: AppTextStyles(context).smallRegular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryButton(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (context) {
                        return ExpandablePageView(
                          controller: pageController,
                          
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CreateBooking(controller: pageController),
                            ReviewBooking(controller: pageController),
                            ConfirmBooking(controller: pageController),
                          ],
                        );
                      },
                    );
                  },
                  title: "Book",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
