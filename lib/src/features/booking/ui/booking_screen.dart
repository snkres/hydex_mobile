import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/booking_status.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Bookings",
                    style: AppTextStyles(context).primaryBold,
                  ),
                  Text(
                    "Your experiences, all in one place.",
                    style: AppTextStyles(context).smallRegular,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final bookings = ref.watch(getBookingsProvider);
                  return bookings.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64),
                            child: Center(
                              child: Text(
                                "No bookings yet. Start exploring and reserve your next experience.",
                                textAlign: TextAlign.center,
                                style: AppTextStyles(context).smallRegular,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          return BookingContainer(booking: data[index]);
                        },
                      );
                    },
                    error: (e, s) {
                      print("Error: $e,StackTrace: $s");
                      return Text("Error");
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingContainer extends StatelessWidget {
  const BookingContainer({super.key, required this.booking});

  final Booking booking;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEE, d MMM');
    String formatted = formatter.format(date);
    return formatted;
  }

  String getEmoji(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return '✅';
      case BookingStatus.cancelled:
        return '❌';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  booking.event.title,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date:",
                style: AppTextStyles(context).captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                formatDate(booking.bookingDate),
                style: AppTextStyles(context).captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status:",
                style: AppTextStyles(context).captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                '${booking.status.name.capitalize()} ${getEmoji(booking.status)}',
                style: AppTextStyles(context).captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Guests:", style: AppTextStyles(context).captionRegular),
              Text(
                "${booking.numberOfGuests} people",
                style: AppTextStyles(context).captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          Visibility(
            visible:
                booking.status == BookingStatus.confirmed ||
                booking.status == BookingStatus.pending,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Consumer(
                  builder: (context, ref, child) {
                    return GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text(
                                        "Cancel booking?",
                                        style: AppTextStyles(
                                          context,
                                        ).primaryBold,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        "Are you sure you want to cancel this booking? This action cannot be undone.",
                                        style: AppTextStyles(context)
                                            .smallRegular
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                      SizedBox(height: 32),

                                      PrimaryButton(
                                        title: "Cancel",
                                        onTap: () async {
                                          await BookingRepository()
                                              .cancelBooking(id: booking.id!);
                                          ref.invalidate(getBookingsProvider);
                                        },
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
                        "Cancel Booking",
                        style: AppTextStyles(context).captionRegular.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
