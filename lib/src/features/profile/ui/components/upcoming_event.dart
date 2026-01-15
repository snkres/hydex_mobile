import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class UpcomingEventSection extends ConsumerWidget {
  const UpcomingEventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(getUpcomingEventsProvider);
    return upcomingEvents.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text("No Upcoming Event"));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            separatorBuilder: (_, _) =>
                Column(children: [Divider(), SizedBox(height: 16)]),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                UpcomingEventContainer(event: data[index]),
          ),
        );
      },
      error: (e, s) => Center(child: Text("Error")),
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class UpcomingEventContainer extends StatelessWidget {
  const UpcomingEventContainer({super.key, required this.event});

  final UpcomingEvent event;
  String formatDate(DateTime time) {
    return DateFormat('MMM d').format(time);
  }

  String weekdayShort(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  Color getStatusBgColor(UpcomingEventStatus status) {
    switch (status) {
      case UpcomingEventStatus.confirmed:
        return AppColors.signalFunSuccess;

      case UpcomingEventStatus.pending:
        return AppColors.signalFunWarning;
      case UpcomingEventStatus.cancelled:
        return AppColors.signalFunError;
      case UpcomingEventStatus.invitation:
        return AppColors.signalFunSuccess;
    }
  }

  Color getStatusFrColor(UpcomingEventStatus status) {
    switch (status) {
      case UpcomingEventStatus.confirmed:
        return AppColors.textSuccess;

      case UpcomingEventStatus.pending:
        return AppColors.textWarning;
      case UpcomingEventStatus.cancelled:
        return AppColors.textError;
      case UpcomingEventStatus.invitation:
        return AppColors.textSuccess;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 67,
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: 48,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    side: BorderSide(color: AppColors.borderBrand, width: 1),
                    borderRadius: BorderRadius.circular(16),
                    smoothness: 1,
                  ),
                  color: AppColors.signalBrandTint,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      event.date.day.toString(),
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 18,
                        color: AppColors.signalBrandSolid,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      weekdayShort(event.date).toUpperCase(),
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 14,
                        color: AppColors.signalBrandSolid,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 16,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            "${formatDate(event.date)} • ${event.time}",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: .symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: getStatusBgColor(event.status),
                        borderRadius: .circular(100),
                      ),
                      child: Text(
                        event.status.name.capitalize(),
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                          color: getStatusFrColor(event.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          spacing: 16,
          children: [
            Row(
              spacing: 4.5,
              children: [
                SvgPicture.asset(
                  "img/svg/location.svg",
                  package: "assets",
                  width: 15,
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    event.location.address ??
                        "${event.location.street}, ${event.location.city}, ${event.location.country}",
                    maxLines: 2,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextStyles(context).accumulator * 14,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 4.5,

              children: [
                SvgPicture.asset(
                  "img/svg/guests.svg",
                  package: "assets",
                  width: 15,
                ),
                Text(
                  "Booked for ${event.numberOfGuests}",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextStyles(context).accumulator * 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        // SizedBox(height: 16),
        // PrimaryButton(
        //   onTap: () async {
        //     context.push("/profile-summary", extra: event);
        //   },
        //   title: "View details",
        //   frColor: AppColors.buttonPrimary,
        //   bgColor: AppColors.buttonTertiary,
        // ),
        SizedBox(height: 16),
      ],
    );
  }
}
