import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class History extends ConsumerWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(getHistoryProvider);
    return history.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text("Empty History"));
        }
        return Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 100, right: 16),
          child: ListView.separated(
            separatorBuilder: (_, _) =>
                Column(children: [Divider(), SizedBox(height: 16)]),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                HistoryContainer(event: data[index], isHistory: true),
          ),
        );
      },
      error: (e, s) {
        log("History Error", error: e, stackTrace: s);
        return Center(child: Text("Error"));
      },
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    super.key,
    required this.event,
    this.isHistory = false,
  });

  final UpcomingEvent event;
  final bool isHistory;

  String formatDate(DateTime time) {
    return DateFormat('MMM d').format(time);
  }

  String weekdayShort(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  String? getStatus(UpcomingEventStatus status) {
    if (status == UpcomingEventStatus.confirmed ||
        status == .noShow ||
        status == .noEntry) {
      return null;
    }
    return status.name.capitalize();
  }

  Color getStatusColor(UpcomingEventStatus status) {
    switch (status) {
      case UpcomingEventStatus.confirmed:
        return AppColors.textSuccess;
      case UpcomingEventStatus.cancelled:
        return AppColors.textError;
      case UpcomingEventStatus.pending:
        return AppColors.textWarning;
      case UpcomingEventStatus.invitation:
        return AppColors.textBrand;
      default:
        return AppColors.borderBrand;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        "/profile-summary",
        extra: {'event': event, 'isHistory': isHistory},
      ),
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: .circular(24)),
          image: event.media != null
              ? DecorationImage(
                  fit: .cover,
                  image: CachedNetworkImageProvider(event.media?.first ?? ""),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.7),
                    BlendMode.darken,
                  ),
                )
              : null,
          color: event.media == null ? AppColors.signalBrandTint : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: AppTextStyles(context).accumulator * 48,
                    height: AppTextStyles(context).heightAccumulator * 67,
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        smoothness: 1,
                      ),
                      color: AppColors.surfaceContainerInverse,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          event.date.day.toString(),
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 15,
                            color: AppColors.textInverse,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          weekdayShort(event.date).toUpperCase(),
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textInverse,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          getStatus(event.status) ?? "",
                          style: TextStyle(color: getStatusColor(event.status)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          event.name,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 16,
                            fontWeight: .w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          spacing: 8,
                          children: [
                            Row(
                              spacing: 8,

                              children: [
                                SvgPicture.asset(
                                  "img/svg/guests.svg",
                                  package: "assets",
                                  width: 11,
                                ),
                                Text(
                                  "Fri, 12 Nov 2025",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 11,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                spacing: 8,
                                children: [
                                  SvgPicture.asset(
                                    "img/svg/location.svg",
                                    package: "assets",
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      event.location.address ??
                                          "${event.location.street}, ${event.location.city}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                      ),
                                    ),
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
              ),
            ),
            Container(
              alignment: .center,
              padding: .all(16),
              decoration: ShapeDecoration(
                color: AppColors.surfaceContainer,
                shape: RoundedSuperellipseBorder(borderRadius: .circular(16)),
              ),
              child: Row(
                spacing: 8,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("img/svg/qrcode.svg", package: "assets"),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: .start,
                        spacing: 4,
                        children: [
                          Text(
                            "Booking ID:",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                          Text(
                            "#${event.id.substring(0, 8).toUpperCase()}",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: .symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(100),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Text(
                          "View Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: .w600,
                            fontSize: AppTextStyles(context).accumulator * 12,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
