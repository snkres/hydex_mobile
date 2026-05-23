import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionRequired extends ConsumerStatefulWidget {
  final Widget child;
  const CameraPermissionRequired({super.key, required this.child});

  @override
  ConsumerState<CameraPermissionRequired> createState() =>
      _CameraPermissionRequiredState();
}

class _CameraPermissionRequiredState
    extends ConsumerState<CameraPermissionRequired>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(cameraPermissionStatusProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionAsync = ref.watch(cameraPermissionStatusProvider);

    return permissionAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => widget.child,
      data: (status) {
        if (status.isGranted || status.isLimited) return widget.child;
        if (status.isDenied) {
          Permission.camera.request().then((_) {
            ref.invalidate(cameraPermissionStatusProvider);
          });
          return const SizedBox.shrink();
        }
        // permanentlyDenied — show UI to open settings
        return const _CameraPermissionDenied();
      },
    );
  }
}

class _CameraPermissionDenied extends StatelessWidget {
  const _CameraPermissionDenied();

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "img/svg/scan.svg",
              package: "assets",
              width: 56,
              height: 56,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Camera access is off",
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
              "You've permanently denied camera access. Open Settings to enable it.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: styles.fontFamily,
                fontSize: styles.accumulator * 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 20 / 14,
              ),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              title: "Open Settings",
              onTap: () async {
                await openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
