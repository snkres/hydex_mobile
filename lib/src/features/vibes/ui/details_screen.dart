import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/confirm_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/create_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  DetailsScreen({super.key, required this.id});

  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          onTap: () async {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) {
                return Consumer(
                  builder: (context, ref, child) {
                    final event = ref.watch(getEventByIDProvider(id: id));

                    return event.when(
                      data: (data) {
                        return ExpandablePageView(
                          controller: pageController,

                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CreateBooking(
                              controller: pageController,
                              eventName: data.title,
                              id: data.id!,
                              description: data.description,
                            ),
                            ReviewBooking(
                              controller: pageController,
                              eventName: data.title,
                              location: data.location,
                            ),
                            ConfirmBooking(
                              controller: pageController,
                              eventName: data.title,
                              location: data.location,
                            ),
                          ],
                        );
                      },
                      error: (e, s) {
                        return Center(child: Text("Error"));
                      },
                      loading: () => CircularProgressIndicator(),
                    );
                  },
                );
              },
            );
          },
          title: "Book",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  Consumer(
                    builder: (context, ref, child) {
                      final event = ref.watch(getEventByIDProvider(id: id));
                      return event.when(
                        data: (data) {
                          return EventContainerDetail(data: data);
                        },
                        error: (e, s) {
                          return Text("Error");
                        },
                        loading: () {
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                    },
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

class EventContainerDetail extends StatelessWidget {
  const EventContainerDetail({super.key, required this.data});

  final Event data;

  String formatTime(DateTime date) {
    int hour12 = date.hour == 0
        ? 12
        : (date.hour > 12 ? date.hour - 12 : date.hour);
    final hours = hour12.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final period = date.hour < 12 ? 'AM' : 'PM';

    return '$hours:$minutes $period';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          EventContainer(
            heading: data.title,
            image: data.imageUrl,
            description: data.description,
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
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
                      Spacer(),
                      Text(
                        data.location,
                        style: AppTextStyles(context).captionMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  alignment: Alignment.bottomLeft,

                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
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
                      Spacer(),
                      Text(
                        "Daily, ${formatTime(data.startDate)} – ${formatTime(data.endDate)}",
                        style: AppTextStyles(context).captionMedium,
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
              color: Theme.of(context).colorScheme.secondaryContainer,
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
                    style: AppTextStyles(
                      context,
                    ).primaryMedium.copyWith(fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: " EGP",
                        style: AppTextStyles(context).captionMedium,
                      ),
                      TextSpan(
                        text: " / per person",
                        style: AppTextStyles(context).captionRegular,
                      ),
                    ],
                  ),
                  style: AppTextStyles(context).primaryMedium,
                ),
              ],
            ),
          ),
          // SizedBox(height: 8),

          // Container(
          //   padding: EdgeInsets.all(12),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).colorScheme.secondaryContainer,
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           SvgPicture.asset(
          //             "img/svg/party.svg",
          //             package: "assets",
          //             width: 22,
          //           ),
          //           SizedBox(width: 8),
          //           Text(
          //             "Upcoming Nights",
          //             style: AppTextStyles(context).secondaryBold,
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 12),
          //       // Column(
          //       //   crossAxisAlignment: CrossAxisAlignment.start,
          //       //   children: List.generate(
          //       //     3,
          //       //     (index) => Text(
          //       //       data[index],
          //       //       style: AppTextStyles(context).smallRegular,
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
