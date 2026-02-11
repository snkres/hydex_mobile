import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smooth_corner/smooth_corner.dart';

class VendorContainer extends ConsumerWidget {
  const VendorContainer({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
  });

  final String name, location;
  final DateTime date, time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guests = ref.watch(guestsProvider);
    final selectedPass = ref.read(
      createBookProvider.select((v) => v?.selectedPasses),
    );

    return SmoothContainer(
      borderRadius: .circular(26),
      color: Color(0xff1E1E20),
      padding: .all(16),
      margin: .symmetric(horizontal: 16),
      smoothness: 1,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Vendor Name",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "📍 $location",
            style: AppTextStyles(
              context,
            ).captionRegular.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Date and Time",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "${date.day} ${date.month.toMonthName()} at ${time.toTime()}",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Number of Passes",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "$guests ${selectedPass?.name}",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}

class VenueContainer extends StatelessWidget {
  const VenueContainer({super.key, required this.event});
  final UpcomingEvent event;
  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      borderRadius: .circular(26),
      color: Color(0xff1E1E20),
      padding: .all(16),
      margin: .symmetric(horizontal: 16),
      smoothness: 1,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Visibility(
            visible: event.bookingType == "event",
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Venue",
                  style: AppTextStyles(
                    context,
                  ).captionMedium.copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(height: 4),
                Text(
                  event.vendorName,
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 16,
                    fontWeight: .w600,
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
              ],
            ),
          ),

          Text(
            "Location",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  event.location.address ??
                      "${event.location.street}, ${event.location.city}, ${event.location.country}",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 16,
                    fontWeight: .w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  MapsLauncher.launchCoordinates(
                    event.location.coordinates.lat ?? 0,
                    event.location.coordinates.lng ?? 0,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLighter,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      SvgPicture.asset(
                        "img/svg/directions.svg",
                        package: "assets",
                        width: 13,
                      ),
                      Text(
                        "Directions",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            "Number of Passes",
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 4),
          Text(
            "${event.numberOfGuests == 0 ? 1 : event.numberOfGuests} ${event.passName}",
            style: TextStyle(
              fontSize: AppTextStyles(context).accumulator * 16,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}

extension MonthNameX on int {
  String toMonthName() {
    const names = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",
    ];

    if (this < 1 || this > 12) return "";
    return names[this - 1];
  }
}
