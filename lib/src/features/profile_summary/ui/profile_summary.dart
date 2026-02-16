import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/components/error_snackbar.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/ui/components/vendor_container.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile_summary/components/ticket.dart';
import 'package:hydex/src/features/vibes/ui/components/ticket_widget.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/custom_radio.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProfileSummary extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                          "Fees for ${event.numberOfGuests == 0 ? 1 : event.numberOfGuests} passes",
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
                visible: event.guestsNames?.isNotEmpty ?? false,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 32),

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
                      event.guestsNames?.length ?? 0,
                      (index) => SmoothContainer(
                        side: BorderSide(color: AppColors.borderDefault),
                        borderRadius: .circular(16),
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: index < (event.guestsNames?.length ?? 0) - 1
                              ? 8
                              : 0,
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
                                  event.guestsNames![index],
                                  style: TextStyle(
                                    fontWeight: .w600,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 14,
                                  ),
                                ),
                                Text(
                                  "Guest ${index + 1}",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),

                            Visibility(
                              visible: false,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    showDragHandle: true,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: .start,
                                              mainAxisAlignment: .start,
                                              children: [
                                                Text(
                                                  "Ticket#1231231",
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
                                                              "ANYMA Presents Genesys",
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
                                                              color: Colors.red,
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
                                                      Text(
                                                        "Location",
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
                                                        "Abdelhady Mohamed Mohamed",
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
                                                        "Hady.soliman@hotmail.com - Male",
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
                                                                "Fri",
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
                                                                "12 Nov 2025",
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
                                                                "09:00 PM",
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
                                                          Container(
                                                            width: 125,
                                                            height: 125,
                                                            color: Colors.red,
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
                                                SizedBox(height: 12),
                                                Row(
                                                  spacing: 12,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                        backgroundColor: .all(
                                                          AppColors
                                                              .buttonTertiary,
                                                        ),
                                                      ),
                                                      onPressed: () {},
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
                                                    ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                        backgroundColor: .all(
                                                          Colors.white,
                                                        ),
                                                      ),
                                                      onPressed: () {},
                                                      icon: Image.asset(
                                                        "img/wallet.png",
                                                        package: "assets",
                                                      ),
                                                      label: Text(
                                                        "Add to Wallet",
                                                        style: TextStyle(
                                                          fontWeight: .w600,
                                                          color: Colors.black,
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
                                            ),
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
                child: SizedBox(height: 32),
              ),

              Visibility(
                visible: event.thingsToKnow.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
