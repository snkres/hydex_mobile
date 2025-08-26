import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/waitlist_provider.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:lottie/lottie.dart';

class WaitlistScreen extends StatefulWidget {
  const WaitlistScreen({super.key});

  @override
  State<WaitlistScreen> createState() => _WaitlistScreenState();
}

class _WaitlistScreenState extends State<WaitlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff00060b),
      body: Stack(
        children: [
          Image.asset(
            "img/gradient_2.png",
            width: double.infinity,
            package: "assets",
            fit: BoxFit.cover,
          ),
          LottieBuilder.asset(
            'json/confetti.json',
            package: "assets",
            fit: BoxFit.cover,
            renderCache: RenderCache.raster,
          ),
          SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final waitlist = ref.watch(waitlistProvider);
                return waitlist.when(
                  data: (data) {
                    return WaitingWidget(
                      position: data.originalPosition,
                      code: data.referralCode,
                    );
                  },
                  error: (e, s) {
                    return Center(child: Text("Error"));
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: LiquidGlass(
                glassContainsChild: false,

                settings: LiquidGlassSettings(
                  ambientStrength: 0.6,
                  lightAngle: 0.2 * pi,
                  lightIntensity: 0.5,
                  blur: 20,
                ),
                shape: LiquidRoundedRectangle(
                  borderRadius: Radius.circular(32),
                ),
                child: Container(
                  width: double.infinity,
                  height: 72,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 28,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "img/svg/home.svg",
                            package: "assets",
                            width: 24,
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "img/svg/settings.svg",
                            package: "assets",
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              Colors.white.withValues(alpha: 0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: 6),

                          Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key, required this.position, required this.code});

  final String position, code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48),

        Image.asset("img/stars.png", package: "assets", width: 121),
        SizedBox(height: 14),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39.5),
          child: Text.rich(
            TextSpan(
              text: "Congrats! You’re ",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 32,
              ),
              children: [
                TextSpan(
                  text: "${position}th on the waitlist.",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),

            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
        SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39.5),
          child: Text.rich(
            TextSpan(
              text: "Your ticket to our ",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 14,
              ),
              children: [
                TextSpan(
                  text: "exclusive launch party ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: "unlocks when you’re in!"),
              ],
            ),

            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        SizedBox(height: 58),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Enjoy this offer",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Cairo jazz Club",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "25%",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              "Show this screen and your registered mobile number to your waiter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        SizedBox(height: 32),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Expanded(
            child: Text.rich(
              TextSpan(
                text:
                    "P.S. Skip the line? Refer 2 friends to move up 10 spots! with code ",
                children: [
                  TextSpan(
                    text: "#$code ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 16,
                        constraints: BoxConstraints(),
                        alignment: Alignment.center,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: "#$code"));
                        },
                        icon: SvgPicture.asset(
                          "img/svg/copy.svg",
                          package: "assets",
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
