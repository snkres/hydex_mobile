import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:smooth_corner/smooth_corner.dart';

class RsvComponent extends StatelessWidget {
  const RsvComponent({super.key, required this.status});

  final RsvStatus status;

  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      smoothness: 1,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        color: status.backgroundColor,
        child: Row(
          spacing: 12,
          children: [
            if (status.svgPath != null)
              SvgPicture.asset(
                status.svgPath!,
                package: 'assets',
                width: 22,
                height: 22,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                Text(
                  status.label,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 14,
                    fontWeight: FontWeight.w600,
                    color: status.textColor,
                    height: 1.3,
                  ),
                ),
                Text(
                  status.subLabel,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff89898f),
                    height: 16 / 12,
                  ),
                ),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
