import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/ui/components/guests_summary.dart';
import 'package:hydex/src/features/booking/ui/components/vendor_container.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/custom_radio.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

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
                  Column(
                    crossAxisAlignment: .start,

                    children: [
                      Text(
                        "[Event Name]",
                        style: AppTextStyles(context).secondaryRegular,
                      ),
                      Text(
                        "Sat, Nov 16 • 10:00 PM",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 26),
              VenueContainer(),
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
                          "Fees for 3 passes",
                          style: AppTextStyles(context).captionRegular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text.rich(
                      TextSpan(
                        text: "5,100 ",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 17,
                          fontWeight: .w600,
                        ),
                        children: [
                          TextSpan(
                            text: "EGP",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              fontWeight: .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
              SmoothContainer(
                side: BorderSide(color: AppColors.borderDefault),
                borderRadius: .circular(16),
                margin: .symmetric(horizontal: 16),
                padding: .all(16),
                smoothness: 1,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    SvgPicture.asset("img/svg/profile.svg", package: "assets"),
                    SizedBox(width: 9),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Hady Soliman",
                          style: TextStyle(
                            fontWeight: .w600,
                            fontSize: AppTextStyles(context).accumulator * 14,
                          ),
                        ),
                        Text(
                          "Guest 1",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextStyles(context).accumulator * 12,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text("View Pass"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              Padding(
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
                      itemCount: ["yalhwy"].length,
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
                            ["yalhwy"][index],
                            style: AppTextStyles(context).smallRegular,
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: 4,
                        children: [
                          Text(
                            "Cancel Booking?",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 14,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            "If your plans shifted, you can request a cancellation.",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
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
                          builder: (context) {
                            return CancelationWidget();
                          },
                        );
                      },

                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 13,
                          fontWeight: .w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

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
    );
  }
}

class CancelationWidget extends StatefulWidget {
  const CancelationWidget({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: .start,
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
          Expanded(
            child: ListView.builder(
              padding: .zero,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  setState(() {
                    selectedReason = cancelReasons[index];
                  });
                },
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

              itemCount: cancelReasons.length,
            ),
          ),
          PrimaryButton(
            onTap: selectedReason != null ? () async {} : null,
            title: "Submit Request",
          ),
        ],
      ),
    );
  }
}
