import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/owner/domain/owner_providers.dart';
import 'package:intl/intl.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/models/event_status.dart';
import 'package:hydex/src/features/owner/models/owner_event.dart';
import 'package:hydex/src/features/owner/ui/components/booking_card.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
    final styles = AppTextStyles(context);
    final eventAsync = ref.watch(
      getOwnerEventDetailsProvider(eventID: widget.eventID),
    );
    ref.read(getOwnerEventBookingsProvider(eventID: widget.eventID));
    return eventAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.backgroundBase,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: AppColors.backgroundBase,
        body: Center(child: Text(e.toString())),
      ),
      data: (event) => _buildScaffold(context, styles, event),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    AppTextStyles styles,
    OwnerEvent event,
  ) {
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
              child: _buildBookingFilters(styles),
            ),
            const SizedBox(height: 16),
            ..._buildBookingCards(styles),
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

  Widget _buildBookingFilters(AppTextStyles styles) {
    const duration = Duration(milliseconds: 380);
    const curve = Curves.easeOutCubic;
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
                  if (_bookingFilters[index] == 'Pending') ...[
                    const SizedBox(width: 4),
                    Text(
                      '(5)',
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

  List<Widget> _buildBookingCards(AppTextStyles styles) {
    final bookings = [
      const BookingCardData(
        id: '#132',
        name: 'Ahmed Abid',
        date: 'Sat 21 Feb, 11:30 PM',
        type: 'Event',
        status: 'Pending',
      ),
      const BookingCardData(
        id: '#133',
        name: 'Sara Mahmoud',
        date: 'Sat 21 Feb, 11:30 PM',
        type: 'Event',
        status: 'Pending',
      ),
      const BookingCardData(
        id: '#134',
        name: 'Khaled Hassan',
        date: 'Sat 21 Feb, 11:30 PM',
        type: 'Event',
        status: 'Confirmed',
      ),
      const BookingCardData(
        id: '#135',
        name: 'Nour Ali',
        date: 'Sat 21 Feb, 11:30 PM',
        type: 'Event',
        status: 'Entered',
      ),
    ];
    return bookings
        .map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: OwnerBookingCard(booking: b, styles: styles),
          ),
        )
        .toList();
  }
}
