import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OwnerEvents extends StatelessWidget {
  const OwnerEvents({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverToBoxAdapter(child: EventsContent()),
          ),
        ],
      ),
    );
  }
}

class EventsContent extends StatefulWidget {
  const EventsContent({
    super.key,
    this.statsOrder = const [
      EventStatType.active,
      EventStatType.pending,
      EventStatType.total,
    ],
  });

  final List<EventStatType> statsOrder;

  @override
  State<EventsContent> createState() => _EventsContentState();
}

class _EventsContentState extends State<EventsContent> {
  int _eventFilter = 0;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventStatsRow(styles: styles, order: widget.statsOrder),
        const SizedBox(height: 24),
        _buildEventFilters(styles),
        const SizedBox(height: 13),
        _buildEventCard(styles),
      ],
    );
  }

  Widget _buildEventFilters(AppTextStyles styles) {
    final filters = ['All', 'Active', 'Pending', 'Rejected', 'Past'];
    const duration = Duration(milliseconds: 380);
    const containerCurve = Curves.easeOutCubic;
    const textCurve = Curves.easeOutBack;
    return Row(
      children: List.generate(filters.length, (index) {
        final isSelected = _eventFilter == index;
        return GestureDetector(
          onTap: () => setState(() => _eventFilter = index),
          child: AnimatedContainer(
            duration: duration,
            curve: containerCurve,
            margin: EdgeInsets.only(right: index < filters.length - 1 ? 16 : 0),
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
              child: Text(filters[index]),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEventCard(AppTextStyles styles) {
    return SmoothContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColors.textSuccess,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Active Event #1231',
                          style: TextStyle(
                            fontSize: styles.accumulator * 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSuccess,
                            height: 16 / 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Astral Drift',
                      style: TextStyle(
                        fontFamily: styles.fontFamily,
                        fontSize: styles.accumulator * 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 22 / 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sat 21 Feb, 11:30 PM',
                      style: TextStyle(
                        fontSize: styles.accumulator * 11,
                        color: AppColors.textSecondary,
                        height: 16 / 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.confirmation_number_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '90',
                          style: TextStyle(
                            fontSize: styles.accumulator * 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: '/200 sold',
                          style: TextStyle(
                            fontSize: styles.accumulator * 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                '32,423 EGP',
                style: TextStyle(
                  fontFamily: styles.fontFamily,
                  fontSize: styles.accumulator * 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 90 / 200,
              minHeight: 4,
              backgroundColor: AppColors.surfaceContainerLighter,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.buttonSecondary,
              ),
            ),
          ),
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
    this.order = const [
      EventStatType.active,
      EventStatType.pending,
      EventStatType.total,
    ],
  });

  final AppTextStyles styles;
  final List<EventStatType> order;

  @override
  Widget build(BuildContext context) {
    final cards = {
      EventStatType.active: _StatCard(
        value: '4',
        label: 'Active',
        labelColor: AppColors.textSuccess,
        labelWeight: FontWeight.w500,
        styles: styles,
      ),
      EventStatType.pending: _StatCard(
        value: '4',
        label: 'Pending Approval',
        labelColor: AppColors.textWarning,
        styles: styles,
      ),
      EventStatType.total: _StatCard(
        value: '10',
        label: 'Total events',
        labelColor: AppColors.textSecondary,
        styles: styles,
      ),
    };

    return Row(
      children: [
        for (int i = 0; i < order.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          cards[order[i]]!,
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
