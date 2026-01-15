import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/core/ui/widgets/adaptive_image.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryDetails extends ConsumerStatefulWidget {
  const CategoryDetails({super.key, required this.category});

  final EventCategory category;

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

  late final _eventsPagingController = PagingController<int, Event>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) async => ref.watch(
      getEventsProvider(page: pageKey, categoryId: selectedCategory.id).future,
    ),
  );

  late final _vendorsPagingController = PagingController<int, Vendor>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) async => ref.watch(
      getVendorsProvider(page: pageKey, categoryId: selectedCategory.id).future,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Listen to tab changes and rebuild UI
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _eventsPagingController.dispose();
    _vendorsPagingController.dispose();
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
              widget.category.name,
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
                          widget.category.name,
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
                          widget.category.description,
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
                  AdaptiveImage(
                    imageData: widget.category.image!,
                    width: .infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.backgroundBase.withValues(alpha: 0.81),
                          Color(0xff0F0F12),
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
                        _eventsPagingController.refresh();
                        _vendorsPagingController.refresh();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          _tabController.index == 0
              ? SliverPadding(
                  padding: .only(top: 10, left: 16, right: 16),
                  sliver: PagingListener(
                    controller: _eventsPagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedSliverList<int, Event>.separated(
                          state: state,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          fetchNextPage: fetchNextPage,
                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: (context) =>
                                NotFoundWidget(
                                  heading: "Hmm… nothing here",
                                  description: "Try exploring other categories",
                                ),
                            noMoreItemsIndicatorBuilder: (ctx) =>
                                SizedBox.shrink(),
                            itemBuilder: (context, item, index) =>
                                EventContainer(
                                  width: double.infinity,
                                  heading: item.name,
                                  tag: item.category?.name,
                                  image: item.media.first,
                                  avatarImage: item.media.first,
                                  description: item.location.address,
                                  onView: () => context.pushNamed(
                                    "event_detail",
                                    pathParameters: {"id": item.id},
                                  ),
                                  date: item.startTime.toPrettyString(),
                                ),
                          ),
                        ),
                  ),
                )
              : SliverPadding(
                  padding: .only(top: 10, left: 16, right: 16),
                  sliver: PagingListener(
                    controller: _vendorsPagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedSliverList<int, Vendor>.separated(
                          state: state,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          fetchNextPage: fetchNextPage,
                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: (context) =>
                                NotFoundWidget(
                                  heading: "Hmm… nothing here",
                                  description: "Try exploring other categories",
                                ),
                            noMoreItemsIndicatorBuilder: (ctx) =>
                                SizedBox.shrink(),
                            itemBuilder: (context, item, index) =>
                                EventContainer(
                                  width: double.infinity,
                                  date: "",
                                  heading: item.name,
                                  tag: item.category?.name,
                                  image: item.media.first,
                                  avatarImage: item.media.first,
                                  description: item.location.address,
                                  onView: () => context.pushNamed(
                                    "vendor_detail",
                                    pathParameters: {"id": item.id},
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
