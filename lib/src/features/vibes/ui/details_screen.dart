import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vendor_notifier.dart';
import 'package:hydex/src/features/vibes/ui/components/gallery.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

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
  double _sheetSize = 0.3;
  final GlobalKey _contentKey = GlobalKey();
  double _computedMaxChildSize = 0.86;
  bool _hasMeasured = false;

  @override
  void initState() {
    super.initState();

    _sheetController.addListener(() {
      final bool next = _sheetController.size >= 0.86;
      if (next != _isCollapsedFromSheet) {
        setState(() {
          _isCollapsedFromSheet = next;
        });
      }
      if (_sheetSize != _sheetController.size) {
        setState(() {
          _sheetSize = _sheetController.size;
        });
      }
    });
  }

  void _measureContent() {
    if (_hasMeasured) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _contentKey.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final screenHeight = MediaQuery.of(context).size.height;
        final ratio = (box.size.height / screenHeight).clamp(0.3, 0.86);
        _hasMeasured = true;
        if (ratio != _computedMaxChildSize) {
          setState(() {
            _computedMaxChildSize = ratio;
          });
        }
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
    final overlayOpacity = ((_sheetSize - 0.3) / (0.86 - 0.3) * 0.6).clamp(
      0.0,
      0.6,
    );

    return Scaffold(
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: Visibility(
        visible:
            vendorAsync.value?.bookingExperience?.passes.isNotEmpty ?? false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: PrimaryButton(
            bgColor: Colors.white,
            frColor: Colors.black,
            onTap: () async {
              try {
                final vendor = vendorAsync.requireValue;
                print("Vendor: ${vendor.operatingHours}");
                final book = CreateBook(
                  image: vendor.logo ?? "",
                  location:
                      vendor.location?.address ??
                      "${vendor.location?.street}, ${vendor.location?.city}, ${vendor.location?.country}",
                  name: vendor.name ?? "",
                  operatingHours: vendor.operatingHours.toOpenDateTimes(),
                  termsAndConditions: vendor.termsAndConditions,
                  requiresApproval:
                      vendorAsync
                          .requireValue
                          .bookingExperience
                          ?.requireReservationApproval ??
                      false,
                  passes: vendor.bookingExperience?.passes ?? [],
                );

                ref.read(createBookProvider.notifier).updateBook(book);
                context.push("/create-booking", extra: book);
              } catch (e) {
                return;
              }
            },
            title: "RSVP",
          ),
        ),
      ),
      body: vendorAsync.when(
        data: (vendor) {
          debugPrint('[DETAILS] build data branch, media=${vendor.media}');
          _measureContent();
          final distance = ref.watch(
            calculateDistanceProvider(
              endLatitude: vendor.location?.coordinates.lat ?? 0,
              endLongitude: vendor.location?.coordinates.lng ?? 0,
            ),
          );
          return SoftEdgeBlur(
            edges: vendor.bookingExperience != null
                ? [
                    EdgeBlur(
                      type: EdgeType.bottomEdge,
                      size: 100,
                      sigma: 30,
                      tintColor: AppColors.backgroundBase,
                      controlPoints: [
                        ControlPoint(
                          position: 0.4,
                          type: ControlPointType.visible,
                        ),
                        ControlPoint(
                          position: 1,
                          type: ControlPointType.transparent,
                        ),
                      ],
                    ),
                  ]
                : [],

            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (_sheetSize >= 0.86 && details.delta.dy < 0) {
                        return;
                      }
                      final delta = -details.delta.dy / screenHeight;
                      final newSize = (_sheetSize + delta).clamp(
                        0.3,
                        _computedMaxChildSize,
                      );
                      if (_sheetController.isAttached) {
                        _sheetController.jumpTo(newSize);
                      }
                    },
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: vendor.media.length,
                      itemBuilder: (_, i) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ImageOrVideoWidget(url: vendor.media[i]),
                            Container(
                              color: Colors.black.withOpacity(overlayOpacity),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                DraggableScrollableSheet(
                  controller: _sheetController,
                  maxChildSize: _computedMaxChildSize,
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
                            key: _contentKey,
                            children: [
                              Center(
                                child: SmoothPageIndicator(
                                  controller: pageController,
                                  count: vendor.media.length,
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.white.withValues(
                                      alpha: 0.2,
                                    ),
                                    dotHeight: 10,
                                    dotWidth: 13,
                                  ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                    vendor.name ?? "",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppTextStyles(
                                                            context,
                                                          ).accumulator *
                                                          24,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  SizedBox(height: 12),

                                                  Text(
                                                    vendor.location?.address !=
                                                            null
                                                        ? "📍 ${vendor.location?.address}"
                                                        : "${vendor.location?.street}, ${vendor.location?.city}, ${vendor.location?.country}",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppTextStyles(
                                                            context,
                                                          ).accumulator *
                                                          12,
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: false, // Rating
                                              child: SmoothContainer(
                                                padding: EdgeInsets.all(6),
                                                color:
                                                    AppColors.signalFunSuccess,
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
                                              vendor.priceType?.label ?? "",
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              isOpenNow(vendor.operatingHours),
                                              style: TextStyle(
                                                fontSize:
                                                    AppTextStyles(
                                                      context,
                                                    ).accumulator *
                                                    12,
                                                color:
                                                    isOpenNow(
                                                          vendor.operatingHours,
                                                        ) ==
                                                        "Open"
                                                    ? AppColors.textSuccess
                                                    : AppColors.textError,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                try {
                                                  if (vendor.location != null) {
                                                    await MapsLauncher.launchCoordinates(
                                                      vendor
                                                              .location!
                                                              .coordinates
                                                              .lat ??
                                                          0,
                                                      vendor
                                                              .location!
                                                              .coordinates
                                                              .lng ??
                                                          0,
                                                    );
                                                  }
                                                } catch (e) {
                                                  await Sentry.captureException(
                                                    e,
                                                  );
                                                }
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
                                                      BorderRadius.circular(
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            mainAxisAlignment: .start,
                                            children: [
                                              SizedBox(height: 16),

                                              Text(
                                                "HYDEX PERKS",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize:
                                                      AppTextStyles(
                                                        context,
                                                      ).accumulator *
                                                      16,
                                                ),
                                              ),
                                              SizedBox(height: 8),

                                              TicketWidget(
                                                width:
                                                    (MediaQuery.widthOf(
                                                          context,
                                                        ) /
                                                        375) *
                                                    282,
                                                height:
                                                    (MediaQuery.heightOf(
                                                          context,
                                                        ) /
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Text(
                                                        "Complimentary",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              AppTextStyles(
                                                                context,
                                                              ).accumulator *
                                                              10,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Text(
                                                        "Drinks",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Text(
                                                        "7:30pm to 10:00pm today",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                                  horizontal:
                                                                      16,
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
                                                                    FontWeight
                                                                        .w700,
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
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
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
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize:
                                                      AppTextStyles(
                                                        context,
                                                      ).accumulator *
                                                      16,
                                                ),
                                              ),
                                              ReadMoreText(
                                                vendor.description ?? "",
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
                                      if (vendor.experiences.isNotEmpty)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: SmoothClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            smoothness: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 24),

                                                Text(
                                                  "Experiences".toUpperCase(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.textSecondary,
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

                                      Visibility(
                                        visible: vendor.events.isNotEmpty,
                                        child: Column(
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
                                                  color:
                                                      AppColors.textSecondary,
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                      ),
                                      SizedBox(height: 24),
                                      Visibility(
                                        visible: vendor.details.isNotEmpty,
                                        child: Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Menu & Cuisines"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .textSecondary,
                                                      fontSize:
                                                          AppTextStyles(
                                                            context,
                                                          ).accumulator *
                                                          16,
                                                    ),
                                                  ),
                                                  SizedBox(height: 12),
                                                  vendor.detailsDescription !=
                                                          null
                                                      ? Text(
                                                          vendor
                                                              .detailsDescription!,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .textSecondary,
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
                                                itemCount:
                                                    vendor.details.length,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),

                                                scrollDirection:
                                                    Axis.horizontal,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(width: 8),
                                                itemBuilder: (context, index) {
                                                  final item =
                                                      vendor.details[index];
                                                  return OpenContainer(
                                                    closedColor:
                                                        Colors.transparent,
                                                    closedElevation: 0,
                                                    closedBuilder: (context, _) {
                                                      return Column(
                                                        spacing: 12,
                                                        children: [
                                                          SmoothClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  24,
                                                                ),
                                                            smoothness: 1,
                                                            child: SizedBox(
                                                              width: 165,
                                                              height: 168,
                                                              child:
                                                                  item.image
                                                                      .endsWith(
                                                                        '.avif',
                                                                      )
                                                                  ? CachedNetworkAvifImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      item.image,
                                                                    )
                                                                  : ImageOrVideoWidget(
                                                                      url: item
                                                                          .image,
                                                                    ),
                                                            ),
                                                          ),
                                                          Text(
                                                            item.title,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                                                    openBuilder:
                                                        (context, action) =>
                                                            Gallery(
                                                              gallery: vendor
                                                                  .details
                                                                  .map(
                                                                    (e) =>
                                                                        e.image,
                                                                  )
                                                                  .toList(),
                                                              clickedPhoto:
                                                                  item.image,
                                                            ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 24),
                                          ],
                                        ),
                                      ),

                                      if (vendor.gallery.isNotEmpty) ...[
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
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

                                                    child: ImageOrVideoWidget(
                                                      url:
                                                          vendor.gallery[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(height: 24),
                                      ],

                                      if (vendor.thingsToKnow.isNotEmpty)
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
                                                  color:
                                                      AppColors.textSecondary,
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
                                                      color: AppColors
                                                          .borderDefault,
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
                                                      vendor
                                                          .thingsToKnow[index],
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
                          CustomBackButton(
                            onClick: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go("/");
                              }
                            },
                          ),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeIn,
                              child: _isCollapsedFromSheet
                                  ? Text(
                                      vendor.name ?? "",
                                      key: const ValueKey('title'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : const SizedBox.shrink(
                                      key: ValueKey('empty'),
                                    ),
                            ),
                          ),

                          // Action Buttons
                          IconButton.filled(
                            onPressed: () {
                              final shareText =
                                  "I'm going to ${vendor.name} !\n"
                                  "Join me: https://app.hyde-x.com/vendor/${vendor.id}";

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
                          // IconButton.filled(
                          //   onPressed: () async {
                          //     await ref
                          //         .read(vendorProvider(widget.id).notifier)
                          //         .toggleFavorite();
                          //   },
                          //   icon: SvgPicture.asset(
                          //     "img/svg/favorite.svg",
                          //     package: "assets",
                          //   ),
                          // ),
                          // const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (e, s) {
          log("Vendor Error: ", error: e, stackTrace: s);
          if (e is Exception) {
            if (e.toString().contains("not found")) {
              return Center(child: Text("Not Found"));
            }
          }

          return Center(child: Text("Error"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
