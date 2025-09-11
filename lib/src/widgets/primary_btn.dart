import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:lottie/lottie.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    this.title = "Continue",
  });

  final Future<void> Function()? onTap;
  final String title;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final loadingPath = Theme.brightnessOf(context) == Brightness.dark
        ? "json/dark_loading.json"
        : "json/light_loading.json";
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            await widget.onTap?.call(); // Wait for the async operation
          } finally {
            if (mounted) {
              // Check if widget is still mounted
              setState(() {
                loading = false;
              });
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            widget.onTap != null
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primaryContainer,
          ),
          foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: loading
            ? LottieBuilder.asset(
                loadingPath,
                package: "assets",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Text(widget.title, style: AppTextStyles(context).smallBold),
      ),
    );
  }
}
