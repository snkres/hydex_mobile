import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/active_event_card.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OwnerHomeScreen extends ConsumerStatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  ConsumerState<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends ConsumerState<OwnerHomeScreen> {
  final _eventsPageController = PageController(viewportFraction: 0.95);
  int _currentEventPage = 0;

  @override
  void dispose() {
    _eventsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final fullName = user?.fullName ?? 'Owner';
    final styles = AppTextStyles(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Header
              _buildHeader(fullName, styles),
              const SizedBox(height: 32),
              // Quick action cards
              _buildQuickActions(styles),
              const SizedBox(height: 13),
              // Scan tickets
              _buildScanTickets(styles),
              const SizedBox(height: 32),
              // Active events
              _buildActiveEventsSection(styles),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String fullName, AppTextStyles styles) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: '👋 '),
                    TextSpan(
                      text: fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: styles.accumulator * 19,
                        height: 28 / 19,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: styles.accumulator * 19,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Good evening. Your next event is waiting.',
                style: styles.captionRegular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(
            child: SvgPicture.asset(
              'img/svg/notification.svg',
              package: 'assets',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(AppTextStyles styles) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: 'img/svg/venue.svg',
            title: 'My Venue',
            subtitle: 'Manage reservations',
            styles: styles,
            onTap: () => context.push("/owner/venue"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickActionCard(
            icon: 'img/svg/ticket.svg',
            title: 'My Events',
            subtitle: 'Manage events and tickets',
            styles: styles,
            onTap: () => context.push("/owner/events"),
          ),
        ),
      ],
    );
  }

  Widget _buildScanTickets(AppTextStyles styles) {
    return GestureDetector(
      onTap: () => context.push("/owner/scan"),
      child: SmoothContainer(
        padding: const EdgeInsets.all(12),
        color: AppColors.containerDim,
        smoothness: 1,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            SvgPicture.asset(
              'img/svg/scan.svg',
              package: 'assets',
              width: 31,
              height: 31,
              colorFilter: const ColorFilter.mode(
                AppColors.borderBrand,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan Tickets',
                    style: styles.smallBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Check in guests on arrival',
                    style: styles.captionRegular.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveEventsSection(AppTextStyles styles) {
    // TODO: Replace with real event data
    final events = [
      EventCardData(
        id: '#1231',
        name: 'Astral Drift',
        date: 'Sat 21 Feb, 11:30 PM',
        tag: 'Tonight',
        sold: 90,
        total: 200,
        revenue: '32,423 EGP',
      ),
      EventCardData(
        id: '#1231',
        name: 'Astral Drift',
        date: 'Sat 21 Feb, 11:30 PM',
        tag: 'Tomorrow',
        sold: 90,
        total: 200,
        revenue: '32,423 EGP',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Active Events',
              style: styles.secondaryMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            _buildPageIndicator(events.length),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 155,
          child: PageView.builder(
            controller: _eventsPageController,

            clipBehavior: Clip.none,
            padEnds: false,
            itemCount: events.length,
            onPageChanged: (index) {
              setState(() => _currentEventPage = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ActiveEventCard(event: events[index], styles: styles),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int count) {
    return Row(
      children: List.generate(count, (index) {
        final isActive = index == _currentEventPage;
        return Container(
          margin: const EdgeInsets.only(left: 2),
          width: 12,
          height: 7,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.buttonSecondary
                : const Color(0xFF27272B),
            borderRadius: BorderRadius.circular(16),
          ),
        );
      }),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final AppTextStyles styles;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.styles,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SmoothContainer(
        padding: const EdgeInsets.all(12),
        color: AppColors.containerDim,
        smoothness: 1,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.9,
              child: SvgPicture.asset(
                icon,
                package: 'assets',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.borderBrand,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: styles.smallBold.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: styles.accumulator * 11,
                color: AppColors.textSecondary,
                height: 16 / 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
