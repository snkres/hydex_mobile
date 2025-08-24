import 'dart:async';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/data/boarding_type.dart';
import 'package:hydex/src/features/auth/ui/components/pick_type.dart';
import 'package:hydex/src/features/auth/ui/components/sign_up.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final pageController = PageController();
  final boardingPageController = PageController();
  late final VideoPlayerController _videoController;
  Timer? _timer;
  int _currentPage = 0;

  final boardings = [
    BoardingType(
      title: "Not for Everyone",
      userType: "For Experience Seekers",
      description:
          "Step into exclusivity, explore unforgettable moments, and unlock member-only perks.",
    ),
    BoardingType(
      title: "Rule the Crowd",
      userType: "For Influencers & Ambassadors",
      description:
          "Promote venues, create experiences, lead your crowd and turn influence into profit.",
    ),
    BoardingType(
      title: "Unlock Growth",
      userType: "For Business Owners",
      description:
          "Grow through a community built around exclusive lifestyle experiences.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
      "video/video.mp4",
      package: "assets",
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: true,
      ),
    );
    _videoController.setLooping(true);
    _videoController.setVolume(0);
    _videoController.initialize().then((_) {
      setState(() {
        _videoController.play();
      });
    });

    _startAutoSwipe();
  }

  @override
  void dispose() {
    pageController.dispose();
    boardingPageController.dispose();
    _videoController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < boardings.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to first page
      }

      boardingPageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1200),
        curve: Cubic(0.23, 1, 0.32, 1), // Custom easing
      );
    });
  }

  void _stopAutoSwipe() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopAutoSwipe();
    _startAutoSwipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

                        builder: (context) {
                          return Wrap(
                            children: [
                              Padding(
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
                                    Center(
                                      child: Container(
                                        height: 4,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          color: Color(0xffDEDEDE),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 22),
                                    ExpandablePageView(
                                      controller: pageController,
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
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextStyles(context).accumulator * 14,
                      ),
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
                  style: AppTextStyles(context).secondaryRegular,
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.push("/login"),
                    ),
                  ],
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withValues(alpha: 0.4),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            "HYDEX",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.4)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.widthOf(context) / 1.75,
                child: PageView.builder(
                  controller: boardingPageController,
                  itemCount: boardings.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                    // Reset timer when user manually swipes
                    _resetTimer();
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          boardings[index].title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            height: 0.9,
                            fontSize: AppTextStyles(context).accumulator * 55,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          boardings[index].userType,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,

                            fontSize: AppTextStyles(context).accumulator * 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            boardings[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: AppTextStyles(context).accumulator * 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: boardingPageController,
                  count: boardings.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withValues(alpha: 0.2),
                    dotHeight: 10,
                    dotWidth: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
