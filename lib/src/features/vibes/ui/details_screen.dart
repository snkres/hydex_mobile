import 'dart:developer';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/event_notifier.dart';
import 'package:hydex/src/features/vibes/domain/vendor_notifier.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/gallery.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';

class VendorDetailsScreen extends ConsumerStatefulWidget {
  const VendorDetailsScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<VendorDetailsScreen> createState() =>
      _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends ConsumerState<VendorDetailsScreen> {
  // <-- track if pinned
  final pageController = PageController();
  bool isBarCollapsed = false;

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  bool _isCollapsedFromSheet = false;
  final double _collapseThreshold = 0.9;
  double _sheetSize = 0.3;

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
      // Update sheet size for image overlay opacity
      if (_sheetSize != _sheetController.size) {
        setState(() {
          _sheetSize = _sheetController.size;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String isOpenNow(Map<String, OperatingHours> hours) {
    final now = DateTime.now();
    final weekday = _weekdayName(now.weekday);

    // If today has no hours → Closed
    if (!hours.containsKey(weekday)) return "Closed";

    final today = hours[weekday]!;
    final openTime = _parseTime(today.open, now);
    final closeTime = _parseClosingTime(today.close, openTime);

    if (now.isAfter(openTime) && now.isBefore(closeTime)) {
      return "Open";
    }

    return "Closed";
  }

  String _weekdayName(int w) {
    switch (w) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return '';
    }
  }

  DateTime _parseTime(String raw, DateTime base) {
    final parts = raw.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(base.year, base.month, base.day, hour, minute);
  }

  DateTime _parseClosingTime(String close, DateTime openDateTime) {
    final parts = close.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    var closeDateTime = DateTime(
      openDateTime.year,
      openDateTime.month,
      openDateTime.day,
      hour,
      minute,
    );

    // If closing time is next day (e.g., 03:00 after 23:00)
    if (closeDateTime.isBefore(openDateTime)) {
      closeDateTime = closeDateTime.add(Duration(days: 1));
    }

    return closeDateTime;
  }

  @override
  Widget build(BuildContext context) {
    final vendorAsync = ref.watch(vendorProvider(widget.id));
    final double screenHeight = MediaQuery.of(context).size.height;

    // Logic for overlay opacity
    final overlayOpacity = ((_sheetSize - 0.3) / (0.9 - 0.3) * 0.6).clamp(
      0.0,
      0.6,
    );

    return Scaffold(
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: Visibility(
        visible: vendorAsync.value?.bookingExperience != null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: PrimaryButton(
            bgColor: Colors.white,
            frColor: Colors.black,
            onTap: () async {
              final book = CreateBook(
                name: vendorAsync.requireValue.name,
                operatingHours: vendorAsync.requireValue.operatingHours,
                passes: [],
              );
              context.push("/create-booking", extra: book);
            },
            title: "RSVP",
          ),
        ),
      ),
      body: vendorAsync.when(
        data: (vendor) {
          final distance = ref.watch(
            calculateDistanceProvider(
              endLatitude: vendor.location.coordinates.lat ?? 0,
              endLongitude: vendor.location.coordinates.lng ?? 0,
            ),
          );
          return Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: vendor.media.length,
                  itemBuilder: (_, i) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: vendor.media[i],
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                        // The darkening overlay
                        Container(
                          color: Colors.black.withOpacity(overlayOpacity),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onVerticalDragUpdate: (details) {
                    // 1. Stop dragging if sheet is already full (let the sheet scroll instead)
                    if (_sheetSize >= _collapseThreshold &&
                        details.delta.dy < 0)
                      return;

                    // 2. Calculate new size
                    final delta = -details.delta.dy / screenHeight;
                    final newSize = (_sheetSize + delta).clamp(0.3, 0.9);

                    // 3. Move sheet
                    if (_sheetController.isAttached) {
                      _sheetController.jumpTo(newSize);
                    }
                  },
                  child: Container(color: Colors.transparent),
                ),
              ),
              DraggableScrollableSheet(
                controller: _sheetController,
                maxChildSize: .9,
                initialChildSize: .3,
                minChildSize: .3,

                builder: (context, scrollController) => Material(
                  color: Colors.transparent,

                  child: SmoothClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    smoothness: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
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
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        bottom: 12,
                                        top: 16,
                                      ),
                                      child: Wrap(
                                        spacing: 4,
                                        runSpacing: 8,
                                        children: vendor.tags.map((tag) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                  .surfaceContainerLighter,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Text(
                                              tag.capitalize(),
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
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
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  vendor.name,
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
                                                  "📍 ${vendor.location.address}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        12,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
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
                                                        color: AppColors
                                                            .textSuccess,
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
                                            "${distance.value ?? "..."} KM away",
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
                                            "Casual ${vendor.priceType} (\$\$\$)",
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
                                                isOpenNow(
                                                  vendor.operatingHours,
                                                ),
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTextStyles(
                                                        context,
                                                      ).accumulator *
                                                      12,
                                                  color:
                                                      isOpenNow(
                                                            vendor
                                                                .operatingHours,
                                                          ) ==
                                                          "Open"
                                                      ? AppColors.textSuccess
                                                      : AppColors.textError,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        padding: EdgeInsets.all(
                                                          16,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: vendor.operatingHours.entries.map((
                                                            entry,
                                                          ) {
                                                            final day =
                                                                entry.key;
                                                            final hours =
                                                                entry.value;
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                  ),
                                                              child: Text(
                                                                "${day.capitalize()}: ${hours.open} - ${hours.close}",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      14,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  "6:30 PM to 03:29 AM",
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
                                          GestureDetector(
                                            onTap: () {
                                              MapsLauncher.launchCoordinates(
                                                vendor
                                                        .location
                                                        .coordinates
                                                        .lat ??
                                                    0,
                                                vendor
                                                        .location
                                                        .coordinates
                                                        .lng ??
                                                    0,
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .surfaceContainerLighter,
                                                borderRadius:
                                                    BorderRadius.circular(100),
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
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
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
                                            (MediaQuery.widthOf(context) /
                                                375) *
                                            282,
                                        height:
                                            (MediaQuery.heightOf(context) /
                                                710) *
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                              vendor.description,
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
                                              children: vendor.experiences
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

                                    Column(
                                      crossAxisAlignment: .start,
                                      children: [
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
                                                  AppTextStyles(
                                                    context,
                                                  ).accumulator *
                                                  16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        SizedBox(
                                          height: 202,
                                          child: ListView.separated(
                                            itemCount: vendor.events.length,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(width: 8),
                                            itemBuilder: (context, index) {
                                              final event =
                                                  vendor.events[index];
                                              return SizedBox(
                                                width: 330,
                                                child: EventContainer(
                                                  onView: () {
                                                    context.pushNamed(
                                                      "event_detail",
                                                      pathParameters: {
                                                        "id": event.id,
                                                      },
                                                    );
                                                  },
                                                  heading: event.name ?? "",
                                                  image: event.media?.first,
                                                  avatarImage:
                                                      event.media?.first,
                                                  date: event.startTime
                                                      .toPrettyString(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
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
                                          vendor.detailsDescription != null
                                              ? Text(
                                                  vendor.detailsDescription!,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        14,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),

                                    SizedBox(
                                      height: 200,
                                      child: ListView.separated(
                                        itemCount: vendor.details.length,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),

                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(width: 8),
                                        itemBuilder: (context, index) {
                                          final item = vendor.details[index];
                                          return Column(
                                            spacing: 12,
                                            children: [
                                              SmoothClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                smoothness: 1,
                                                child: SizedBox(
                                                  width: 165,
                                                  height: 168,
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: item.image,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                item.title,
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
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    GridView.builder(
                                      itemCount: vendor.gallery.length,
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
                                          closedElevation: 0,
                                          openBuilder: (context, action) =>
                                              Gallery(
                                                gallery: vendor.gallery,
                                                clickedPhoto:
                                                    vendor.gallery[index],
                                              ),
                                          closedBuilder: (context, _) {
                                            return SmoothClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              smoothness: 1,
                                              child: SizedBox(
                                                width: 165,

                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      vendor.gallery[index],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
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
                                            "Things to know".toUpperCase(),
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

                                          ListView.separated(
                                            shrinkWrap: true,
                                            padding: .zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                vendor.thingsToKnow.length,
                                            separatorBuilder: (_, __) =>
                                                Divider(
                                                  color:
                                                      AppColors.borderDefault,
                                                ),
                                            itemBuilder: (_, index) {
                                              return ListTile(
                                                contentPadding: .zero,
                                                leading: SvgPicture.asset(
                                                  "img/svg/ar_.svg",
                                                  width: 15,
                                                  height: 15,
                                                  package: "assets",
                                                ),
                                                title: Text(
                                                  vendor.thingsToKnow[index],
                                                  style: AppTextStyles(
                                                    context,
                                                  ).smallRegular,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 124),
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

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: SizedBox(
                    height: 70, // Standard AppBar height
                    child: Row(
                      children: [
                        CustomBackButton(),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: _isCollapsedFromSheet
                                ? Text(
                                    vendor.name,
                                    key: const ValueKey('title'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(key: ValueKey('empty')),
                          ),
                        ),

                        // Action Buttons
                        IconButton.filled(
                          onPressed: () {
                            final shareText =
                                "I'm going to ${vendor.name} !\n"
                                "Join me: https://app.hyde-x.com/event/${vendor.id}";

                            SharePlus.instance.share(
                              ShareParams(text: shareText),
                            );
                          },
                          icon: SvgPicture.asset(
                            "img/svg/share.svg",
                            package: "assets",
                          ),
                        ),
                        const SizedBox(width: 9),
                        IconButton.filled(
                          onPressed: () async {
                            await ref
                                .read(vendorProvider(widget.id).notifier)
                                .toggleFavorite();
                          },
                          icon: SvgPicture.asset(
                            "img/svg/favorite.svg",
                            package: "assets",
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
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
                      height: 80,
                      color: AppColors.backgroundBase.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (e, s) {
          log("Vendor Error: ", error: e, stackTrace: s);
          return Center(child: Text("Error"));
        },
        loading: () => Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
