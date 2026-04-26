import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/features/scan/ui/components/rsv_component.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:smooth_corner/smooth_corner.dart';

const _rejectReasons = [
  'Gender ratio limit',
  'Dress code not met',
  'Age requirement not met',
  'Guest limit reached',
  'Issue with venue',
];

class ScanActionButtons extends ConsumerStatefulWidget {
  const ScanActionButtons({
    super.key,
    required this.bookingId,
    required this.isTicket,
    this.givenStatus,
  });

  final String bookingId;
  final bool isTicket;
  final String? givenStatus;

  @override
  ConsumerState<ScanActionButtons> createState() => _ScanActionButtonsState();
}

class _ScanActionButtonsState extends ConsumerState<ScanActionButtons>
    with TickerProviderStateMixin {
  RsvStatus? _rsvStatus;
  late final AnimationController _springController;
  late final Animation<double> _scaleAnimation;
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.givenStatus != null) {
      _rsvStatus = RsvStatus.values
          .where(
            (e) => e.value.toLowerCase() == widget.givenStatus!.toLowerCase(),
          )
          .first;
    }
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _springController, curve: Curves.elasticOut),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _springController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onAction(RsvStatus status) {
    setState(() => _rsvStatus = status);
    _springController.forward(from: 0);
    _slideController.forward(from: 0);
    unawaited(
      ref.read(
        updateBookingStatusProvider(
          status: status,
          id: widget.bookingId,
        ).future,
      ),
    );
  }

  void _showRejectBottomSheet() {
    String? selectedReason;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundBase,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (ctx) {
        return Wrap(
          children: [
            StatefulBuilder(
              builder: (ctx, setSheetState) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xffDEDEDE).withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reject Entry?',
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 28 / 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Select the reason below',
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.35),
                              ),
                            ),
                            const SizedBox(height: 16),
                            for (final reason in _rejectReasons)
                              GestureDetector(
                                onTap: () => setSheetState(
                                  () => selectedReason = reason,
                                ),
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    spacing: 8,
                                    children: [
                                      _RadioDot(
                                        selected: selectedReason == reason,
                                      ),
                                      Text(
                                        reason,
                                        style: TextStyle(
                                          fontSize:
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              14,
                                          fontWeight: selectedReason == reason
                                              ? FontWeight.w500
                                              : FontWeight.w400,
                                          color: selectedReason == reason
                                              ? AppColors.textPrimary
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: selectedReason == null
                                  ? null
                                  : () {
                                      Navigator.pop(ctx);
                                      _onAction(RsvStatus.rejected);
                                    },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                backgroundColor: AppColors.textError,
                                disabledBackgroundColor:
                                    AppColors.buttonPrimaryDisabled,
                                shape: SmoothRectangleBorder(
                                  smoothness: 1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Yes, reject entry',
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                backgroundColor:
                                    AppColors.buttonTertiaryPressed,
                                shape: SmoothRectangleBorder(
                                  smoothness: 1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        if (_rsvStatus != null)
          if (widget.isTicket)
            RsvComponent(status: _rsvStatus!)
          else
            ScaleTransition(
              scale: _scaleAnimation,
              child: RsvComponent(status: _rsvStatus!),
            ),
        if (_rsvStatus != null && widget.isTicket == false)
          SlideTransition(
            position: _slideAnimation,
            child: ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: SvgPicture.asset(
                'img/svg/retry.svg',
                package: 'assets',
                width: 15,
                height: 15,
              ),
              label: Text(
                'Scan Another',
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: AppColors.buttonTertiary,
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        Visibility(
          visible: _rsvStatus == null || _rsvStatus == .pending,
          child: Row(
            spacing: 8,
            children: [
              SizedBox(
                width: 212,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _rsvStatus != null
                      ? null
                      : () => _onAction(RsvStatus.entered),
                  icon: SvgPicture.asset(
                    'img/svg/correct.svg',
                    package: 'assets',
                    width: 20,
                    height: 20,
                  ),
                  label: Text(
                    widget.isTicket ? 'Approve Ticket' : 'Confirm Entry',
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (widget.givenStatus?.toLowerCase().contains(
                            "pending",
                          ) ==
                          true) {
                        _showRejectBottomSheet();
                      } else {
                        _onAction(RsvStatus.noShow);
                      }
                    },
                    icon: SvgPicture.asset(
                      'img/svg/error.svg',
                      package: 'assets',
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
                      widget.isTicket ? 'Reject' : 'No Entry',
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffff0003),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff301113),
                      overlayColor: const Color(0xffff0003),
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: selected ? AppColors.signalPopColor : AppColors.textDisabled,
            width: selected ? 1 : 2,
          ),
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.signalPopColor,
                ),
              ),
            )
          : null,
    );
  }
}
