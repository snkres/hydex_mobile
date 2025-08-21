import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/boarding/ui/components/pick_type.dart';
import 'package:hydex/src/features/boarding/ui/components/sign_up.dart';

final heightProvider = StateProvider<double>((ref) => 460);

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Explore.",
              style: TextStyle(
                fontSize: 50,
                height: 0.3,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Book.",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Enjoy.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.white,

                height: 0.3,
              ),
            ),
            SizedBox(height: 35),
            Text(
              "For Experience Seekers.",
              style: AppTextStyles.primaryRegular.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 4),

            Text(
              "Enjoy priority bookings, hidden gems, and exclusive perks. All in one place.",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 70),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        // constraints: BoxConstraints(minHeight: 500, maxHeight: 700),
                        builder: (context) {
                          return AnimatedContainer(
                            height: ref.watch(heightProvider),
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 200),
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                                top: 16,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView(
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        if (page == 0) {
                                          ref
                                                  .read(heightProvider.notifier)
                                                  .state =
                                              460;
                                        } else {
                                          ref
                                                  .read(heightProvider.notifier)
                                                  .state =
                                              660;
                                        }
                                      },
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        SizedBox(
                                          child: PickUserType(
                                            pageController: pageController,
                                          ),
                                        ),
                                        SizedBox(child: SignUpComponent()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).whenComplete(() {
                        ref.read(heightProvider.notifier).state = 460;
                      });
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  children: [
                    TextSpan(
                      text: "Sign in",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: AppTextStyles.smallRegular.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
