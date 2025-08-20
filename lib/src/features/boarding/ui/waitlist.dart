import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/src/features/boarding/provider/waitlist_provider.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class WaitlistScreen extends StatelessWidget {
  const WaitlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(39.5),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
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
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
                LiquidGlass(
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
                    height: 70,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "img/svg/home.svg",
                              package: "assets",
                              width: 24,
                            ),
                            Text("Home", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "img/svg/settings.svg",
                              package: "assets",
                              width: 24,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        Image.asset("img/stars.png", package: "assets", width: 121),
        SizedBox(height: 12),

        Text.rich(
          TextSpan(
            text: "Congrats! You’re ",
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
        SizedBox(height: 12),

        Text.rich(
          TextSpan(
            text: "Your ticket to our ",
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
        SizedBox(height: 58),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              image: NetworkImage(
                "https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg",
              ),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            spacing: 16,
            children: [
              Text(
                "In the meantime enjoy this offer",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text("25%", style: TextStyle(fontSize: 32, color: Colors.white)),
              Text(
                "Discount",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),

        Text.rich(
          TextSpan(
            text:
                "P.S. Skip the line? Refer 2 friends to move up 10 spots! with code ",
            children: [
              TextSpan(
                text: "#$code",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),

          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
