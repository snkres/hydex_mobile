import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class ConfirmBooking extends StatelessWidget {
  const ConfirmBooking({
    super.key,
    required this.controller,
    required this.eventName,
    required this.location,
    required this.fees,
  });

  final PageController controller;
  final String eventName, location;
  final double fees;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(
          context,
        ).viewInsets.bottom, // Adjusts for keyboard
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 44,
              decoration: BoxDecoration(
                color: Color(0xffDEDEDE),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 22),
          SvgPicture.asset(
            "img/svg/success.svg",
            package: "assets",
            width: 64,
            height: 64,
          ),
          SizedBox(height: 24),

          Text(
            "Your booking is confirmed",
            style: AppTextStyles(context).primaryBold,
          ),
          SizedBox(height: 8),
          Text(
            eventName,
            style: AppTextStyles(context).smallMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "img/svg/location.svg",
                        package: "assets",
                        width: 20,
                      ),
                      SizedBox(height: 14),
                      Text(
                        location,
                        style: AppTextStyles(context).captionMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "img/svg/fee.svg",
                        package: "assets",
                        width: 20,
                      ),
                      SizedBox(height: 20),
                      Consumer(
                        builder: (context, ref, child) {
                          final book = ref.watch(bookingProvider);
                          return Text.rich(
                            TextSpan(
                              text: (book!.people * fees).toString(),
                              style: AppTextStyles(context).primaryMedium
                                  .copyWith(fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text: " EGP",
                                  style: AppTextStyles(context).captionMedium,
                                ),
                                TextSpan(
                                  text: " / per person",
                                  style: AppTextStyles(context).captionRegular,
                                ),
                              ],
                            ),
                            style: AppTextStyles(context).primaryMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Please arrive at least 15 minutes before the show. Reservations are held for 1 hour.",
            textAlign: TextAlign.center,
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Payment will be collected ondoor",
            textAlign: TextAlign.center,
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),

          SizedBox(height: 24),

          SafeArea(
            child: PrimaryButton(
              onTap: () async {
                context.push("/", extra: 1);
              },
              title: "View My Bookings",
            ),
          ),
        ],
      ),
    );
  }
}
