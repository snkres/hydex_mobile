import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

class CategoryDetails extends ConsumerStatefulWidget {
  const CategoryDetails({super.key});

  @override
  ConsumerState<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends ConsumerState<CategoryDetails>
    with TickerProviderStateMixin {
  EventCategory selectedCategory = EventCategory(
    description: "all",
    name: "All",
  );
  late final TabController _tabController;

  late final _pagingController = PagingController<int, Event>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) async => ref.watch(
      getEventsProvider(page: pageKey, categoryId: selectedCategory.id).future,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  overlayColor: .all(Colors.transparent),
                  isScrollable: true,
                  tabAlignment: .start,
                  labelPadding: const .only(right: 2, left: 20),
                  labelColor: AppColors.textPrimary,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: [
                    Tab(text: "Events"),
                    Tab(text: "Venues"),
                  ],
                ),
              ),
            ),
            title: Text(
              "Sports",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 15,
                fontWeight: .w900,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          "Sports",
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
                          "Book courts, arenas and more of everyone!",
                          style: TextStyle(
                            color: AppColors.textSecondary,

                            fontSize: AppTextStyles(context).accumulator * 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16.0,
                bottom: 60.0,
                top: 100,
              ),
              background: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.backgroundBase.withValues(alpha: 0.8),
                          AppColors.backgroundBase,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10, right: 16),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 38,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final labels = [
                      "All",
                      "Category 1",
                      "Category 2",
                      "Category 3",
                    ];
                    return CustomChip(
                      title: labels[index],
                      isSelected: selectedCategory.name == labels[index],
                      onTap: () {
                        setState(() {
                          selectedCategory = EventCategory(
                            name: labels[index],
                            description: labels[index].toLowerCase(),
                            id: labels[index].toLowerCase(),
                          );
                        });
                        _pagingController.refresh();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: .only(top: 10, left: 16, right: 16),
            sliver: PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) =>
                  PagedSliverList<int, Event>.separated(
                    state: state,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate(
                      noItemsFoundIndicatorBuilder: (context) => NotFoundWidget(
                        heading: "Hmm… nothing happening nearby 😔",
                        description: "Try exploring other categories",
                      ),
                      noMoreItemsIndicatorBuilder: (ctx) => SizedBox.shrink(),
                      itemBuilder: (context, item, index) => EventContainer(
                        width: double.infinity,
                        heading: item.name,
                        tag: item.category?.name,
                        image: item.media.first,
                        avatarImage: item.media.first,
                        onView: () => context.pushNamed(
                          "event_detail",
                          pathParameters: {"id": item.id},
                        ),
                        date: item.startTime.toPrettyString(),
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
