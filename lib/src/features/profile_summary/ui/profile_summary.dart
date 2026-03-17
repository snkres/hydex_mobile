import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/core/ui/widgets/adaptive_image.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/src/features/auth/ui/components/error_snackbar.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/ui/components/vendor_container.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile_summary/components/ticket.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/custom_radio.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProfileSummary extends ConsumerWidget {
  const ProfileSummary({
    super.key,
    required this.event,
    this.isHistory = false,
  });

  final UpcomingEvent event;
  final bool isHistory;

  String formatDateTimeToCustomString(DateTime dt) {
    final datePart = DateFormat('E, MMM d').format(dt);

    final timePart = DateFormat('h:mm a').format(dt);

    return '$datePart • $timePart';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final allGuests = [
      if (user != null)
        ProfileGuests(
          name: user.fullName ?? 'You',
          email: user.email,
          gender: user.gender ?? '',
        ),
      ...event.guests,
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  CustomBackButton(),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          event.name,
                          style: AppTextStyles(context).secondaryRegular,
                        ),
                        Text(
                          formatDateTimeToCustomString(event.date),
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
              VenueContainer(event: event),
              SizedBox(height: 16),
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
                          "Fees for ${allGuests.isEmpty ? 1 : allGuests.length} passes",
                          style: AppTextStyles(context).captionRegular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    event.totalPrice == 0
                        ? Text(
                            "Free",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              fontWeight: .w600,
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              text: "${event.totalPrice} ",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 17,
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
                visible: allGuests.isNotEmpty,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 24),

                    Padding(
                      padding: const .symmetric(horizontal: 16),
                      child: Text(
                        "Guest(s) details",
                        style: AppTextStyles(
                          context,
                        ).secondaryRegular.copyWith(fontWeight: .w700),
                      ),
                    ),
                    SizedBox(height: 12),
                    ...List.generate(
                      allGuests.length,
                      (index) => SmoothContainer(
                        side: BorderSide(color: AppColors.borderDefault),
                        borderRadius: .circular(16),
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: index < (allGuests.length) - 1 ? 8 : 0,
                        ),
                        padding: .all(16),
                        smoothness: 1,
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            SvgPicture.asset(
                              "img/svg/profile.svg",
                              package: "assets",
                            ),
                            SizedBox(width: 9),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  allGuests[index].name,
                                  style: TextStyle(
                                    fontWeight: .w600,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 14,
                                  ),
                                ),
                                Text(
                                  index == 0 && user != null
                                      ? "You"
                                      : "Guest $index",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),

                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    final ticketKey = GlobalKey();
                                    return Wrap(
                                      children: [
                                        RepaintBoundary(
                                          key: ticketKey,
                                          child: Container(
                                            color: Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 6,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: .start,
                                              children: [
                                                Text(
                                                  "Ticket#${event.id.substring(0, 8).toUpperCase()}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTextStyles(
                                                          context,
                                                        ).accumulator *
                                                        20,
                                                    fontWeight: .w700,
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                                TicketContainer(
                                                  backgroundColor: AppColors
                                                      .surfaceContainer,
                                                  upperChild: Column(
                                                    crossAxisAlignment: .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              event.name,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    AppTextStyles(
                                                                      context,
                                                                    ).accumulator *
                                                                    20,
                                                                fontWeight:
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            height: 70,
                                                            decoration: ShapeDecoration(
                                                              image: DecorationImage(
                                                                fit: .cover,
                                                                image: CachedNetworkImageProvider(
                                                                  event
                                                                          .media
                                                                          ?.first ??
                                                                      "",
                                                                ),
                                                              ),
                                                              shape: RoundedSuperellipseBorder(
                                                                side: BorderSide(
                                                                  color: AppColors
                                                                      .borderDefault,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    .circular(
                                                                      8,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          event
                                                                  .location
                                                                  .address ??
                                                              "${event.location.street}, ${event.location.city}, ${event.location.country}",
                                                          maxLines: 2,
                                                          overflow: .ellipsis,
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppTextStyles(
                                                                  context,
                                                                ).accumulator *
                                                                11,
                                                            color: Color(
                                                              0xff77767B,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Divider(),
                                                      SizedBox(height: 16),
                                                      Text(
                                                        "Guest Name",
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppTextStyles(
                                                                context,
                                                              ).accumulator *
                                                              11,
                                                          color: Color(
                                                            0xff77767B,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        allGuests[index].name,
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppTextStyles(
                                                                context,
                                                              ).accumulator *
                                                              16,
                                                          fontWeight: .w700,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        "${allGuests[index].email} - ${allGuests[index].gender}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppTextStyles(
                                                                context,
                                                              ).accumulator *
                                                              12,
                                                          color: Color(
                                                            0xff77767B,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Row(
                                                        mainAxisAlignment:
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                .start,
                                                            spacing: 4,
                                                            children: [
                                                              Text(
                                                                "Date",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      12,
                                                                  color: Color(
                                                                    0xff77767B,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                  'E',
                                                                ).format(
                                                                  event.date,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      16,
                                                                  fontWeight:
                                                                      .w700,
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                  'd MMM y',
                                                                ).format(
                                                                  event.date,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      12,
                                                                  color: Color(
                                                                    0xff77767B,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                .start,
                                                            spacing: 4,
                                                            children: [
                                                              Text(
                                                                "Time",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      12,
                                                                  color: Color(
                                                                    0xff77767B,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                  'hh:mm a',
                                                                ).format(
                                                                  event.date,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      16,
                                                                  fontWeight:
                                                                      .w700,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Doors open 1h before",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      AppTextStyles(
                                                                        context,
                                                                      ).accumulator *
                                                                      12,
                                                                  color: Color(
                                                                    0xff77767B,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  lowerChild: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            10.0,
                                                          ),
                                                      child: Column(
                                                        spacing: 8,
                                                        children: [
                                                          AdaptiveImage(
                                                            height: 125,
                                                            width: 125,
                                                            imageData:
                                                                event.qrCode!,
                                                          ),
                                                          Text(
                                                            "Scan at entrance",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  AppTextStyles(
                                                                    context,
                                                                  ).accumulator *
                                                                  11,
                                                              color: AppColors
                                                                  .textSecondary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          spacing: 12,
                                          children: [
                                            SizedBox(height: 12),
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor: .all(
                                                  AppColors.buttonTertiary,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final boundary =
                                                    ticketKey.currentContext
                                                            ?.findRenderObject()
                                                        as RenderRepaintBoundary?;
                                                if (boundary == null) return;
                                                final image = await boundary
                                                    .toImage(pixelRatio: 3.0);
                                                final byteData = await image
                                                    .toByteData(
                                                      format: ui
                                                          .ImageByteFormat
                                                          .png,
                                                    );
                                                if (byteData == null) return;
                                                final pngBytes = byteData.buffer
                                                    .asUint8List();
                                                final tempDir =
                                                    await getTemporaryDirectory();
                                                final file = File(
                                                  '${tempDir.path}/ticket.png',
                                                );
                                                await file.writeAsBytes(
                                                  pngBytes,
                                                );
                                                await SharePlus.instance.share(
                                                  ShareParams(
                                                    files: [XFile(file.path)],
                                                  ),
                                                );
                                              },
                                              icon: SvgPicture.asset(
                                                "img/svg/send.svg",
                                                package: "assets",
                                              ),
                                              label: Text(
                                                "Send to friend",
                                                style: TextStyle(
                                                  fontWeight: .w600,
                                                  fontSize:
                                                      AppTextStyles(
                                                        context,
                                                      ).accumulator *
                                                      14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "View Pass",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 13,
                                  fontWeight: .w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: event.thingsToKnow.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32),
                      Text(
                        "Things to know".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          fontSize: AppTextStyles(context).accumulator * 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: event.thingsToKnow.length,
                        separatorBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(color: AppColors.borderDefault),
                        ),
                        itemBuilder: (_, index) {
                          return ListTile(
                            contentPadding: .zero,

                            leading: SvgPicture.asset(
                              "img/svg/ar_.svg",
                              width: 15,
                              height: 15,
                              package: "assets",
                            ),
                            title: Text(
                              event.thingsToKnow[index],
                              style: AppTextStyles(context).smallRegular,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: !isHistory,
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 4,
                              children: [
                                Text(
                                  "Cancel Booking?",
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 14,
                                    fontWeight: .w600,
                                  ),
                                ),
                                Text(
                                  "If your plans shifted, you can request a cancellation.",
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
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return CancelationWidget(id: event.id);
                                },
                              );
                            },

                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 13,
                                fontWeight: .w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Visibility(
                visible: event.termsAndConditions != null,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
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
                      child: Center(
                        child: Text(event.termsAndConditions ?? ""),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelationWidget extends StatefulWidget {
  const CancelationWidget({super.key, required this.id});
  final String id;

  @override
  State<CancelationWidget> createState() => _CancelationWidgetState();
}

class _CancelationWidgetState extends State<CancelationWidget> {
  List<String> cancelReasons = [
    "Change of plans",
    "Booked by mistake",
    "Found a better timing",
    "Guest no longer attending",
    "Issue with venue",
  ];

  String? selectedReason;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            12,
            12,
            MediaQuery.of(context).viewInsets.bottom + 12,
          ),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(height: 28),

              Text(
                "Request Cancellation",
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 22,
                  fontWeight: .w700,
                ),
              ),
              SizedBox(height: 12),

              Text(
                "Please select the reason for cancelling your booking.",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppTextStyles(context).accumulator * 14,
                ),
              ),
              ListView.builder(
                padding: .zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReason = cancelReasons[index];
                    });
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    splashColor: AppColors.signalBrandSolid.withValues(
                      alpha: 0.1,
                    ),

                    contentPadding: .zero,
                    leading: CustomRadio(
                      isSelected: selectedReason == cancelReasons[index],
                    ),
                    title: Text(
                      cancelReasons[index],
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppTextStyles(context).accumulator * 14,
                      ),
                    ),
                  ),
                ),

                itemCount: cancelReasons.length,
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  return PrimaryButton(
                    onTap: selectedReason != null
                        ? () async {
                            final result = await ref.read(
                              cancelBookingProvider(
                                id: widget.id,
                                reason: selectedReason!,
                              ).future,
                            );

                            if (result && context.mounted) {
                              int count = 0;
                              ref.refresh(getUpcomingEventsProvider);
                              ref.refresh(getProfileProvider);
                              Navigator.of(
                                context,
                              ).popUntil((_) => count++ >= 2);
                              ScaffoldMessenger.of(context).showSnackBar(
                                successSnackBar(
                                  "Booking cancelled successfully",
                                  context,
                                ),
                              );
                            }
                          }
                        : null,
                    title: "Submit Request",
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
