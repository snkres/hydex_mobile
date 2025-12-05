import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchController = TextEditingController();
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getEventCategoriesProvider);

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
                        searchController.addListener(() {
                          setState(() {}); // refresh to show/hide clear button
                        });

                        return TextField(
                          controller: searchController,
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

                            // 👇 Show only when text is not empty
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
                          selectedCategory == categoriesWithAll[index].name,
                      onTap: () {
                        setState(() {
                          selectedCategory = categoriesWithAll[index].name;
                        });
                      },
                    ),
                  ),
                );
              },
              error: (e, s) => SizedBox.shrink(),
              loading: () => SizedBox.shrink(),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Trending Events",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextStyles(context).accumulator * 16,
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
                    itemCount: 3,
                    itemBuilder: (context, index) => TrendContainer(),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Top Vendors",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextStyles(context).accumulator * 16,
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
                    itemCount: 3,
                    itemBuilder: (context, index) => TrendContainer(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrendContainer extends StatelessWidget {
  const TrendContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 316,
      child: Row(
        spacing: 12,
        crossAxisAlignment: .start,
        children: [
          SmoothContainer(
            width: 65,
            color: Colors.red,
            smoothness: 1,
            borderRadius: .circular(16),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "King Safari",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 16,
                        fontWeight: .w700,
                      ),
                    ),
                    Container(
                      padding: .symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.signalBrandTint,
                        borderRadius: .circular(100),
                      ),
                      child: Text(
                        "Adventure",
                        style: TextStyle(color: AppColors.textBrand),
                      ),
                    ),
                  ],
                ),

                Text(
                  "Luxury (\$\$\$\$)",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 11,
                    color: AppColors.textBrand,
                  ),
                ),
                Text(
                  "1.5 KM away - Barzil Street, Zamalek",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "6 Hours",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 12,
                        color: AppColors.textSuccess,
                        fontWeight: .w500,
                      ),
                    ),
                    Text(
                      "  \u2022  9:00 PM – 13 Oct, 3:00 AM",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 12,
                        fontWeight: .w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  final filters = const ["Recommended", "Nearest", "Top Rated"];
  final pricingFilters = const [
    r"$ Casual",
    r"$$ Casual",
    r"$$$ Premium",
    r"$$$$ Luxury",
  ];

  String? selectedPriceFilter;
  String? selectedFilter;

  double selectedValue = 1;

  bool isFeatureSelected = false;
  @override
  Widget build(BuildContext context) {
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
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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
                        isSelected: selectedFilter == e,
                        onTap: () {
                          if (selectedFilter == e) {
                            setState(() {
                              selectedFilter = null;
                            });
                          } else {
                            setState(() {
                              selectedFilter = e;
                            });
                          }
                        },
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
                        title: e,
                        isSelected: selectedPriceFilter == e,
                        onTap: () {
                          if (selectedPriceFilter == e) {
                            setState(() {
                              selectedPriceFilter = null;
                            });
                          } else {
                            setState(() {
                              selectedPriceFilter = e;
                            });
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
                value: selectedValue,
                padding: .symmetric(horizontal: 16),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
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
                isSelected: isFeatureSelected,
                onTap: () {
                  setState(() {
                    isFeatureSelected = !isFeatureSelected;
                  });
                },
              ),
              SizedBox(height: 24),
              PrimaryButton(
                onTap: () async {
                  context.pop();
                },
                title: "Show (50) Results",
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
