import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/domain/owner_providers.dart';
import 'package:hydex/src/features/owner/models/event_status.dart';
import 'package:hydex/src/features/owner/models/owner_event.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/widgets/active_event_card.dart' hide EventStatus;
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OwnerEvents extends ConsumerWidget {
  const OwnerEvents({super.key, this.preloadedEvents});

  final List<OwnerEvent>? preloadedEvents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = AppTextStyles(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: AppColors.backgroundBase,
            surfaceTintColor: Colors.transparent,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              'My Events',
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverToBoxAdapter(
              child: EventsContent(preloadedEvents: preloadedEvents),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsContent extends ConsumerStatefulWidget {
  const EventsContent({
    super.key,
    this.statsOrder = const [
      EventStatType.active,
      EventStatType.pending,
      EventStatType.total,
    ],
    this.preloadedEvents,
  });

  final List<EventStatType> statsOrder;
  final List<OwnerEvent>? preloadedEvents;

  @override
  ConsumerState<EventsContent> createState() => _EventsContentState();
}

class _EventsContentState extends ConsumerState<EventsContent> {
  int _eventFilter = 0;

  static const _filters = ['All', 'Active', 'Pending', 'Rejected', 'Past'];

  static const _filterToStatus = <int, EventStatus>{
    1: EventStatus.active,
    2: EventStatus.pending,
    3: EventStatus.rejected,
    4: EventStatus.past,
  };

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    if (widget.preloadedEvents != null) {
      return _buildContent(context, styles, widget.preloadedEvents!);
    }

    final eventsAsync = ref.watch(getOwnerEventsProvider(active: false));
    return eventsAsync.when(
      loading: () => const _EventsSkeleton(),
      error: (e, _) => Center(
        child: Text(
          'Failed to load events',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      data: (events) => _buildContent(context, styles, events),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppTextStyles styles,
    List<OwnerEvent> events,
  ) {
    final filtered = _eventFilter == 0
        ? events
        : events
              .where((e) => e.status == _filterToStatus[_eventFilter])
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventStatsRow(styles: styles, order: widget.statsOrder, events: events),
        const SizedBox(height: 24),
        _buildEventFilters(styles),
        const SizedBox(height: 13),
        if (filtered.isEmpty)
          NotFoundWidget(
            heading: "No event here",
            description: "Try exploring other filters",
          )
        else
          Column(
            children: [
              for (final event in filtered) ...[
                ActiveEventCard(event: event, styles: styles),
                const SizedBox(height: 12),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildEventFilters(AppTextStyles styles) {
    const duration = Duration(milliseconds: 380);
    const containerCurve = Curves.easeOutCubic;
    const textCurve = Curves.easeOutBack;
    return Row(
      children: List.generate(_filters.length, (index) {
        final isSelected = _eventFilter == index;
        return GestureDetector(
          onTap: () => setState(() => _eventFilter = index),
          child: AnimatedContainer(
            duration: duration,
            curve: containerCurve,
            margin: EdgeInsets.only(
              right: index < _filters.length - 1 ? 16 : 0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? AppColors.signalBrandSolid
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(99),
                topRight: Radius.circular(99),
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: duration,
              curve: textCurve,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: isSelected
                    ? styles.accumulator * 15
                    : styles.accumulator * 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.textPrimary
                    : const Color(0xFF4B4B4D),
                height: isSelected ? 24 / 15 : 20 / 14,
              ),
              child: Text(_filters[index]),
            ),
          ),
        );
      }),
    );
  }
}

class _EventsSkeleton extends StatelessWidget {
  const _EventsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.containerDim,
      highlightColor: AppColors.surfaceContainerLighter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat cards row
          Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.containerDim,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Filter chips row
          Row(
            children: List.generate(
              5,
              (i) => Container(
                margin: EdgeInsets.only(right: i < 4 ? 16 : 0),
                width: 40 + i * 4.0,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.containerDim,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          // Event cards
          for (int i = 0; i < 3; i++) ...[
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.containerDim,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

/// Order indices: 0 = Active, 1 = Pending, 2 = Total
enum EventStatType { active, pending, total }

class EventStatsRow extends StatelessWidget {
  const EventStatsRow({
    super.key,
    required this.styles,
    required this.events,
    this.order = const [
      EventStatType.active,
      EventStatType.pending,
      EventStatType.total,
    ],
  });

  final AppTextStyles styles;
  final List<OwnerEvent> events;
  final List<EventStatType> order;

  @override
  Widget build(BuildContext context) {
    final activeCount = events
        .where((e) => e.status == EventStatus.active)
        .length;
    final pendingCount = events
        .where((e) => e.status == EventStatus.pending)
        .length;

    final cards = {
      EventStatType.active: _StatCard(
        value: '$activeCount',
        label: 'Active',
        labelColor: AppColors.textSuccess,
        labelWeight: FontWeight.w500,
        styles: styles,
      ),
      EventStatType.pending: _StatCard(
        value: '$pendingCount',
        label: 'Pending Approval',
        labelColor: AppColors.textWarning,
        styles: styles,
      ),
      EventStatType.total: _StatCard(
        value: '${events.length}',
        label: 'Total events',
        labelColor: AppColors.textSecondary,
        styles: styles,
      ),
    };

    final visibleOrder = order.where((type) {
      if (type == EventStatType.pending && pendingCount == 0) return false;
      return true;
    }).toList();

    return Row(
      children: [
        for (int i = 0; i < visibleOrder.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          cards[visibleOrder[i]]!,
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.labelColor,
    required this.styles,
    this.labelWeight = FontWeight.w400,
  });

  final String value;
  final String label;
  final Color labelColor;
  final FontWeight labelWeight;
  final AppTextStyles styles;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmoothContainer(
        padding: const EdgeInsets.all(12),
        color: AppColors.containerDim,
        smoothness: 1,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 22 / 16,
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: styles.accumulator * 11,
                  fontWeight: labelWeight,
                  color: labelColor,
                  height: 16 / 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
