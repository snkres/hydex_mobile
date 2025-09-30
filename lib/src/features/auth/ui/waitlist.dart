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
  const BaseScreen({super.key, this.initialTab});
  final int? initialTab;
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
  void initState() {
    super.initState();
    if (widget.initialTab != null) {
      currentIndex = widget.initialTab!;
    }
  }

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
            glassColor: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.4),
            lightIntensity: 0.5,
            blur: 20,
          ),
          shape: LiquidRoundedRectangle(borderRadius: Radius.circular(100)),
          child: Container(
            width: (270 * MediaQuery.sizeOf(context).width) / 375,
            height: 70,
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
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
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Semantics(
        button: true,
        label: title,
        selected: selectedIndex == index,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: MediaQuery.widthOf(context) / 4.6,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Color.fromRGBO(125, 125, 125, 0.35)
                  : null,
            ),
            child: SizedBox(
              height: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
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
                        fontWeight: selectedIndex == index
                            ? FontWeight.w700
                            : null,
                        fontSize: AppTextStyles(context).accumulator * 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
