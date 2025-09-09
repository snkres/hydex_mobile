import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/data/navitems.dart';
import 'package:hydex/src/features/booking/ui/booking_screen.dart';
import 'package:hydex/src/features/settings/ui/settings.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final navItems = [
    NavItem(title: "Home", index: 0, svgPath: "img/svg/home.svg"),
    NavItem(title: "Bookings", index: 1, svgPath: "img/svg/booking.svg"),
    NavItem(title: "Settings", index: 2, svgPath: "img/svg/settings.svg"),
  ];

  final children = [
    VibesScreen(),
    const BookingScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: LiquidGlass(
          glassContainsChild: false,
          settings: LiquidGlassSettings(
            ambientStrength: 0.5,
            lightAngle: 0.5 * pi,
            lightIntensity: 0.5,
            blur: 20,
          ),
          shape: LiquidRoundedRectangle(borderRadius: Radius.circular(32)),
          child: Container(
            width: double.infinity,
            height: 72,
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 28.5,
              children: [
                for (var item in navItems)
                  NavBar(
                    svgPath: item.svgPath,
                    title: item.title,
                    index: item.index,
                    selectedIndex: currentIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = item.index;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      body: children[currentIndex],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.svgPath,
    required this.title,
    required this.onTap,
    required this.selectedIndex,
    required this.index,
  });
  final String svgPath, title;
  final VoidCallback onTap;
  final int selectedIndex, index;

  @override
  Widget build(BuildContext context) {
    final isBooking = index == 1;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 56,
        height: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isBooking ? SizedBox(height: 2) : SizedBox.shrink(),

            SizedBox(
              width: isBooking ? 20 : 19,
              child: SvgPicture.asset(
                svgPath,
                package: "assets",
                colorFilter: ColorFilter.mode(
                  selectedIndex == index
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 6),

            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: selectedIndex == index ? FontWeight.w700 : null,
                  fontSize: AppTextStyles(context).accumulator * 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
