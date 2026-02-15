import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/search/data/search_data.dart';
import 'package:hydex/src/features/search/ui/components/animated_search.dart';
import 'package:hydex/src/features/search/ui/components/animted_text.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/features/search/ui/viewmodel.dart';
import 'package:hydex/src/features/search/data/recently_viewed.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchController = TextEditingController();
  String _selectedFilter = "All";

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getEventCategoriesProvider);
    final searchAsync = ref.watch(searchViewModelProvider);
    final featuredEvents = ref.watch(getBannersProvider(type: .featured));
    final currentUser = ref.watch(currentUserProvider).value;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Visibility(
              visible: !isClicked,
              child: Image.asset(
                "img/search_gradient.png",
                package: "assets",
                width: .infinity,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  AnimatedSize(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    child: !isClicked
                        ? Column(
                            crossAxisAlignment: .start,
                            children: [
                              SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      "👋 Hi, ${(currentUser?.fullName ?? "...")}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(
                                      "Find your",
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            38,
                                        fontWeight: .w900,
                                      ),
                                    ),
                                    const AnimatedText(),
                                    SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: isClicked ? 12 : 0),

                  AnimatedSearch(
                    searchController: searchController,
                    isClicked: isClicked,
                    onCancel: () {
                      setState(() {
                        isClicked = false;
                      });
                    },
                    onClick: () {
                      setState(() {
                        isClicked = true;
                      });
                    },
                  ),

                  SizedBox(height: isClicked ? 12 : 32),
                  Visibility(
                    visible: !isClicked,
                    child: categories.when(
                      data: (data) {
                        return Column(
                          crossAxisAlignment: .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                "Curated Collections".toUpperCase(),
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff878788),
                                  fontWeight: .w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              height:
                                  AppTextStyles(context).heightAccumulator *
                                  135,
                              child: ListView.separated(
                                scrollDirection: .horizontal,
                                itemCount: data.length,
                                padding: .symmetric(horizontal: 16),
                                separatorBuilder: (_, _) => SizedBox(width: 8),
                                itemBuilder: (context, index) =>
                                    SmoothClipRRect(
                                      borderRadius: .circular(20),
                                      smoothness: 1,
                                      child: SizedBox(
                                        width:
                                            AppTextStyles(context).accumulator *
                                            157,
                                        child: CuratedContainer(
                                          heading: data[index].name,
                                          endText: data[index].description,
                                          image: data[index].image!,
                                          onTap: () {
                                            context.pushNamed(
                                              "category_detail",
                                              extra: data[index],
                                            );
                                          },
                                          showExplore: false,
                                          endTextSize: 10,
                                          spaceBetweenHeadingAndEnd: 4,
                                          radius: 20,
                                          headingSize: 15,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                      error: (e, s) => SizedBox.shrink(),
                      loading: () => SizedBox.shrink(),
                    ),
                  ),

                  Visibility(
                    visible: isClicked,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          CustomChip(
                            title: "All",
                            isSelected: _selectedFilter == "All",
                            onTap: () {
                              setState(() {
                                _selectedFilter = "All";
                              });
                            },
                          ),
                          CustomChip(
                            title: "Events",
                            isSelected: _selectedFilter == "Events",
                            onTap: () {
                              setState(() {
                                _selectedFilter = "Events";
                              });
                            },
                          ),
                          CustomChip(
                            title: "Venues",
                            isSelected: _selectedFilter == "Venues",
                            onTap: () {
                              setState(() {
                                _selectedFilter = "Venues";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isClicked,
                    child: searchAsync.when(
                      data: (data) {
                        final allEmpty =
                            (data.events?.isEmpty ?? false) &&
                            (data.vendors?.isEmpty ?? false);
                        if (allEmpty) return NotFoundWidget();

                        if (isClicked) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: FutureBuilder<List<RecentlyViewedItem>>(
                                    future:
                                        RecentlyViewedHelper.getRecentlyViewed(),
                                    builder: (context, snapshot) {
                                      final items = snapshot.data ?? [];
                                      return Visibility(
                                        visible:
                                            items.isNotEmpty &&
                                            searchController.text.isEmpty,
                                        child: Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(
                                              "Recently Viewed".toUpperCase(),
                                              style: TextStyle(
                                                color: Color(0xff89898F),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Visibility(
                                              visible: items.isNotEmpty,
                                              child: Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: items
                                                    .map(
                                                      (item) => CustomChip(
                                                        title: item.name,
                                                        isSelected: false,

                                                        onTap: () {
                                                          if (item.type ==
                                                              'event') {
                                                            context.pushNamed(
                                                              "event_detail",
                                                              pathParameters: {
                                                                "id": item.id,
                                                              },
                                                            );
                                                          } else {
                                                            context.pushNamed(
                                                              "vendor_detail",
                                                              pathParameters: {
                                                                "id": item.id,
                                                              },
                                                            );
                                                          }
                                                        },
                                                        isRecentViewed: true,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),

                                Visibility(
                                  visible:
                                      (_selectedFilter == "All" ||
                                          _selectedFilter == "Events") &&
                                      (data.events?.isNotEmpty ?? false),
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      SizedBox(height: 12),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: .symmetric(horizontal: 16),
                                        separatorBuilder: (_, _) =>
                                            SizedBox(height: 8),
                                        itemCount: data.events?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final event = data.events?[index];
                                          if (event == null) {
                                            return SizedBox.shrink();
                                          }
                                          return TrendContainer(
                                            width: double.infinity,
                                            name: event.name,
                                            image: event.media.isNotEmpty
                                                ? event.media.first
                                                : "",
                                            duration: event
                                                .getEventDurationHours(),
                                            formattedDate: event
                                                .getFormattedEventTimeRange(),
                                            priceType:
                                                "Event - ${event.priceType?.label}",
                                            category: event.category.name,
                                            location:
                                                event.location.address ?? "",
                                            onTap: () {
                                              RecentlyViewedHelper.addRecentlyViewed(
                                                id: event.id,
                                                name: event.name,
                                                type: 'event',
                                              );
                                              context.pushNamed(
                                                "event_detail",
                                                pathParameters: {
                                                  "id": event.id,
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      (_selectedFilter == "All" ||
                                          _selectedFilter == "Venues") &&
                                      (data.vendors?.isNotEmpty ?? false),
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      SizedBox(height: 8),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: .symmetric(horizontal: 16),
                                        separatorBuilder: (_, _) =>
                                            SizedBox(height: 8),
                                        itemCount: data.vendors?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final vendor = data.vendors?[index];
                                          if (vendor == null) {
                                            return SizedBox.shrink();
                                          }
                                          return TrendContainer(
                                            width: double.infinity,
                                            name: vendor.name,
                                            image: vendor.media.first,

                                            priceType:
                                                vendor.priceType?.label ?? "",
                                            category:
                                                vendor.category?.name ?? "",
                                            duration: vendor
                                                .getTodayOperatingHoursDuration(),
                                            formattedDate: vendor
                                                .getFormattedOperatingHoursRange(),
                                            location:
                                                vendor.location.address ?? "",
                                            onTap: () {
                                              RecentlyViewedHelper.addRecentlyViewed(
                                                id: vendor.id,
                                                name: vendor.name,
                                                type: 'vendor',
                                              );
                                              context.pushNamed(
                                                "vendor_detail",
                                                pathParameters: {
                                                  "id": vendor.id,
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: .start,
                          children: [
                            Visibility(
                              visible: data.events?.isNotEmpty ?? true,
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Trending",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            16,
                                        fontWeight: .w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    height: 90,
                                    child: ListView.separated(
                                      scrollDirection: .horizontal,
                                      padding: .symmetric(horizontal: 16),
                                      separatorBuilder: (_, _) =>
                                          SizedBox(width: 8),
                                      itemCount: data.events?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final event = data.events?[index];
                                        if (event == null) {
                                          return SizedBox.shrink();
                                        }
                                        return TrendContainer(
                                          name: event.name,
                                          image: event.media.first,
                                          priceType:
                                              event.priceType?.label ?? "",
                                          category: event.category.name,
                                          duration: event
                                              .getEventDurationHours(),
                                          formattedDate: event
                                              .getFormattedEventTimeRange(),

                                          location:
                                              event.location.address ?? "",
                                          onTap: () {
                                            RecentlyViewedHelper.addRecentlyViewed(
                                              id: event.id,
                                              name: event.name,
                                              type: 'event',
                                            );
                                            context.pushNamed(
                                              "event_detail",
                                              pathParameters: {"id": event.id},
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (e, s) {
                        log("Search Error: ", error: e, stackTrace: s);
                        return Center(child: Text("Error"));
                      },
                      loading: () => Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isClicked,
                    child: featuredEvents.when(
                      data: (data) {
                        return Column(
                          crossAxisAlignment: .start,
                          children: [
                            Visibility(
                              visible: data.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Trending",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            16,
                                        fontWeight: .w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    height: 90,
                                    child: ListView.separated(
                                      scrollDirection: .horizontal,
                                      padding: .symmetric(horizontal: 16),
                                      separatorBuilder: (_, _) =>
                                          SizedBox(width: 8),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final assignment =
                                            data[index].assignment;
                                        final isEvent =
                                            assignment.targetType == .event;

                                        return TrendContainer(
                                          name: isEvent
                                              ? assignment.event!.name
                                              : assignment.vendor!.name,
                                          image: isEvent
                                              ? assignment.event!.media.first
                                              : assignment.vendor!.media.first,
                                          priceType: isEvent
                                              ? "Event"
                                              : assignment
                                                        .vendor
                                                        ?.priceType
                                                        ?.label ??
                                                    "",
                                          category:
                                              data[index].category?.name ?? "",
                                          duration: isEvent
                                              ? assignment.event!
                                                    .getEventDurationHours()
                                              : "",
                                          formattedDate: isEvent
                                              ? assignment.event!
                                                    .getFormattedEventTimeRange()
                                              : assignment.vendor!
                                                    .getFormattedOperatingHoursRange(),
                                          location: isEvent
                                              ? assignment
                                                        .event!
                                                        .location
                                                        .address ??
                                                    ""
                                              : assignment
                                                        .vendor!
                                                        .location
                                                        .address ??
                                                    "",
                                          onTap: () {
                                            final id = isEvent
                                                ? assignment.event!.id
                                                : assignment.vendor!.id;
                                            final name = isEvent
                                                ? assignment.event!.name
                                                : assignment.vendor!.name;
                                            final type = isEvent
                                                ? 'event'
                                                : 'vendor';
                                            RecentlyViewedHelper.addRecentlyViewed(
                                              id: id,
                                              name: name,
                                              type: type,
                                            );
                                            if (isEvent) {
                                              context.pushNamed(
                                                "event_detail",
                                                pathParameters: {"id": id},
                                              );
                                            } else {
                                              context.pushNamed(
                                                "vendor_detail",
                                                pathParameters: {"id": id},
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (e, s) => Text("Error"),
                      loading: () => CircularProgressIndicator(),
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

class TrendContainer extends StatelessWidget {
  const TrendContainer({
    super.key,
    required this.name,
    required this.category,
    required this.priceType,
    required this.location,
    required this.image,
    required this.onTap,
    this.formattedDate = "",
    this.width = 316,
    this.duration = "",
  });
  final String name, category, priceType, location, image;
  final VoidCallback onTap;
  final double width;
  final String duration, formattedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 90,
        child: Row(
          spacing: 12,
          crossAxisAlignment: .start,
          children: [
            SmoothClipRRect(
              smoothness: 1,
              borderRadius: .circular(16),
              child: CachedNetworkImage(
                imageUrl: image,
                width: 65,
                height: .infinity,
                fit: .cover,
                errorWidget: (context, url, error) => Center(
                  child: Container(
                    width: double.infinity,
                    height: .infinity,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOverlay,
                    ),
                    child: Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 16,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: .symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.signalBrandTint,
                          borderRadius: .circular(100),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(color: AppColors.textBrand),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    priceType,
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 11,
                      color: AppColors.textBrand,
                    ),
                  ),
                  Text(
                    location,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  formattedDate == "Closed"
                      ? Text(
                          "Closed",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textError,
                            fontWeight: .w500,
                          ),
                        )
                      : Expanded(
                          child: Row(
                            children: [
                              Text(
                                "$duration ${duration == "1" ? "Hour" : "Hours"}",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: AppColors.textSuccess,
                                  fontWeight: .w500,
                                ),
                              ),
                              Text(
                                " • $formattedDate",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: AppColors.textPrimary,
                                  fontWeight: .w500,
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
      ),
    );
  }
}

class FiltersWidget extends ConsumerStatefulWidget {
  const FiltersWidget({super.key});

  @override
  ConsumerState<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends ConsumerState<FiltersWidget> {
  final filters = const ["Nearest"];
  final pricingFilters = const [
    PriceOption(type: PriceType.casual, label: r"$ Casual"),
    PriceOption(type: PriceType.moderate, label: r"$$ Moderate"),
    PriceOption(type: PriceType.premium, label: r"$$$ Premium"),
    PriceOption(type: PriceType.luxury, label: r"$$$$ Luxury"),
  ];

  String? selectedFilter;

  double selectedValue = 1;

  bool isFeatureSelected = false;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      searchViewModelProvider.select((v) => v.isLoading),
    );
    final notifier = ref.read(searchViewModelProvider.notifier);
    final selectedFilters = notifier.filters;
    final resultsLength = ref
        .watch(searchViewModelProvider.notifier)
        .getLength();
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 12),
              Center(
                child: Container(
                  height: 4,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffDEDEDE),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 28),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 22,
                      fontWeight: .bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => notifier.reset(),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontWeight: .w400,
                        color: AppColors.textSecondary,
                        fontSize: AppTextStyles(context).accumulator * 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                runAlignment: .center,
                spacing: 8,
                runSpacing: 8,
                children: filters
                    .map(
                      (e) => CustomChip(
                        title: e,
                        isSelected: selectedFilters.coordinates != null,
                        onTap: () => notifier.toggleNearest(),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16),

              Text(
                "Price Range",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: .w500,
                  fontSize: AppTextStyles(context).accumulator * 16,
                ),
              ),

              SizedBox(height: 12),
              Wrap(
                runAlignment: .center,
                spacing: 8,
                runSpacing: 8,
                children: pricingFilters
                    .map(
                      (e) => CustomChip(
                        title: e.label,
                        isSelected: selectedFilters.priceType == e.type,
                        onTap: () {
                          if (selectedFilters.priceType == e.type) {
                            notifier.setPriceType(null);
                          } else {
                            notifier.setPriceType(e.type);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Distance",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: .w500,
                      fontSize: AppTextStyles(context).accumulator * 16,
                    ),
                  ),
                  Text(
                    "${selectedValue.toInt()}km",
                    style: AppTextStyles(
                      context,
                    ).smallMedium.copyWith(color: AppColors.textBrand),
                  ),
                ],
              ),
              SizedBox(height: 17),

              Slider(
                value: (selectedFilters.distance ?? 1).toDouble(),
                padding: .symmetric(horizontal: 16),
                onChanged: (value) {
                  notifier.setByDistance(value.toInt());
                },
                divisions: 5,
                max: 50,
                min: 1,
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "1km",
                      style: AppTextStyles(
                        context,
                      ).captionMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      "50km",
                      style: AppTextStyles(
                        context,
                      ).captionMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Text(
                "Features",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: .w500,
                  fontSize: AppTextStyles(context).accumulator * 16,
                ),
              ),
              SizedBox(height: 12),

              CustomChip(
                title: "Open Now",
                isSelected: selectedFilters.openNow == true,
                onTap: () {
                  final value = selectedFilters.openNow == true;
                  ref.read(searchViewModelProvider.notifier).setOpenNow(!value);
                },
              ),
              SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 50,
                ),

                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: .all(AppColors.buttonPrimary),
                    foregroundColor: .all(AppColors.textInverse),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: isLoading
                      ? LottieBuilder.asset(
                          "json/dark_loading.json",
                          package: "assets",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          "Show ($resultsLength) Results",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 15,
                            fontWeight: .w600,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
