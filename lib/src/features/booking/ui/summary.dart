import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/waitlist.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/booking/ui/components/guests_summary.dart';
import 'package:hydex/src/features/booking/ui/components/vendor_container.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class SummaryBooking extends ConsumerWidget {
  const SummaryBooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalGuests = ref.watch(guestsProvider);
    final totalPrice = ref.watch(formattedTotalPriceProvider);
    final booking = ref.watch(createBookProvider);

    return Scaffold(
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: Padding(
        padding: const .symmetric(horizontal: 16),
        child: SizedBox.fromSize(
          size: Size.fromHeight(52),
          child: Consumer(
            builder: (context, ref, _) {
              return LoadingFloatingButton();
            },
          ),
        ),
      ),
      body: SoftEdgeBlur(
        edges: [
          EdgeBlur(
            type: EdgeType.bottomEdge,
            size: 100,
            sigma: 30,
            tintColor: AppColors.backgroundBase,
            controlPoints: [
              ControlPoint(position: 0.5, type: ControlPointType.visible),
              ControlPoint(position: 1, type: ControlPointType.transparent),
            ],
          ),
        ],
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    CustomBackButton(),
                    Text(
                      "Review your booking",
                      style: AppTextStyles(context).secondaryRegular,
                    ),
                  ],
                ),
                SizedBox(height: 26),
                VendorContainer(
                  location: booking!.location,
                  name: booking.name,
                  date: booking.selectedDate!,
                  time: booking.selectedSlot!,
                ),
                SizedBox(height: 24),
                SmoothContainer(
                  borderRadius: .circular(26),
                  color: Color(0xff1E1E20),
                  padding: .all(16),
                  margin: .symmetric(horizontal: 16),
                  smoothness: 1,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "img/svg/total_price.svg",
                        package: "assets",
                        width: 20,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text("Total Price"),
                          Text(
                            "Fees for $totalGuests passes",
                            style: AppTextStyles(context).captionRegular
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          text: "$totalPrice ",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 17,
                            fontWeight: .w600,
                          ),
                          children: [
                            TextSpan(
                              text: "EGP",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                                fontWeight: .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: booking.requiresApproval ?? false,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(height: 24),
                      SmoothContainer(
                        borderRadius: .circular(26),
                        color: Color(0xff1E1E20),
                        padding: .all(16),
                        margin: .symmetric(horizontal: 16),
                        smoothness: 1,
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 4,
                          children: [
                            Text(
                              "Reservation Requires Approval",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                                fontWeight: .w600,
                              ),
                            ),
                            Text(
                              "After submission, Influencer will review your booking. You’ll get a payment link once it’s approved.",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 12,
                                color: AppColors.textSecondary,
                                fontWeight: .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                GuestsSummary(),
                SizedBox(height: 24),

                Padding(
                  padding: const .symmetric(horizontal: 16),
                  child: Text(
                    "Terms and conditions",
                    style: AppTextStyles(
                      context,
                    ).secondaryRegular.copyWith(fontWeight: .w700),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: .all(12),
                  margin: .symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: .circular(16),
                      side: BorderSide(color: AppColors.borderDefault),
                    ),
                  ),
                  child: Center(child: Text("Mwah")),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingFloatingButton extends ConsumerStatefulWidget {
  const LoadingFloatingButton({super.key, this.isApprovalRequired = false});
  final bool isApprovalRequired;

  @override
  ConsumerState<LoadingFloatingButton> createState() =>
      _LoadingFloatingButtonState();
}

class _LoadingFloatingButtonState extends ConsumerState<LoadingFloatingButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: loading
          ? null
          : () async {
              showModalBottomSheet(
                context: context,
                builder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      LottieBuilder.asset(
                        "json/success.json",
                        package: "assets",
                        width: 150,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Your booking is confirmed",
                        style: AppTextStyles(context).primaryBold,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Please arrive at least 15 minutes before the show. Reservations are held for 1 hour",
                        textAlign: .center,
                        style: AppTextStyles(
                          context,
                        ).smallRegular.copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(height: 16),

                      Row(
                        spacing: 8,
                        mainAxisAlignment: .center,
                        children: [
                          SvgPicture.asset(
                            "img/svg/information.svg",
                            package: "assets",
                          ),
                          Text(
                            "Payment will be collected ondoor",
                            style: TextStyle(
                              fontWeight: .w700,
                              fontSize: AppTextStyles(context).accumulator * 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PrimaryButton(
                          onTap: () async {
                            context.push("/", extra: 2);
                          },
                          title: "View my Bookings",
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // setState(() {
              //   loading = true;
              // });

              // final status = await ref
              //     .read(createBookingProvider.future)
              //     .catchError((e) {
              //       if (context.mounted) {
              //         ScaffoldMessenger.of(
              //           context,
              //         ).showSnackBar(SnackBar(content: Text(e.message)));
              //       }
              //       return false;
              //     });
              // if (status && context.mounted) {
              //   showModalBottomSheet(
              //     context: context,
              //     builder: (context) => Center(
              //       child: Column(
              //         mainAxisAlignment: .center,
              //         children: [
              //           LottieBuilder.asset(
              //             "json/success.json",
              //             package: "assets",
              //             width: 150,
              //           ),
              //           SizedBox(height: 8),
              //           Text(
              //             "Your booking is confirmed",
              //             style: AppTextStyles(context).primaryBold,
              //           ),
              //           SizedBox(height: 12),
              //           Text(
              //             "Please arrive at least 15 minutes before the show. Reservations are held for 1 hour",
              //             textAlign: .center,
              //             style: AppTextStyles(context).smallRegular.copyWith(
              //               color: AppColors.textSecondary,
              //             ),
              //           ),
              //           SizedBox(height: 16),

              //           Row(
              //             spacing: 8,
              //             mainAxisAlignment: .center,
              //             children: [
              //               SvgPicture.asset(
              //                 "img/svg/information.svg",
              //                 package: "assets",
              //               ),
              //               Text("Payment will be collected ondoor"),
              //             ],
              //           ),
              //           SizedBox(height: 26),
              //           PrimaryButton(
              //             onTap: () async {
              //               context.go("/", extra: 2);
              //             },
              //             title: "View my Bookings",
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              // }
              // setState(() {
              //   loading = false;
              // });
            },
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,

      shape: RoundedRectangleBorder(borderRadius: .circular(100)),
      label: loading
          ? LottieBuilder.asset(
              "json/dark_loading.json",
              package: "assets",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : Text(
              widget.isApprovalRequired
                  ? "Submit Request"
                  : "Proceed to Payment",
            ),
    );
  }
}
