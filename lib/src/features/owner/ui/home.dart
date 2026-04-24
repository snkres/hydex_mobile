import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/owner/domain/owner_providers.dart';
import 'package:hydex/src/features/owner/models/owner_event.dart';
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
    final allEventsAsync = ref.watch(getOwnerEventsProvider(active: false));
    final allEvents = allEventsAsync.value;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildHeader(fullName, styles),
              const SizedBox(height: 32),
              _buildQuickActions(styles, allEvents),
              const SizedBox(height: 13),
              _buildScanTickets(styles),
              const SizedBox(height: 32),
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
        GestureDetector(
          onTap: () => context.push("/notifications"),
          child: Container(
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
        ),
      ],
    );
  }

  Widget _buildQuickActions(AppTextStyles styles, List<OwnerEvent>? events) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: 'img/svg/venue.svg',
            title: 'My Venue',
            subtitle: 'Manage reservations',
            styles: styles,
            onTap: () =>
                context.push("/owner/venue", extra: events?.length ?? 0),
          ),
        ),
        const SizedBox(width: 8),
        if (events?.isNotEmpty ?? false)
          Expanded(
            child: _QuickActionCard(
              icon: 'img/svg/ticket.svg',
              title: 'My Events',
              subtitle: 'Manage events and tickets',
              styles: styles,
              onTap: () => context.push("/owner/events", extra: events),
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
    final asyncEvents = ref.watch(getOwnerEventsProvider(active: true));

    return asyncEvents.when(
      loading: () => _ActiveEventCardSkeleton(styles: styles),
      error: (_, __) => const SizedBox.shrink(),
      data: (ownerEvents) {
        if (ownerEvents.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          width: double.infinity,
          child: Column(
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
                  _buildPageIndicator(ownerEvents.length),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 155,
                child: PageView.builder(
                  controller: _eventsPageController,
                  clipBehavior: Clip.none,
                  padEnds: false,
                  itemCount: ownerEvents.length,
                  onPageChanged: (index) {
                    setState(() => _currentEventPage = index);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ActiveEventCard(
                        event: ownerEvents[index],

                        styles: styles,
                        status: .active,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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

class _ActiveEventCardSkeleton extends StatefulWidget {
  final AppTextStyles styles;
  const _ActiveEventCardSkeleton({required this.styles});

  @override
  State<_ActiveEventCardSkeleton> createState() =>
      _ActiveEventCardSkeletonState();
}

class _ActiveEventCardSkeletonState extends State<_ActiveEventCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _ShimmerBox(animation: _animation, width: 100, height: 14),
            const Spacer(),
            _ShimmerBox(animation: _animation, width: 40, height: 7),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 155,
          child: SmoothContainer(
            padding: const EdgeInsets.all(16),
            color: AppColors.containerDim,
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerBox(animation: _animation, width: 120, height: 12),
                const SizedBox(height: 12),
                _ShimmerBox(animation: _animation, width: 180, height: 16),
                const SizedBox(height: 8),
                _ShimmerBox(animation: _animation, width: 140, height: 12),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ShimmerBox(animation: _animation, width: 80, height: 12),
                    _ShimmerBox(animation: _animation, width: 60, height: 12),
                  ],
                ),
                const SizedBox(height: 8),
                _ShimmerBox(
                  animation: _animation,
                  width: double.infinity,
                  height: 4,
                  radius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final Animation<double> animation;
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.animation,
    required this.width,
    required this.height,
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.textPrimary.withValues(
            alpha: animation.value * 0.15,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
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
