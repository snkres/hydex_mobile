import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smooth_corner/smooth_corner.dart';

enum _ScanState { idle, loading, success, error }

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late final ScrollController controller;
  _ScanState _scanState = _ScanState.idle;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get _borderColor => switch (_scanState) {
        _ScanState.loading => AppColors.signalBrandSolid,
        _ScanState.success => AppColors.borderSuccess,
        _ScanState.error => AppColors.borderError,
        _ScanState.idle => Colors.transparent,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlurAppBar(title: "QR Scanner", scrollController: controller),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 62.5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: _borderColor,
                    width: 3,
                  ),
                ),
              ),
              child: SmoothClipRRect(
                borderRadius: .circular(50),
                smoothness: 1,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Consumer(
                        builder: (context, ref, _) {
                          return MobileScanner(
                            controller: MobileScannerController(
                              detectionTimeoutMs: 1000,
                            ),
                            onDetectError: (error, stackTrace) {
                              log(
                                "Error Scanning",
                                error: error,
                                stackTrace: stackTrace,
                              );
                            },
                            onDetect: (result) async {
                              if (_scanState != _ScanState.idle) return;
                              final raw = result.barcodes.first.rawValue;
                              if (raw == null) return;
                              final json =
                                  jsonDecode(raw) as Map<String, dynamic>;
                              final bookingId = json['bookingId'] as String?;
                              if (bookingId == null) return;

                              setState(() => _scanState = _ScanState.loading);
                              try {
                                await ref.read(
                                  getScanDetailsProvider(id: bookingId).future,
                                );
                                setState(
                                    () => _scanState = _ScanState.success);
                              } catch (_) {
                                setState(() => _scanState = _ScanState.error);
                              } finally {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                if (mounted) {
                                  setState(() => _scanState = _ScanState.idle);
                                }
                              }
                            },
                          );
                        },
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: switch (_scanState) {
                          _ScanState.loading => _ScanOverlay(
                              key: const ValueKey('loading'),
                              color: AppColors.signalBrandSolid.withAlpha(180),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                          _ScanState.success => _ScanOverlay(
                              key: const ValueKey('success'),
                              color:
                                  AppColors.signalFunSuccess.withAlpha(220),
                              child: const Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                          _ScanState.error => _ScanOverlay(
                              key: const ValueKey('error'),
                              color: const Color(0xFF301113).withAlpha(220),
                              child: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                          _ScanState.idle => const SizedBox.shrink(
                              key: ValueKey('idle'),
                            ),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 42),
            Text(
              switch (_scanState) {
                _ScanState.loading => "Fetching details...",
                _ScanState.success => "Scan successful",
                _ScanState.error => "Something went wrong",
                _ScanState.idle => "Point at guest's QR code",
              },
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 14,
                color: switch (_scanState) {
                  _ScanState.success => AppColors.textSuccess,
                  _ScanState.error => AppColors.textError,
                  _ => AppColors.textSecondary,
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanOverlay extends StatelessWidget {
  final Color color;
  final Widget child;

  const _ScanOverlay({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(child: child),
    );
  }
}
