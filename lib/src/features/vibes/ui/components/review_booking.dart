import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/vibes/data/confirm_booking.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

final bookingProvider = StateProvider<ConfirmBooking?>((ref) => null);

class ReviewBooking extends ConsumerWidget {
  const ReviewBooking({
    super.key,
    required this.controller,
    required this.location,
    required this.eventName,
  });

  final PageController controller;
  final String location, eventName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            "Review Your Booking",
            style: AppTextStyles(context).primaryBold,
          ),
          SizedBox(height: 8),
          Text(
            eventName,
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "img/svg/calendar_2.svg",
              package: "assets",
              width: 20,
            ),
            title: Text(
              "Date",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Text(
              booking!.bookingDate,
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "img/svg/guests.svg",
              package: "assets",
              width: 26,
            ),
            title: Text(
              "Guests",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Text(
              "${booking.people} people",
              style: AppTextStyles(context).smallMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
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
                      Spacer(),
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
                        "img/svg/fee.svg",
                        package: "assets",
                        width: 20,
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          text: "400",
                          style: AppTextStyles(
                            context,
                          ).primaryMedium.copyWith(fontWeight: FontWeight.w500),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          Column(
            children: [
              PrimaryButton(
                onTap: () async {
                  await ref
                      .read(vibesProvider)
                      .createBooking(
                        booking.eventID,
                        booking.bookingDate,
                        booking.people,
                      );
                  await Future.delayed(Duration(milliseconds: 250));
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                title: "Confirm Booking",
              ),
              TextButton(
                onPressed: () {
                  controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(
                  "Edit Booking",
                  style: AppTextStyles(context).smallBold.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
