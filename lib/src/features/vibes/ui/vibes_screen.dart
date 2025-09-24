import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/heading.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/confirm_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/create_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VibesScreen extends ConsumerStatefulWidget {
  const VibesScreen({super.key});

  @override
  ConsumerState<VibesScreen> createState() => _VibesScreenState();
}

class _VibesScreenState extends ConsumerState<VibesScreen> {
  final headingPageController = PageController();
  final bookigPageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    headingPageController.dispose();
    bookigPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(getEventsProvider);

    return Scaffold(
      body: Stack(
        children: [
          bookings.when(
            data: (data) {
              final books = data.where((e) => e.top).toList();
              return Stack(
                children: [
                  SizedBox(
                    height: 354,
                    child: PageView.builder(
                      itemCount: books.length,
                      controller: headingPageController,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withValues(alpha: 0.4),
                                BlendMode.darken,
                              ),
                              image: CachedNetworkImageProvider(
                                books[index].imageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 32),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Popular".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  books[index].title,

                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Date"),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add),
                                          SizedBox(width: 4),
                                          Text(
                                            "Reserve",
                                            style: AppTextStyles(
                                              context,
                                            ).smallSemibold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 60),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 98,
                    left: 16,
                    child: SafeArea(
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: headingPageController,
                          count: books.length,
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
                  Positioned(
                    top: 50,
                    left: 16,
                    child: Row(
                      children: [
                        Text(
                          "HYDEX",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (e, s) => Center(child: Text("Error")),
            loading: () => Center(child: CircularProgressIndicator.adaptive()),
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
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              SmoothContainer(
                                width: 150,
                                height: 130,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                smoothness: 1,
                                padding: EdgeInsets.all(12),
                                borderRadius: BorderRadius.circular(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 24,
                                      "img/svg/fire.svg",
                                      package: "assets",
                                    ),
                                    Spacer(),
                                    Text(
                                      "Happening",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            18,
                                      ),
                                    ),
                                    Text(
                                      "Tonight",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6),
                              SmoothContainer(
                                width: 150,
                                height: 130,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                smoothness: 1,
                                padding: EdgeInsets.all(12),
                                borderRadius: BorderRadius.circular(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 24,
                                      "img/svg/location_pin.svg",
                                      package: "assets",
                                    ),
                                    Spacer(),
                                    Text(
                                      "Happening",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            18,
                                      ),
                                    ),
                                    Text(
                                      "Near me",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6),
                              SmoothContainer(
                                width: 150,
                                height: 130,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                smoothness: 1,
                                padding: EdgeInsets.all(12),
                                borderRadius: BorderRadius.circular(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Search &",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            18,
                                      ),
                                    ),
                                    Text(
                                      "Explore",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 32,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "For You, ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Hady",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("Personalized plans just for you"),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Explore all"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: EventContainer(
                            heading: "Adriatique Show",
                            description: "Adriatique x Adriatique",
                            image: "image",
                            date: "Tue, 23 Sep, Kings Valley Rd, Luxor",
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Your",
                        //       style: TextStyle(
                        //         fontSize:
                        //             AppTextStyles(context).accumulator * 16,
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //     ),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       "Vibe",
                        //       style: TextStyle(
                        //         fontSize:
                        //             AppTextStyles(context).accumulator * 16,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20),

                        // bookings.when(
                        //   data: (data) {
                        //     final books = data.where((e) => !e.top).toList();
                        //     return ListView.separated(
                        //       physics: NeverScrollableScrollPhysics(),
                        //       separatorBuilder: (context, index) =>
                        //           SizedBox(height: 20),
                        //       shrinkWrap: true,
                        //       itemCount: books.length,
                        //       itemBuilder: (context, index) {
                        //         return EventContainer(
                        //           isNotDetail: true,
                        //           onView: () => context.push(
                        //             "/details",
                        //             extra: books[index].id,
                        //           ),
                        //           heading: books[index].title,
                        //           image: books[index].imageUrl,
                        //           description: books[index].description,
                        //         );
                        //       },
                        //     );
                        //   },
                        //   error: (e, s) => Center(child: Text("Error")),
                        //   loading: () => Center(
                        //     child: CircularProgressIndicator.adaptive(),
                        //   ),
                        // ),
                        SizedBox(height: 100),
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
  const EventContainer({
    super.key,
    this.onView,
    required this.heading,
    required this.description,
    required this.image,
    required this.date,
    this.isNotDetail = false,
  });
  final VoidCallback? onView;
  final String heading, description, image, date;
  final bool isNotDetail;
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(image),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(image),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Night Life",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ),
                  ],
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
                    Expanded(
                      child: Text(
                        heading,
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Text(
                  description,
                  maxLines: isNotDetail ? 1 : null,
                  overflow: isNotDetail ? TextOverflow.clip : null,
                  style: TextStyle(color: Color(0xfffff0073)),
                ),
                Text(date),
                SizedBox(height: 19),
                onView != null
                    ? PrimaryButton(
                        onTap: () async {
                          onView!();
                        },
                        title: "Learn More",
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
