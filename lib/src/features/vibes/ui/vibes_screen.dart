import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/heading.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VibesScreen extends StatelessWidget {
  VibesScreen({super.key});

  final headings = [
    Heading(
      text: "Anyma",
      description: "Pyramids of Giza - 10th, october",
      image: "img/pyramids.jpg",
    ),
    Heading(
      text: "The Gatsby Bar",
      description: "1920s-style luxury experience",
      image: "img/gatsby_bar.jpg",
    ),
  ];
  final headingPageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 354,
            child: PageView.builder(
              itemCount: headings.length,
              controller: headingPageController,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.4),
                        BlendMode.darken,
                      ),
                      image: AssetImage(
                        headings[index].image,
                        package: "assets",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        headings[index].text,
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        headings[index].description,
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 4),

                            Text(
                              "Book",
                              style: AppTextStyles(context).smallSemibold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 43,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: SmoothPageIndicator(
                  controller: headingPageController,
                  count: headings.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withValues(alpha: 0.2),
                    dotHeight: 10,
                    dotWidth: 6,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: SafeArea(
              child: Container(
                width: MediaQuery.widthOf(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Your",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Vibe",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        EventContainer(onView: () {}),
                        SizedBox(height: 20),
                        EventContainer(onView: () {}),
                      ],
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

class EventContainer extends StatelessWidget {
  const EventContainer({super.key, this.onView});
  final VoidCallback? onView;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[400]!,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Event",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTextStyles(context).accumulator * 12,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    CircleAvatar(),
                    Text(
                      "Cairo Jazz Club",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Text("An iconic nightlife hub since 2001."),
                SizedBox(height: 19),
                onView != null
                    ? PrimaryButton(onTap: () async {}, title: "View")
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
