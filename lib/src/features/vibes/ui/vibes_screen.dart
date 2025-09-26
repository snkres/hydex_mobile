import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/experience.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class VibesScreen extends ConsumerStatefulWidget {
  const VibesScreen({super.key});

  @override
  ConsumerState<VibesScreen> createState() => _VibesScreenState();
}

class _VibesScreenState extends ConsumerState<VibesScreen> {
  final headingPageController = PageController();
  int currentIndex = 0;
  late final VideoPlayerController _videoController;

  int adIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      ),
    );
    _videoController.setLooping(true);
    _videoController.setVolume(0);
    _videoController.initialize().then((_) {
      setState(() {
        _videoController.play();
      });
    });
  }

  @override
  void dispose() {
    headingPageController.dispose();
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
                    height: MediaQuery.heightOf(context) / 2.4,
                    child: PageView.builder(
                      itemCount: books.length,
                      controller: headingPageController,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            VideoPlayer(_videoController),
                            Container(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 60,
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
                                          AppTextStyles(context).accumulator *
                                          14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    books[index].title,
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "10 October 2025 05:00 PM",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              12,
                                        ),
                                      ),
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
                                ],
                              ),
                            ),
                          ],
                        );
                        // return Container(
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       colorFilter: ColorFilter.mode(
                        //         Colors.black.withValues(alpha: 0.4),
                        //         BlendMode.darken,
                        //       ),
                        //       image: CachedNetworkImageProvider(
                        //         books[index].imageUrl,
                        //       ),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        //   padding: const EdgeInsets.only(top: 32),
                        //   child:
                        // Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 16,
                        //       vertical: 20,
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         Text(
                        //           "Popular".toUpperCase(),
                        //           textAlign: TextAlign.start,
                        //           style: TextStyle(
                        //             fontSize:
                        //                 AppTextStyles(context).accumulator * 14,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w300,
                        //           ),
                        //         ),
                        //         SizedBox(height: 10),
                        //         Text(
                        //           books[index].title,

                        //           style: TextStyle(
                        //             fontSize:
                        //                 AppTextStyles(context).accumulator * 28,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w700,
                        //           ),
                        //         ),

                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Text("Date"),
                        //             ElevatedButton(
                        //               onPressed: () {},
                        //               style: ElevatedButton.styleFrom(
                        //                 backgroundColor: Colors.white,
                        //                 foregroundColor: Colors.black,
                        //               ),
                        //               child: Row(
                        //                 children: [
                        //                   Icon(Icons.add),
                        //                   SizedBox(width: 4),
                        //                   Text(
                        //                     "Reserve",
                        //                     style: AppTextStyles(
                        //                       context,
                        //                     ).smallSemibold,
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(height: 60),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 16,
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
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HYDEX",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        Row(
                          spacing: 12,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.keyboard_arrow_down, size: 20),
                                  Text(
                                    "Egypt",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.2,
                              ),
                              child: SvgPicture.asset(
                                "img/svg/notification.svg",
                                package: "assets",
                              ),
                            ),
                          ],
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
                  boxShadow: [
                    BoxShadow(color: Color(0xff232325), offset: Offset(0, -3)),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 130,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              SmoothContainer(
                                width: 150,
                                height: 130,
                                color: Color.fromRGBO(24, 24, 24, 1),
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
                                        fontWeight: FontWeight.w100,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            14,
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
                                color: Color.fromRGBO(24, 24, 24, 1),

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
                                        fontWeight: FontWeight.w100,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            14,
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
                                color: Color.fromRGBO(24, 24, 24, 1),

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
                                        fontWeight: FontWeight.w100,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            14,
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
                        SizedBox(height: 32),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            18,
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
                                  Text(
                                    "Personalized plans just for you",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                      color: Color.fromRGBO(160, 160, 176, 1),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Explore all",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        bookings.when(
                          data: (data) {
                            final books = data.where((e) => !e.top).toList();
                            return SizedBox(
                              height: 224,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),

                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 20),
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  return EventContainer(
                                    isNotDetail: true,
                                    avatarImage: books[index].imageUrl,
                                    date: books[index].startDate.toString(),
                                    onView: () => context.push(
                                      "/details",
                                      extra: books[index].id,
                                    ),
                                    heading: books[index].title,
                                    image: books[index].imageUrl,
                                    description: books[index].description,
                                  );
                                },
                              ),
                            );
                          },
                          error: (e, s) => Center(child: Text("Error")),
                          loading: () => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                        SizedBox(height: 24),

                        CarouselSlider(
                          items: [
                            SmoothClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              smoothness: 1,
                              child: Container(
                                width: 320,
                                decoration: BoxDecoration(color: Colors.red),
                              ),
                            ),
                            SmoothClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              smoothness: 1,
                              child: Container(
                                width: 320,
                                decoration: BoxDecoration(color: Colors.red),
                              ),
                            ),
                          ],

                          options: CarouselOptions(
                            height: 107,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(
                              milliseconds: 800,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                adIndex = index;
                              });
                            },
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),

                        // SizedBox(
                        //   height: 107,
                        //   child: PageView.builder(
                        //     itemCount: 2,
                        //     controller: adPageController,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 16,
                        //         ),
                        //         child: SmoothClipRRect(
                        //           borderRadius: BorderRadius.circular(24),
                        //           smoothness: 1,
                        //           child: Container(
                        //             width: 320,
                        //             decoration: BoxDecoration(
                        //               color: Colors.red,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        SizedBox(height: 17),
                        Center(
                          child: AnimatedSmoothIndicator(
                            count: 2,
                            activeIndex: adIndex,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white.withValues(alpha: 0.2),
                              dotHeight: 10,
                              dotWidth: 8,
                            ),
                          ),
                        ),
                        SizedBox(height: 42),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Explore our vendors",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Tailored for you",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                      color: Color.fromRGBO(160, 160, 176, 1),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Explore all",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        AspectRatio(
                          aspectRatio: 16 / 11.3,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return VendorContainer();
                            },
                          ),
                        ),
                        SizedBox(height: 41),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "HydeX Curated",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "The finest venues and events in one place.",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 14,
                                  color: Color(0xff858585),
                                ),
                              ),
                              SizedBox(height: 15),
                              CuratedContainer(
                                text: "Own the",
                                heading: "Night",
                                endText: "Unique experiences",
                                image:
                                    "https://missjonesgroup.com/wp-content/uploads/2025/05/music-1-500x500.jpg",
                              ),
                              SizedBox(height: 12),

                              CuratedContainer(
                                reverse: true,
                                text: "Discover",
                                heading: "Sports",
                                endText: "Book courts, arenas, and more.",
                                image:
                                    "https://prested.co.uk/wp-content/webp-express/webp-images/uploads/elementor/thumbs/What-is-padel-tennis-qlo9qaexnbnge339ahpspu1ayl02ndcajnsxp4abr4.png.webp",
                              ),
                              SizedBox(height: 12),

                              CuratedContainer(
                                text: "Find an",
                                heading: "Adventure",
                                endText: "Unique experiences",
                                image:
                                    "https://prested.co.uk/wp-content/webp-express/webp-images/uploads/elementor/thumbs/What-is-padel-tennis-qlo9qaexnbnge339ahpspu1ayl02ndcajnsxp4abr4.png.webp",
                              ),
                              SizedBox(height: 12),

                              CuratedContainer(
                                reverse: true,
                                text: "Discover",
                                heading: "Shows",
                                endText: "Unique experiences",
                                image:
                                    "https://miro.medium.com/v2/resize:fit:1200/1*82jErQ16QNKRXv7PArPkag.jpeg",
                              ),
                              SizedBox(height: 12),

                              CuratedContainer(
                                text: "Taste",
                                heading: "Luxury",
                                endText: "Unique experiences",
                                image:
                                    "https://images.pexels.com/photos/6869485/pexels-photo-6869485.jpeg",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 120),
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

