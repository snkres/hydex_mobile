import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/event_notifier.dart';
import 'package:hydex/src/features/vibes/ui/components/gallery.dart';
import 'package:hydex/src/features/vibes/ui/components/nightlife.dart';
import 'package:animations/animations.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  final pageController = PageController();
  bool isBarCollapsed = false;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  bool _isCollapsedFromSheet = false;
  final double _collapseThreshold = 0.85;
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
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventProvider(widget.id));
    final double screenHeight = MediaQuery.of(context).size.height;

    final overlayOpacity = ((_sheetSize - 0.3) / (0.85 - 0.3) * 0.6).clamp(
      0.0,
      0.6,
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible:
            eventAsync.value?.bookingExperience?.passes.isNotEmpty ?? false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: PrimaryButton(
            bgColor: Colors.white,
            frColor: Colors.black,
            onTap: () async {
              final event = eventAsync.requireValue;
              final book = CreateBook(
                name: event.name ?? "",
                image: event.vendor.logo ?? "",
                location:
                    event.location?.address ??
                    "${event.location?.street}, ${event.location?.city}, ${event.location?.country}",
                termsAndConditions: event.termsAndConditions,
                passes: event.bookingExperience?.passes ?? [],
                startTime: event.startTime,
              );
              ref.read(createBookProvider.notifier).updateBook(book);
              context.push("/create-booking", extra: book);
            },
            title: "RSVP",
          ),
        ),
      ),
      body: eventAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) {
          log("Event Detail Error", error: e, stackTrace: st);

          if (e is Exception) {
            if (e.toString().contains("not found")) {
              return Center(child: Text("Not Found"));
            }
          }
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        },
        data: (event) {
          return SoftEdgeBlur(
            edges: event.bookingExperience != null
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
                      if (_sheetSize >= _collapseThreshold &&
                          details.delta.dy < 0) {
                        return;
                      }
                      final delta = -details.delta.dy / screenHeight;
                      final newSize = (_sheetSize + delta).clamp(0.3, 0.85);
                      if (_sheetController.isAttached) {
                        _sheetController.jumpTo(newSize);
                      }
                    },
                    child: event.media.isNotEmpty
                        ? PageView.builder(
                            controller: pageController,
                            itemCount: event.media.length,
                            itemBuilder: (_, i) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  ImageOrVideoWidget(url: event.media[i]),
                                  Container(
                                    color: Colors.black.withOpacity(
                                      overlayOpacity,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Container(
                            color: AppColors.borderDefault,
                            child: Center(
                              child: Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                  ),
                ),

                DraggableScrollableSheet(
                  controller: _sheetController,
                  maxChildSize: 0.85,
                  initialChildSize: 0.3,
                  minChildSize: 0.3,
                  builder: (context, scrollController) {
                    return Material(
                      color: Colors.transparent,
                      child: SmoothClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        smoothness: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ), // Or your bg color
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                Center(
                                  child: SmoothPageIndicator(
                                    controller: pageController,
                                    count: event.media.length,
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
                                CollapsedEventContainer(
                                  experiences: event.experiences,
                                  details: event.details,
                                  name: event.name ?? "",
                                  createdTime: event.createdAt,
                                  thingsToKnow: event.thingsToKnow ?? [],
                                  category: event.category?.name,
                                  description: event.description ?? "",
                                  endTime: event.endTime,
                                  startTime: event.startTime,
                                  tags: event.tags,
                                  location:
                                      event.location ??
                                      Location(coordinates: Coordinates()),
                                  pricing: event.priceType?.label ?? "",
                                  owner: event.vendor,
                                  title: event.detailsTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: SizedBox(
                      height: 70,
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
                                      event.name ?? "",
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

                          IconButton.filled(
                            onPressed: () {
                              final formatter = DateFormat(
                                "EEE, MMM d • h:mm a",
                              );
                              final start = formatter.format(event.startTime);

                              final shareText =
                                  "I'm going to ${event.name} on $start!\n"
                                  "Join me: https://app.hyde-x.com/event/${event.id}";

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
                          //         .read(eventProvider(widget.id).notifier)
                          //         .toggleFavorite();
                          //   },
                          //   icon: SvgPicture.asset(
                          //     "img/svg/favorite.svg",
                          //     package: "assets",
                          //     colorFilter: .mode(
                          //       event.isFavorited
                          //           ? Colors.red
                          //           : AppColors.textPrimary,
                          //       .srcIn,
                          //     ),
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
    required this.createdTime,
    required this.thingsToKnow,
    required this.experiences,
    required this.category,
    required this.details,
    required this.title,
  });
  final String name, description, pricing;
  final Location location;
  final List<String> tags, thingsToKnow;
  final List<Experiences> experiences;
  final String? category, title;
  final DateTime startTime, endTime, createdTime;
  final locationService = LocationService();
  final Vendor owner;
  final List<Detail> details;

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

  int getHostingTime(DateTime createdAt) {
    final currentTime = DateTime.now();

    return currentTime.year - createdAt.year;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distance = ref.watch(
      calculateDistanceProvider(
        endLatitude: location.coordinates.lat ?? 0,
        endLongitude: location.coordinates.lng ?? 0,
      ),
    );
    final tagsWithCategory = [category, ...tags];
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
                    children: tagsWithCategory.map((tag) {
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
                          tag != null ? tag.capitalize() : "",
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
                        location.address != null
                            ? "📍 ${location.address}"
                            : "${location.street}, ${location.city}, ${location.country}",

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
                        loading: () => Text(
                          "Calculating...",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
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
                        pricing,
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
                          try {
                            MapsLauncher.launchCoordinates(
                              location.coordinates.lat ?? 0,
                              location.coordinates.lng ?? 0,
                            );
                          } catch (e, st) {
                            Sentry.captureException(e, stackTrace: st);
                          }
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
                Visibility(
                  visible: false,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
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
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                                    SmoothClipRRect(
                                      smoothness: 1,
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        fit: .cover,
                                        width: 47,
                                        height: 47,
                                        imageUrl: owner.logo ?? "",
                                        errorWidget: (_, _, _) => Center(
                                          child: Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      owner.name ?? "",
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
                                          "${getHostingTime(createdTime)} Years",
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
                Visibility(
                  visible: experiences.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(height: 12),
                      NightLifeSection(
                        experiences: experiences,
                        details: details,
                        title: title,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          SmoothClipRRect(
                            smoothness: 1,
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: .cover,
                              width: 32,
                              height: 32,
                              imageUrl: owner.logo ?? "",
                              errorWidget: (_, _, _) =>
                                  Center(child: Icon(Icons.broken_image)),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  owner.name ?? "",
                                  style: AppTextStyles(context).smallBold,
                                ),
                                Text(
                                  owner.description ?? "",
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
                        itemCount: owner.media.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0,
                            openBuilder: (context, action) => Gallery(
                              gallery: owner.media,
                              clickedPhoto: owner.media[index],
                            ),
                            closedBuilder: (context, action) {
                              return SmoothClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                smoothness: 1,
                                child: CachedNetworkImage(
                                  imageUrl: owner.media[index],
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: thingsToKnow.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
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
                                    fontSize:
                                        AppTextStyles(context).accumulator * 16,
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: thingsToKnow.length,
                                  padding: .zero,
                                  separatorBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Divider(
                                      color: AppColors.borderDefault,
                                    ),
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
                                        thingsToKnow[index],
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
                        ],
                      ),
                    ),
                    SizedBox(height: 124),
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
