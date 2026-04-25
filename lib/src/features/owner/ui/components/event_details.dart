import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/owner/domain/owner_providers.dart';
import 'package:hydex/src/features/owner/models/event_booking_response.dart';
import 'package:intl/intl.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/models/event_status.dart';
import 'package:hydex/src/features/owner/models/owner_event.dart';
import 'package:hydex/src/features/owner/ui/components/booking_card.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart' show RsvStatus;
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:smooth_corner/smooth_corner.dart';

class _SkeletonBox extends StatefulWidget {
  const _SkeletonBox({this.width, this.height = 14, this.borderRadius = 8});

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.containerDim.withOpacity(_anim.value + 0.3),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

class _SkeletonBookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SkeletonBox(width: 60, height: 13),
              _SkeletonBox(width: 70, height: 13),
            ],
          ),
          SizedBox(height: 10),
          _SkeletonBox(width: 140, height: 15),
          SizedBox(height: 8),
          Row(
            children: [
              _SkeletonBox(width: 100, height: 11),
              SizedBox(width: 8),
              _SkeletonBox(width: 60, height: 11),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventDetailsSkeleton extends StatelessWidget {
  const _EventDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Header card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SmoothContainer(
            padding: const EdgeInsets.all(16),
            color: AppColors.containerDim,
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SkeletonBox(width: 140, height: 16),
                    const _SkeletonBox(width: 90, height: 12),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SkeletonBox(width: 100, height: 13),
                    const _SkeletonBox(width: 60, height: 13),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const _SkeletonBox(height: 4, borderRadius: 4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Info cards row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: SmoothContainer(
                  padding: const EdgeInsets.all(12),
                  color: AppColors.containerDim,
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 16, height: 16),
                      SizedBox(height: 10),
                      _SkeletonBox(width: 80, height: 13),
                      SizedBox(height: 4),
                      _SkeletonBox(width: 50, height: 11),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SmoothContainer(
                  padding: const EdgeInsets.all(12),
                  color: AppColors.containerDim,
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 16, height: 16),
                      SizedBox(height: 10),
                      _SkeletonBox(width: 100, height: 13),
                      SizedBox(height: 4),
                      _SkeletonBox(width: 70, height: 11),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Filter row
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _SkeletonBox(width: 30, height: 14),
              SizedBox(width: 16),
              _SkeletonBox(width: 60, height: 14),
              SizedBox(width: 16),
              _SkeletonBox(width: 50, height: 14),
              SizedBox(width: 16),
              _SkeletonBox(width: 55, height: 14),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Booking cards
        ...List.generate(
          4,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: SmoothContainer(
              padding: const EdgeInsets.all(16),
              color: AppColors.containerDim,
              smoothness: 1,
              borderRadius: BorderRadius.circular(16),
              child: const Row(
                children: [
                  _SkeletonBox(width: 40, height: 40, borderRadius: 12),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkeletonBox(width: 100, height: 13),
                        SizedBox(height: 6),
                        _SkeletonBox(width: 140, height: 11),
                      ],
                    ),
                  ),
                  _SkeletonBox(width: 60, height: 24, borderRadius: 99),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OwnerEventDetails extends ConsumerStatefulWidget {
  const OwnerEventDetails({super.key, required this.eventID});

  final String eventID;

  @override
  ConsumerState<OwnerEventDetails> createState() => _OwnerEventDetailsState();
}

class _OwnerEventDetailsState extends ConsumerState<OwnerEventDetails> {
  final ScrollController _scrollController = ScrollController();
  int _bookingFilter = 0;

  static const _bookingFilters = ['All', 'Confirmed', 'Pending', 'Rejected'];

  static const _statusColors = <EventStatus, Color>{
    EventStatus.active: AppColors.textSuccess,
    EventStatus.pending: AppColors.textWarning,
    EventStatus.rejected: AppColors.textError,
    EventStatus.past: AppColors.textSecondary,
  };

  static const _statusLabels = <EventStatus, String>{
    EventStatus.active: 'Active',
    EventStatus.pending: 'Pending',
    EventStatus.rejected: 'Rejected',
    EventStatus.past: 'Past',
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.eventID);
    final styles = AppTextStyles(context);
    final eventAsync = ref.watch(
      getOwnerEventDetailsProvider(eventID: widget.eventID),
    );
    return eventAsync.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.backgroundBase,
        extendBodyBehindAppBar: true,
        appBar: BlurAppBar(
          title: 'My Event',
          scrollController: _scrollController,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
            bottom: 32,
          ),
          child: const _EventDetailsSkeleton(),
        ),
      ),
      error: (e, st) {
        log("Event Error", error: e, stackTrace: st);
        return Scaffold(
          backgroundColor: AppColors.backgroundBase,
          body: Center(child: Text(e.toString())),
        );
      },
      data: (event) => _buildScaffold(context, styles, event),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    AppTextStyles styles,
    OwnerEvent event,
  ) {
    final bookingsAsync = ref.watch(
      getOwnerEventBookingsProvider(eventID: widget.eventID),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      extendBodyBehindAppBar: true,
      appBar: BlurAppBar(
        title: 'My Event',
        scrollController: _scrollController,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildEventHeader(styles, event),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildInfoCards(styles, event),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildBookingFilters(styles, bookingsAsync),
            ),
            const SizedBox(height: 16),
            _buildBookingCards(styles, bookingsAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(AppTextStyles styles, OwnerEvent event) {
    final statusColor = _statusColors[event.status] ?? AppColors.textSecondary;
    final statusLabel = _statusLabels[event.status] ?? '';
    final soldFraction = event.sales.capacity > 0
        ? event.sales.sold / event.sales.capacity
        : 0.0;

    return SmoothContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.name,
                  style: TextStyle(
                    fontFamily: styles.fontFamily,
                    fontSize: styles.accumulator * 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 50),
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$statusLabel Event #${event.displayCode}',
                    style: TextStyle(
                      fontSize: styles.accumulator * 11,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                      height: 16 / 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${event.sales.sold}',
                          style: TextStyle(
                            fontSize: styles.accumulator * 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                        ),
                        TextSpan(
                          text: '/${event.sales.capacity} sold',
                          style: TextStyle(
                            fontSize: styles.accumulator * 13,
                            color: AppColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                '${event.revenue.amount.toStringAsFixed(0)} ${event.revenue.currency}',
                style: TextStyle(
                  fontFamily: styles.fontFamily,
                  fontSize: styles.accumulator * 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: soldFraction,
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

  Widget _buildInfoCards(AppTextStyles styles, OwnerEvent event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SmoothContainer(
            padding: const EdgeInsets.all(12),
            color: AppColors.containerDim,
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 10),
                Text(
                  "event.vendorName",
                  style: TextStyle(
                    fontFamily: styles.fontFamily,
                    fontSize: styles.accumulator * 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Venue',
                  style: TextStyle(
                    fontSize: styles.accumulator * 11,
                    color: AppColors.textSecondary,
                    height: 16 / 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SmoothContainer(
            padding: const EdgeInsets.all(12),
            color: AppColors.containerDim,
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat('EEEE, d MMM').format(event.startTime),
                  style: TextStyle(
                    fontFamily: styles.fontFamily,
                    fontSize: styles.accumulator * 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('h:mm a').format(event.startTime)} - ${DateFormat('h:mm a').format(event.endTime)}',
                  style: TextStyle(
                    fontSize: styles.accumulator * 11,
                    color: AppColors.textSecondary,
                    height: 16 / 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingFilters(
    AppTextStyles styles,
    AsyncValue<List<EventBookingItem>> bookingsAsync,
  ) {
    const duration = Duration(milliseconds: 380);
    const curve = Curves.easeOutCubic;
    final pendingCount =
        bookingsAsync.value
            ?.where((b) => b.status == RsvStatus.pending)
            .length ??
        0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_bookingFilters.length, (index) {
          final isSelected = _bookingFilter == index;
          return GestureDetector(
            onTap: () => setState(() => _bookingFilter = index),
            child: AnimatedContainer(
              duration: duration,
              curve: curve,
              margin: EdgeInsets.only(
                right: index < _bookingFilters.length - 1 ? 16 : 0,
              ),
              padding: isSelected
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 6)
                  : const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.containerDim : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                children: [
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOutBack,
                    style: TextStyle(
                      fontFamily: styles.fontFamily,
                      fontSize: styles.accumulator * 14,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColors.textPrimary
                          : const Color(0xFF4B4B4D),
                      height: 20 / 14,
                    ),
                    child: Text(_bookingFilters[index]),
                  ),
                  if (_bookingFilters[index] == 'Pending' &&
                      pendingCount > 0) ...[
                    const SizedBox(width: 4),
                    Text(
                      '($pendingCount)',
                      style: TextStyle(
                        fontSize: styles.accumulator * 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textWarning,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBookingCards(
    AppTextStyles styles,
    AsyncValue<List<EventBookingItem>> bookingsAsync,
  ) {
    return bookingsAsync.when(
      loading: () => Column(
        children: List.generate(
          4,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: _SkeletonBookingCard(),
          ),
        ),
      ),
      error: (e, _) => const SizedBox.shrink(),
      data: (bookings) {
        final filtered = _bookingFilter == 0
            ? bookings
            : bookings.where((b) {
                return switch (_bookingFilter) {
                  1 =>
                    b.status == RsvStatus.confirmed ||
                        b.status == RsvStatus.entered,
                  2 => b.status == RsvStatus.pending,
                  3 =>
                    b.status == RsvStatus.rejected ||
                        b.status == RsvStatus.cancelled,
                  _ => true,
                };
              }).toList();

        if (filtered.isEmpty) {
          return const NotFoundWidget(
            heading: 'No bookings found',
            description: 'There are no bookings matching this filter.',
          );
        }

        return Column(
          children: filtered
              .map(
                (b) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    left: 16,
                    right: 16,
                  ),
                  child: OwnerBookingCard(
                    booking: BookingCardData(
                      id: b.id,
                      code: b.displayCode,
                      name: b.fullName,
                      date: DateFormat(
                        'EEE d MMM, hh:mm a',
                      ).format(b.bookingDate),
                      type: b.passName,
                      status: b.status.label,
                    ),
                    styles: styles,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
