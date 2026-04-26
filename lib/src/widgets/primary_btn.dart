import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_corner/smooth_corner.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    this.title = "Continue",
    this.bgColor = AppColors.buttonPrimary,
    this.frColor = AppColors.textInverse,
    this.nullbgColor = AppColors.buttonPrimaryDisabled,
    this.nullfrColor = AppColors.buttonTextDisabled,
  });

  final Future<void> Function()? onTap;
  final String title;
  final Color bgColor, frColor, nullbgColor, nullfrColor;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            await widget.onTap?.call();
          } finally {
            if (mounted) {
              setState(() {
                loading = false;
              });
            }
          }
        },
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            SmoothRectangleBorder(smoothness: 1, borderRadius: .circular(12)),
          ),
          backgroundColor: WidgetStatePropertyAll(
            widget.onTap != null ? widget.bgColor : widget.nullbgColor,
          ),
          foregroundColor: WidgetStatePropertyAll(
            widget.onTap != null ? widget.frColor : widget.nullfrColor,
          ),
        ),
        child: loading
            ? LottieBuilder.asset(
                "json/dark_loading.json",
                package: "assets",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Text(
                widget.title,
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 15,
                  fontWeight: .w600,
                ),
              ),
      ),
    );
  }
}
