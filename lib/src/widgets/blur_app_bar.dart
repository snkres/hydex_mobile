import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';

class BlurAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BlurAppBar({
    super.key,
    required this.title,
    required this.scrollController,
    this.onBack,
  });

  final String title;
  final ScrollController scrollController;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<BlurAppBar> createState() => _BlurAppBarState();
}

class _BlurAppBarState extends State<BlurAppBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 0;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: _isScrolled
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.2),
                ),
              ),
            )
          : null,
      leading: GestureDetector(
        onTap: widget.onBack ?? () => Navigator.of(context).pop(),
        child: Center(
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderDefault,
                width: 0.8,
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontFamily: styles.fontFamily,
          fontSize: styles.accumulator * 17,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
