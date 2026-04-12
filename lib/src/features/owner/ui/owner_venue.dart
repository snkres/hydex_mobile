import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/models/booking_status.dart';
import 'package:hydex/src/features/owner/ui/events.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OwnerVenues extends StatefulWidget {
  const OwnerVenues({super.key});

  @override
  State<OwnerVenues> createState() => _OwnerVenuesState();
}

class _OwnerVenuesState extends State<OwnerVenues>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  int _bookingFilter = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      extendBodyBehindAppBar: true,
      appBar: BlurAppBar(
        title: 'My Venue',
        scrollController: _scrollController,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildVenueHeader(styles),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildTabBar(styles),
            ),
            const SizedBox(height: 16),
            _buildTabContent(styles),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueHeader(AppTextStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF414141), width: 0.8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(color: AppColors.containerDim),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.signalFunSuccess,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: styles.accumulator * 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSuccess,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.star, size: 11, color: AppColors.textSuccess),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.buttonSecondaryDisabled,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Nightclub & Lounge',
                style: TextStyle(
                  fontSize: styles.accumulator * 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBrand,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Echo Lounge',
          style: TextStyle(
            fontFamily: styles.fontFamily,
            fontSize: styles.accumulator * 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.2,
            height: 21 / 20,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Opacity(
              opacity: 0.9,
              child: Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '742 Vine St, Los Angeles, CA 90038',
              style: TextStyle(
                fontSize: styles.accumulator * 11,
                color: AppColors.textSecondary,
                height: 16 / 11,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabBar(AppTextStyles styles) {
    final tabs = ['Bookings', 'Events (2)', 'Sales'];
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = _tabController.index == index;
        return GestureDetector(
          onTap: () {
            _tabController.animateTo(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 380),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(right: index < tabs.length - 1 ? 16 : 0),
            padding: const EdgeInsets.only(
              left: 2,
              right: 2,
              top: 8,
              bottom: 7,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? AppColors.buttonSecondary
                      : Colors.transparent,
                  width: 1,
                ),
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 380),
              curve: Curves.easeOutBack,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.textPrimary
                    : const Color(0xFF424246),
                height: 20 / 14,
              ),
              child: Text(tabs[index]),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTabContent(AppTextStyles styles) {
    switch (_tabController.index) {
      case 0:
        return _buildBookingsTab(styles);
      case 1:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: EventsContent(
            statsOrder: [
              EventStatType.total,
              EventStatType.active,
              EventStatType.pending,
            ],
          ),
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildSalesTab(styles),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // ─── BOOKINGS TAB ───

  Widget _buildBookingsTab(AppTextStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildUpcomingReservations(styles),
        ),
        const SizedBox(height: 32),
        _buildBookingFilters(styles),
        const SizedBox(height: 16),
        ..._buildBookingCards(styles),
      ],
    );
  }

  Widget _buildUpcomingReservations(AppTextStyles styles) {
    return SmoothContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.9,
                  child: Text(
                    'Upcoming Reservations',
                    style: TextStyle(
                      fontFamily: styles.fontFamily,
                      fontSize: styles.accumulator * 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 20 / 14,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Confirmed guests this week',
                    style: TextStyle(
                      fontSize: styles.accumulator * 11,
                      color: Colors.white,
                      height: 16 / 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '7',
            style: TextStyle(
              fontFamily: styles.fontFamily,
              fontSize: styles.accumulator * 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 28 / 22,
            ),
          ),
          const SizedBox(width: 4),
          Opacity(
            opacity: 0.7,
            child: Icon(
              Icons.people_outline,
              size: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingFilters(AppTextStyles styles) {
    final filters = ['All', 'Confirmed', 'Pending', 'Rejected', 'Expired'];
    const duration = Duration(milliseconds: 380);
    const containerCurve = Curves.easeOutCubic;
    const textCurve = Curves.easeOutBack;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = _bookingFilter == index;
          return GestureDetector(
            onTap: () => setState(() => _bookingFilter = index),
            child: AnimatedContainer(
              duration: duration,
              curve: containerCurve,
              clipBehavior: Clip.none,
              margin: EdgeInsets.only(
                right: index < filters.length - 1 ? 16 : 0,
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
                    curve: textCurve,
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
                    child: Text(filters[index]),
                  ),
                  if (filters[index] == 'Pending') ...[
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
      _BookingData(
        '#132',
        'Ahmed Abid',
        'Sat 21 Feb, 11:30 PM',
        'RSV',
        'Pending',
      ),
      _BookingData(
        '#132',
        'Ahmed Abid',
        'Sat 21 Feb, 11:30 PM',
        'RSV',
        'Pending',
      ),
      _BookingData(
        '#132',
        'Ahmed Abid',
        'Sat 21 Feb, 11:30 PM',
        'RSV',
        'Confirmed',
      ),
      _BookingData(
        '#132',
        'Ahmed Abid',
        'Sat 21 Feb, 11:30 PM',
        'RSV',
        'Entered',
      ),
      _BookingData(
        '#132',
        'Ahmed Abid',
        'Sat 21 Feb, 11:30 PM',
        'Event',
        'Entered',
      ),
    ];

    return bookings
        .map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: _buildBookingCard(styles, b),
          ),
        )
        .toList();
  }

  Widget _buildBookingCard(AppTextStyles styles, _BookingData booking) {
    final statusColor =
        BookingStatus.fromString(booking.status)?.color ??
        AppColors.textWarning;

    return SmoothContainer(
      padding: const EdgeInsets.all(16),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.3,
                child: Text(
                  booking.id,
                  style: TextStyle(
                    fontFamily: styles.fontFamily,
                    fontSize: styles.accumulator * 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 20 / 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLighter,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  booking.type,
                  style: TextStyle(
                    fontSize: styles.accumulator * 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 16 / 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.name,
                    style: TextStyle(
                      fontFamily: styles.fontFamily,
                      fontSize: styles.accumulator * 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.date,
                    style: TextStyle(
                      fontSize: styles.accumulator * 11,
                      color: AppColors.textSecondary,
                      height: 16 / 11,
                    ),
                  ),
                ],
              ),
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
                    booking.status,
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
        ],
      ),
    );
  }

  // ─── SALES TAB ───

  Widget _buildSalesTab(AppTextStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSalesGrid(styles),
        const SizedBox(height: 16),
        _buildPageDots(),
      ],
    );
  }

  Widget _buildSalesGrid(AppTextStyles styles) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSalesCard(
                styles,
                icon: Icons.attach_money,
                value: '8,325 EGP',
                label: 'Venue Revenue',
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _buildSalesCard(
                styles,
                icon: Icons.confirmation_number_outlined,
                value: '47,650 EGP',
                label: 'Event Ticket Revenue',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.1,
          child: Row(
            children: [
              Expanded(
                child: _buildSalesCard(
                  styles,
                  icon: Icons.people_outline,
                  value: '185',
                  label: 'Total Guests',
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildSalesCard(
                  styles,
                  icon: Icons.trending_up,
                  value: '2,00 EGP',
                  label: 'Avg per Guest',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSalesCard(
    AppTextStyles styles, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return SmoothContainer(
      padding: const EdgeInsets.all(14),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 69,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 14, color: AppColors.textSecondary),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: styles.accumulator * 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.3,
                height: 30 / 20,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: styles.accumulator * 10,
                color: Colors.white.withValues(alpha: 0.2),
                height: 15 / 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageDots() {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 18,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.buttonSecondary,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _BookingData {
  final String id;
  final String name;
  final String date;
  final String type;
  final String status;

  _BookingData(this.id, this.name, this.date, this.type, this.status);
}
