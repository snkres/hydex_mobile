import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/data/navitems.dart';
import 'package:hydex/src/features/profile/ui/profile_screen.dart';
import 'package:hydex/src/features/search/ui/search_screen.dart';
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
    NavItem(index: 0, svgPath: "img/svg/home.svg"),
    NavItem(index: 1, svgPath: "img/svg/search.svg"),
    NavItem(index: 2, svgPath: "img/svg/profile.svg"),
    NavItem(index: 3, svgPath: "img/svg/settings.svg"),
  ];

  final children = [
    VibesScreen(),
    SearchScreen(),
    const ProfileScreen(),
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: .bottomCenter,
        children: [
          children[currentIndex],
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Platform.isIOS ? 0 : 16,
              ),
              child: LiquidGlassLayer(
                settings: LiquidGlassSettings(
                  ambientStrength: 0.5,
                  lightAngle: 0.5 * pi,
                  glassColor: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.4),
                  lightIntensity: 0.5,
                  blur: 20,
                ),
                child: LiquidGlass(
                  glassContainsChild: false,
                  shape: LiquidRoundedRectangle(borderRadius: 100),
                  child: Container(
                    width: AppTextStyles(context).accumulator * 327,
                    height: AppTextStyles(context).heightAccumulator * 56,
                    alignment: .center,
                    padding: .all(4),
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
            ),
          ),
        ],
      ),
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

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior
                            .opaque, // 👈 ensures full area is tappable
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
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSurface
                                        : Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.5),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