class CuratedContainer extends StatelessWidget {
  const CuratedContainer({
    super.key,
    this.reverse = false,
    required this.text,
    required this.heading,
    required this.endText,
    required this.image,
  });
  final bool reverse;
  final String text, heading, endText, image;
  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      smoothness: 1,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 120,
        decoration: BoxDecoration(color: Color.fromRGBO(20, 20, 20, 1)),
        child: reverse
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 134,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(image),
                          ),
                        ),
                      ),
                      Container(
                        width: 134,

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color.fromRGBO(20, 20, 20, 0.5),
                              Color.fromRGBO(20, 20, 20, 1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Text(
                            heading,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            endText,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Text(
                          heading,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12),

                        Text(
                          endText,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 134,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(image),
                          ),
                        ),
                      ),
                      Container(
                        width: 134,

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.transparent,
                              Color.fromRGBO(20, 20, 20, 0.5),
                              Color.fromRGBO(20, 20, 20, 1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class VendorContainer extends StatelessWidget {
  const VendorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SmoothClipRRect(
        borderRadius: BorderRadius.circular(24),
        smoothness: 1,
        child: Container(
          width: 201,
          decoration: BoxDecoration(color: Color(0xff141414)),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),

                            Color(0xff141414),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Cairo Jazz Club",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        CircleAvatar(),
                      ],
                    ),
                    SizedBox(height: 10.5),

                    Text(
                      "Enjoy a smooth dining experience at the best lounge in Egypt",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 11,
                      ),
                    ),
                    SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Learn More",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
    required this.avatarImage,

    required this.date,
    this.isNotDetail = false,
  });
  final VoidCallback? onView;
  final String heading, description, image, date, avatarImage;
  final bool isNotDetail;
  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      borderRadius: BorderRadius.circular(16),
      smoothness: 1,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 224,
                width: 322,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Container(
                height: 90,
                width: 322,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.9),
                      Colors.black, // stronger at bottom

                      Colors.black, // stronger at bottom
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          avatarImage,
                        ),
                      ),
                      SmoothClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        smoothness: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.50),
                          ),
                          child: Text("Night Life"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28),
                Text(
                  heading,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                SizedBox(
                  width: 250,
                  child: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: AppTextStyles(context).accumulator * 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFF0073),
                    ),
                  ),
                ),
                SizedBox(height: 6),

                Text(
                  date,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "img/svg/favorite.svg",
                        package: "assets",
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(159, 32)),
                      ),
                      onPressed: () {},
                      child: Text("Learn More", textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
