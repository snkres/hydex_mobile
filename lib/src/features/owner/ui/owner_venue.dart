import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/owner/ui/components/no_venue.dart';
import 'package:hydex/src/features/search/ui/components/not_found.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/domain/owner_providers.dart';
import 'package:hydex/src/features/owner/models/vendor_booking_response.dart';
import 'package:hydex/src/features/owner/models/vendor_sales.dart';
import 'package:hydex/src/features/owner/ui/components/booking_card.dart';
import 'package:hydex/src/features/owner/ui/events.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OwnerVenues extends ConsumerStatefulWidget {
  const OwnerVenues({super.key, required this.eventsLength});

  final int eventsLength;

  @override
  ConsumerState<OwnerVenues> createState() => _OwnerVenuesState();
}

class _OwnerVenuesState extends ConsumerState<OwnerVenues>
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
    final currentUser = ref.watch(currentUserProvider).value;
    if (currentUser?.ownerProfile?.vendors?.isEmpty == true) {
      return NoVenue();
    }
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
              child: _buildVenueHeader(styles, currentUser),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildTabBar(styles, currentUser),
            ),
            const SizedBox(height: 16),
            _buildTabContent(styles, currentUser),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueHeader(AppTextStyles styles, User? currentUser) {
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
                image: DecorationImage(
                  fit: .cover,
                  image: CachedNetworkAvifImageProvider(
                    currentUser?.ownerProfile?.vendors?.first.image ?? "",
                  ),
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF414141), width: 0.8),
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
            if (currentUser?.ownerProfile?.vendors?.first.category?.name !=
                null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondaryDisabled,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  currentUser!.ownerProfile!.vendors!.first.category!.name,
                  style: TextStyle(
                    fontSize: styles.accumulator * 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBrand,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          currentUser?.ownerProfile?.vendors?.firstOrNull?.name ?? 'My Venue',
          style: TextStyle(
            fontFamily: styles.fontFamily,
            fontSize: styles.accumulator * 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.2,
            height: 21 / 20,
          ),
        ),
        if (currentUser?.ownerProfile?.vendors?.first.location?.address !=
            null) ...[
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
                currentUser!.ownerProfile!.vendors!.first.location!.address!,
                style: TextStyle(
                  fontSize: styles.accumulator * 11,
                  color: AppColors.textSecondary,
                  height: 16 / 11,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTabBar(AppTextStyles styles, User? user) {
    final eventsLength = widget.eventsLength > 1 ? widget.eventsLength : null;
    final tabs = [
      'Bookings',
      eventsLength != null ? 'Events ($eventsLength)' : 'Events',
      'Sales',
    ];
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

  Widget _buildTabContent(AppTextStyles styles, User? user) {
    switch (_tabController.index) {
      case 0:
        return _buildBookingsTab(styles, user);
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
          child: _buildSalesTab(styles, user),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // ─── BOOKINGS TAB ───

  static const _filterStatuses = [
    null, // All
    RsvStatus.confirmed,
    RsvStatus.pending,
    RsvStatus.rejected,
    null, // Expired — no matching RsvStatus, kept separate
  ];

  Widget _buildBookingsTab(AppTextStyles styles, User? user) {
    final vendorId = user?.ownerProfile?.vendors?.firstOrNull?.id ?? '';
    final bookingsAsync = ref.watch(
      getOwnerVendorBookingsProvider(vendorId: vendorId),
    );
    return bookingsAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(e.toString(), style: const TextStyle(color: Colors.red)),
      ),
      data: (bookings) {
        final pendingCount = bookings
            .where((b) => b.uiStatus == RsvStatus.pending)
            .length;
        final filtered = _bookingFilter == 0
            ? bookings
            : _filterStatuses[_bookingFilter] != null
            ? bookings
                  .where((b) => b.uiStatus == _filterStatuses[_bookingFilter])
                  .toList()
            : <VendorBookingItem>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildUpcomingReservations(styles, bookings),
            ),
            const SizedBox(height: 32),
            _buildBookingFilters(styles, bookings, pendingCount),
            const SizedBox(height: 16),
            ..._buildBookingCards(styles, filtered),
          ],
        );
      },
    );
  }

  Widget _buildUpcomingReservations(
    AppTextStyles styles,
    List<VendorBookingItem> bookings,
  ) {
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
            bookings.length.toString(),
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
              color: Color(0xffA25BFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingFilters(
    AppTextStyles styles,
    List<VendorBookingItem> allBookings,
    int pendingCount,
  ) {
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
                  if (filters[index] == 'Pending' && pendingCount > 0) ...[
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

  Widget _buildBookingCardsSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.containerDim,
      highlightColor: const Color(0xFF3A3A3C),
      child: Column(
        children: List.generate(
          4,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: SmoothContainer(
              padding: const EdgeInsets.all(16),
              color: AppColors.containerDim,
              smoothness: 1,
              borderRadius: BorderRadius.circular(20),
              child: const SizedBox(height: 72),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBookingCards(
    AppTextStyles styles,
    List<VendorBookingItem> bookings,
  ) {
    if (bookings.isEmpty) {
      return [
        NotFoundWidget(
          heading: "No booking here",
          description: "Try exploring other filters",
        ),
      ];
    }
    return bookings.map((b) {
      final data = BookingCardData(
        id: b.id,
        code: b.displayCode,
        name: b.fullName,
        date: _formatDate(b.bookingDate),
        type: 'RSV',
        status: b.uiStatus.label,
      );
      return Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
        child: OwnerBookingCard(rsv: "RSV", booking: data, styles: styles),
      );
    }).toList();
  }

  String _formatDate(DateTime dt) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour < 12 ? 'AM' : 'PM';
    return '${days[dt.weekday - 1]} ${dt.day} ${months[dt.month - 1]}, $hour:$minute $ampm';
  }

  // ─── SALES TAB ───

  Widget _buildSalesTab(AppTextStyles styles, User? user) {
    final salesAsync = ref.watch(
      getVendorSalesProvider(
        vendorId: user?.ownerProfile?.vendors?.first.id ?? "",
      ),
    );
    return salesAsync.when(
      loading: () => _buildSalesSkeleton(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (sales) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSalesGrid(styles, sales),
          const SizedBox(height: 16),
          _buildPageDots(),
        ],
      ),
    );
  }

  Widget _buildSalesSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.containerDim,
      highlightColor: const Color(0xFF3A3A3C),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSkeletonCard()),
              const SizedBox(width: 6),
              Expanded(child: _buildSkeletonCard()),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _buildSkeletonCard()),
              const SizedBox(width: 6),
              Expanded(child: _buildSkeletonCard()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return SmoothContainer(
      padding: const EdgeInsets.all(14),
      color: AppColors.containerDim,
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: const SizedBox(height: 69),
    );
  }

  Widget _buildSalesGrid(AppTextStyles styles, VendorSales sales) {
    String formatRevenue(VendorSalesRevenue r) =>
        '${r.amount.toStringAsFixed(0)} ${r.currency}';

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSalesCard(
                styles,
                icon: Icons.attach_money,
                value: formatRevenue(sales.venueRevenue),
                label: 'Venue Revenue',
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _buildSalesCard(
                styles,
                icon: Icons.confirmation_number_outlined,
                value: formatRevenue(sales.eventTicketRevenue),
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
                  value: '${sales.totalGuests}',
                  label: 'Total Guests',
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildSalesCard(
                  styles,
                  icon: Icons.trending_up,
                  value:
                      '${sales.averageRevenuePerGuest.toStringAsFixed(0)} EGP',
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
