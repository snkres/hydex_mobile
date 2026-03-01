import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllVendors extends ConsumerStatefulWidget {
  const AllVendors({super.key});

  @override
  ConsumerState<AllVendors> createState() => _AllVendorsState();
}

class _AllVendorsState extends ConsumerState<AllVendors> {
  EventCategory selectedCategory = EventCategory(
    description: "all",
    name: "All",
  );

  late final _pagingController = PagingController<int, Vendor>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) async => ref.watch(
      getVendorsProvider(page: pageKey, categoryId: selectedCategory.id).future,
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getEventCategoriesProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            collapsedHeight: 150,

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(54),
              child: SizedBox(
                height: 54,
                child: categories.when(
                  data: (data) {
                    final categoriesWithAll = [
                      EventCategory(id: "all", name: "All", description: ""),
                      ...data,
                    ];
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: categoriesWithAll.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomChip(
                          title: categoriesWithAll[index].name,
                          isSelected:
                              selectedCategory.name ==
                              categoriesWithAll[index].name,
                          onTap: () async {
                            setState(() {
                              selectedCategory = categoriesWithAll[index];
                            });
                            _pagingController.refresh();
                          },
                        ),
                      ),
                    );
                  },
                  error: (e, s) => SizedBox.shrink(),
                  loading: () => SizedBox.shrink(),
                ),
              ),
            ),
            title: Text(
              "Explore our vendors",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 15,
                fontWeight: .w900,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Column(
                    spacing: 8,
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(
                        "Explore our vendors",
                        style: TextStyle(
                          color: Colors
                              .white, // Ensure text contrasts with the purple
                          fontWeight: FontWeight.w900,
                          fontSize:
                              AppTextStyles(context).accumulator *
                              16, // Size will scale automatically
                        ),
                      ),
                      Text(
                        "Unforgettable places. Trusted hosts",
                        style: TextStyle(
                          color: AppColors
                              .textSecondary, // Ensure text contrasts with the purple

                          fontSize: AppTextStyles(context).accumulator * 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16.0,
                bottom: 60.0,
                top: 100,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFA25BFF),
                          Color(0xFF251343),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -25),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        "img/svg/pattern.svg",
                        fit: BoxFit.cover,
                        width: .infinity,
                        package: "assets",
                        // Use withOpacity for older Flutter, withValues for 3.27+
                        color: AppColors.backgroundBase.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: .only(top: 10, left: 16, right: 16),
            sliver: PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) =>
                  PagedSliverList<int, Vendor>.separated(
                    state: state,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate(
                      noItemsFoundIndicatorBuilder: (context) => NotFoundWidget(
                        heading: "Hmm… nothing in here",
                        description: "Try exploring other categories",
                      ),

                      noMoreItemsIndicatorBuilder: (ctx) => SizedBox.shrink(),

                      itemBuilder: (context, item, index) => EventContainer(
                        width: double.infinity,
                        heading: item.name ?? "",
                        tag: item.category?.name,
                        description: item.location?.address,

                        image: item.media.first,
                        avatarImage: item.logo,
                        onView: () => context.pushNamed(
                          "vendor_detail",
                          pathParameters: {"id": item.id},
                        ),
                        date: item.priceType?.label ?? "",
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
