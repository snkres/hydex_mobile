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
import 'package:smooth_corner/smooth_corner.dart';

class ScanActionButtons extends ConsumerStatefulWidget {
  const ScanActionButtons({super.key, required this.bookingId});

  final String bookingId;

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
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        if (_rsvStatus != null)
          ScaleTransition(
            scale: _scaleAnimation,
            child: RsvComponent(status: _rsvStatus!),
          ),
        if (_rsvStatus != null)
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
          visible: _rsvStatus == null,
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
                    'Confirm Entry',
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6e1fd8),
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
                    onPressed: _rsvStatus != null
                        ? null
                        : () => _onAction(RsvStatus.noShow),
                    icon: SvgPicture.asset(
                      'img/svg/error.svg',
                      package: 'assets',
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
                      'No Entry',
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
