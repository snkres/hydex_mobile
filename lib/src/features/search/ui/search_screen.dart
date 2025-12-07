import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/search/data/search_data.dart';
import 'package:hydex/src/features/search/domain/search_repository.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/features/search/ui/viewmodel.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchController = TextEditingController();
  EventCategory selectedCategory = EventCategory(
    description: "all",
    name: "All",
  );

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getEventCategoriesProvider);
    final searchAsync = ref.watch(searchViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 4,
                children: [
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return TextField(
                          controller: searchController,
                          onChanged: (value) {
                            ref
                                .read(searchViewModelProvider.notifier)
                                .setQuery(value);
                          },
                          decoration: InputDecoration(
                            fillColor: AppColors.containerDim,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100),
                            ),

                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: SvgPicture.asset(
                                "img/svg/search.svg",
                                package: "assets",
                              ),
                            ),

                            suffixIcon: searchController.text.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: IconButton(
                                      style: ButtonStyle(
                                        backgroundColor: .all(
                                          Colors.transparent,
                                        ),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 10,
                                        minHeight: 10,
                                      ),
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        searchController.clear();
                                        ref
                                            .read(
                                              searchViewModelProvider.notifier,
                                            )
                                            .setQuery(null);
                                        setState(() {});
                                      },
                                    ),
                                  )
                                : null,

                            label: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Search venues or events...",
                                  style: AppTextStyles(context).smallRegular,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  IconButton(
                    color: AppColors.containerDim,
                    constraints: BoxConstraints(minHeight: 50, minWidth: 50),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => FiltersWidget(),
                      );
                    },
                    icon: SvgPicture.asset(
                      width: 19,
                      "img/svg/filter.svg",
                      package: "assets",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Popular Categories",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppTextStyles(context).accumulator * 16,
                  fontWeight: .w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            categories.when(
              data: (data) {
                final categoriesWithAll = [
                  EventCategory(id: "all", name: "All", description: ""),
                  ...data,
                ];
                return SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: .horizontal,
                    itemCount: categoriesWithAll.length,
                    padding: .symmetric(horizontal: 16),
                    separatorBuilder: (_, _) => SizedBox(width: 8),
                    itemBuilder: (context, index) => CustomChip(
                      title: categoriesWithAll[index].name,
                      isSelected:
                          selectedCategory.name ==
                          categoriesWithAll[index].name,
                      onTap: () {
                        setState(() {
                          selectedCategory = categoriesWithAll[index];
                        });
                        ref
                            .read(searchViewModelProvider.notifier)
                            .setCategory(categoriesWithAll[index].id);
                      },
                    ),
                  ),
                );
              },
              error: (e, s) => SizedBox.shrink(),
              loading: () => SizedBox.shrink(),
            ),
            searchAsync.when(
              data: (data) {
                final allEmpty =
                    (data.events?.isEmpty ?? false) &&
                    (data.vendors?.isEmpty ?? false);
                if (allEmpty) {
                  return NotFoundWidget();
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Trending Events",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                                fontWeight: .w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 85,
                            child: ListView.separated(
                              scrollDirection: .horizontal,
                              padding: .symmetric(horizontal: 16),
                              separatorBuilder: (_, _) => SizedBox(width: 8),
                              itemCount: data.events?.length ?? 0,
                              itemBuilder: (context, index) {
                                final event = data.events?[index];
                                if (event == null) {
                                  return SizedBox.shrink();
                                }
                                return TrendContainer(
                                  name: event.name,
                                  image: event.media.first,
                                  priceType: event.priceType,
                                  category: event.category.name,
                                  location: event.location.address ?? "",
                                  onTap: () => context.pushNamed(
                                    "event_detail",
                                    pathParameters: {"id": event.id},
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
                      visible: data.vendors?.isNotEmpty ?? true,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Top Vendors",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                                fontWeight: .w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 85,
                            child: ListView.separated(
                              scrollDirection: .horizontal,
                              padding: .symmetric(horizontal: 16),
                              separatorBuilder: (_, _) => SizedBox(width: 8),
                              itemCount: data.vendors?.length ?? 0,
                              itemBuilder: (context, index) {
                                final vendor = data.vendors?[index];
                                if (vendor == null) {
                                  return SizedBox.shrink();
                                }
                                return TrendContainer(
                                  name: vendor.name,
                                  category: vendor.category?.name ?? "",
                                  priceType: vendor.priceType,
                                  location: vendor.location.address ?? "",
                                  image: vendor.media.first,
                                  onTap: () => context.pushNamed(
                                    "vendor_detail",
                                    pathParameters: {"id": vendor.id},
                                  ),
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
              loading: () =>
                  Expanded(child: Center(child: CircularProgressIndicator())),
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
  });
  final String name, category, priceType, location, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 316,
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
                      SizedBox(
                        width: 130,
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
                    "$priceType (\$\$\$\$)",
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 11,
                      color: AppColors.textBrand,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "6 Hours",
                  //       style: TextStyle(
                  //         fontSize: AppTextStyles(context).accumulator * 12,
                  //         color: AppColors.textSuccess,
                  //         fontWeight: .w500,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
