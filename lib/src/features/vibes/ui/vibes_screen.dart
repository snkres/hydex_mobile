import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/heading.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/features/vibes/ui/components/confirm_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/create_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
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
                          alignment: Alignment.center,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                books[index].title,
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                books[index].description,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    builder: (context) {
                                      return Consumer(
                                        builder: (context, ref, child) {
                                          return ExpandablePageView(
                                            controller: bookigPageController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              CreateBooking(
                                                controller:
                                                    bookigPageController,
                                                eventName: books[index].title,
                                                id: books[index].id!,
                                                fees: books[index].fees,

                                                description:
                                                    books[index].description,
                                              ),
                                              ReviewBooking(
                                                controller:
                                                    bookigPageController,
                                                eventName: books[index].title,
                                                location: books[index].location,
                                                fees: books[index].fees,
                                              ),
                                              ConfirmBooking(
                                                controller:
                                                    bookigPageController,
                                                eventName: books[index].title,
                                                location: books[index].location,
                                                fees: books[index].fees,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
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
                                      style: AppTextStyles(
                                        context,
                                      ).smallSemibold,
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

                        bookings.when(
                          data: (data) {
                            final books = data.where((e) => !e.top).toList();
                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20),
                              shrinkWrap: true,
                              itemCount: books.length,
                              itemBuilder: (context, index) {
                                return EventContainer(
                                  isNotDetail: true,
                                  onView: () => context.push(
                                    "/details",
                                    extra: books[index].id,
                                  ),
                                  heading: books[index].title,
                                  image: books[index].imageUrl,
                                  description: books[index].description,
                                );
                              },
                            );
                          },
                          error: (e, s) => Center(child: Text("Error")),
                          loading: () => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
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
    this.isNotDetail = false,
  });
  final VoidCallback? onView;
  final String heading, description, image;
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
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(image),
                    ),
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
                ),
                SizedBox(height: 19),
                onView != null
                    ? PrimaryButton(
                        onTap: () async {
                          onView!();
                        },
                        title: "View",
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
