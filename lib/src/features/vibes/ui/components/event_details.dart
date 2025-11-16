import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/ui/components/nightlife.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.event});

  final Event event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  // <-- track if pinned
  final pageController = PageController();
  bool isBarCollapsed = false;
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
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton.large(
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
        child: Text("Book.."),
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
                      ? Text(widget.event.name, key: ValueKey('title'))
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
                      child: CollapsedEventContainer(
                        name: widget.event.name,
                        description: widget.event.description,
                        endTime: widget.event.endTime,
                        startTime: widget.event.startTime,
                        tags: widget.event.tags,
                        location: widget.event.location,
                        pricing: widget.event.priceType,
                        owner: widget.event.vendor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CollapsedEventContainer extends ConsumerWidget {
  CollapsedEventContainer({
    super.key,
    required this.name,
    required this.tags,
    required this.location,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.pricing,
    required this.owner,
  });
  final String name, description, pricing;
  final Location location;
  final List<String> tags;
  final DateTime startTime, endTime;
  final locationService = LocationService();
  final Vendor owner;

  String getDurationString(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return "$hours hours $minutes mins";
    } else if (hours > 0) {
      return "$hours hours";
    } else {
      return "$minutes mins";
    }
  }

  // Source - https://stackoverflow.com/a
  // Posted by Bhargav Sejpal, modified by community. See post 'Timeline' for change history
  // Retrieved 2025-11-07, License - CC BY-SA 4.0

  static Future<void> openMap(
    BuildContext context,
    double lat,
    double lng,
  ) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distance = ref.watch(
      calculateDistanceProvider(
        endLatitude: location.coordinates.lat,
        endLongitude: location.coordinates.lng,
      ),
    );
    return Column(
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
                  padding: const EdgeInsets.only(left: 16, bottom: 12, top: 16),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLighter,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          tag.capitalize(),
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 12),

                      Text(
                        "📍 ${location.address}",
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
                      distance.when(
                        data: (value) => Text(
                          "$value KM away",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        loading: () => SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        error: (e, st) {
                          log("Distance Error", error: e, stackTrace: st);
                          return Text(
                            "Distance unavailable",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                      Text(
                        "Casual ${pricing.capitalize()} (\$\$\$)",
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
                            getDurationString(startTime, endTime),
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textSuccess,
                            ),
                          ),
                          Text(
                            "${startTime.formatDateTime()} – ${endTime.formatDateTime()}",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          MapsLauncher.launchCoordinates(
                            location.coordinates.lat,
                            location.coordinates.lng,
                          );
                        },
                        child: Container(
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
                              fontSize: AppTextStyles(context).accumulator * 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Drinks",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTextStyles(context).accumulator * 20,
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
                              fontSize: AppTextStyles(context).accumulator * 11,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Lorem ipsum dolor sit amet,Lorem",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 11,
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
                                        AppTextStyles(context).accumulator * 11,
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
                            fontSize: AppTextStyles(context).accumulator * 16,
                          ),
                        ),
                        ReadMoreText(
                          description,
                          trimMode: TrimMode.Line,
                          trimLines: 3,
                          delimiter: "....",
                          colorClickableText: AppColors.textPrimary,
                          trimCollapsedText: 'Read more',
                          moreStyle: AppTextStyles(context).captionBold,
                          lessStyle: AppTextStyles(context).captionBold,
                          trimExpandedText: 'Read less',
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
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
                            fontSize: AppTextStyles(context).accumulator * 16,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 17,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmoothContainer(
                                      width: 47,
                                      height: 47,
                                      smoothness: 1,
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    Text(
                                      owner.name,
                                      style: AppTextStyles(context).smallMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                NightLifeSection(),
                // SportsSection(),
                // AdventureScreen(),
                // ShowSection(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                                  style: AppTextStyles(context).captionRegular
                                      .copyWith(color: AppColors.textSecondary),
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
                                      .copyWith(color: AppColors.textSuccess),
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
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Things to know".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 16,
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
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}

/// A reusable widget that behaves like a modal bottom sheet, showing the `TestWe` content.
class TestWeSheet extends StatelessWidget {
  const TestWeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                            fontSize: AppTextStyles(context).accumulator * 12,
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
                            fontSize: AppTextStyles(context).accumulator * 12,
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
                            fontSize: AppTextStyles(context).accumulator * 12,
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
                            fontSize: AppTextStyles(context).accumulator * 12,
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
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textSuccess,
                            ),
                          ),
                          Text(
                            "12 Oct, 9:00 PM – 13 Oct, 3:00 AM",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
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
                              fontSize: AppTextStyles(context).accumulator * 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Drinks",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTextStyles(context).accumulator * 20,
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
                              fontSize: AppTextStyles(context).accumulator * 11,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Lorem ipsum dolor sit amet,Lorem",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 11,
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
                                        AppTextStyles(context).accumulator * 11,
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
                            fontSize: AppTextStyles(context).accumulator * 16,
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
                            fontSize: AppTextStyles(context).accumulator * 14,
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
                            fontSize: AppTextStyles(context).accumulator * 16,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 17,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmoothContainer(
                                      width: 47,
                                      height: 47,
                                      smoothness: 1,
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    Text(
                                      "Hady El Mawkoos",
                                      style: AppTextStyles(context).smallMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                NightLifeSection(),
                // SportsSection(),
                // AdventureScreen(),
                // ShowSection(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                                  style: AppTextStyles(context).captionRegular
                                      .copyWith(color: AppColors.textSecondary),
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
                                      .copyWith(color: AppColors.textSuccess),
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
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Things to know".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 16,
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
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
