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
            height: (70 * MediaQuery.sizeOf(context).width) / 375,
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            child: NavBar(
              items: navItems,
              selectedIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: children[currentIndex],
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double _scale = 1.0;

  void _animateScale() async {
    setState(() => _scale = 0.5);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / widget.items.length;

          return Stack(
            alignment: Alignment.center,
            children: [
              // 🔹 Animated highlight that moves & scales
              AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                alignment: Alignment(
                  (widget.selectedIndex / (widget.items.length - 1)) * 2 - 1,
                  0,
                ),
                child: AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  child: Container(
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(125, 125, 125, 0.15),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),

              // 🔹 Nav items row
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(widget.items.length, (i) {
                    final item = widget.items[i];
                    final isSelected = i == widget.selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        _animateScale(); // trigger bounce
                        widget.onTap(i);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: itemWidth,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SVG icon
                            SizedBox(
                              child: SvgPicture.asset(
                                item.svgPath,
                                package: "assets",
                                colorFilter: ColorFilter.mode(
                                  isSelected
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface
                                            .withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Label
                            FittedBox(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface
                                            .withOpacity(0.5),
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : null,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
