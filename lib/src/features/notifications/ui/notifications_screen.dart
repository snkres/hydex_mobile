import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/notifications/domain/notifications_providers.dart';
import 'package:hydex/src/features/notifications/ui/components/notification_card.dart';
import 'package:hydex/src/features/notifications/ui/permission_required.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  // final filters = const ["All", "Reservations", "Invites", "Other"];

  // String selectedFilter = "All";

  late final AnimationController _shimmerController;
  late final Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _shimmerAnimation = CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    );
    Future.microtask(() => ref.read(markAllNotificationsAsReadProvider.future));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  String _formatTimestamp(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays >= 1) return "${diff.inDays}d ago";
    if (diff.inHours >= 1) return "${diff.inHours}h ago";
    if (diff.inMinutes >= 1) return "${diff.inMinutes}m ago";
    return "Just now";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationPermissionRequired(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    const CustomBackButton(),
                    SizedBox(width: 45),
                    SvgPicture.asset(
                      "img/svg/notification.svg",
                      package: "assets",
                    ),
                    SizedBox(width: 8),
                    Text(
                      "My Notifications",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 37,
            //     child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       padding: EdgeInsets.symmetric(horizontal: 16),
            //       itemBuilder: (context, index) {
            //         return CustomChip(
            //           title: filters[index],
            //           isSelected: selectedFilter == filters[index],
            //           onTap: () {
            //             setState(() {
            //               selectedFilter = filters[index];
            //             });
            //           },
            //         );
            //       },
            //       separatorBuilder: (context, index) => SizedBox(width: 10),
            //       itemCount: filters.length,
            //     ),
            //   ),
            // ),
            ref
                .watch(getNotificationsProvider)
                .when(
                  loading: () => SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.separated(
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          _NotificationCardSkeleton(
                            animation: _shimmerAnimation,
                          ),
                    ),
                  ),
                  error: (_, __) => const SliverToBoxAdapter(child: SizedBox()),
                  data: (items) {
                    if (items.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyNotifications(),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final n = items[index];
                          return NotificationCard(
                            title: n.title,
                            subtitle: n.body,
                            isRead: n.isRead,
                            timestamp: _formatTimestamp(n.createdAt),
                          );
                        },
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Still waiting for the invites 🎉",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 24 / 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "No notifications just yet but once your invites and reservations roll in, this is where the fun begins!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCardSkeleton extends StatelessWidget {
  final Animation<double> animation;

  const _NotificationCardSkeleton({required this.animation});

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      smoothness: 1,
      borderRadius: BorderRadius.circular(24),
      color: AppColors.containerDim,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(animation: animation, width: 160, height: 14),
          const SizedBox(height: 8),
          _ShimmerBox(animation: animation, width: double.infinity, height: 12),
          const SizedBox(height: 4),
          _ShimmerBox(animation: animation, width: 200, height: 12),
          const SizedBox(height: 8),
          _ShimmerBox(animation: animation, width: 60, height: 11),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final Animation<double> animation;
  final double width;
  final double height;
  const _ShimmerBox({
    required this.animation,
    required this.width,
    required this.height,
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
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
