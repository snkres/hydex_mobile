import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/ui/components/guests_summary.dart';
import 'package:hydex/src/features/booking/ui/components/vendor_container.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SummaryBooking extends StatelessWidget {
  const SummaryBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: Padding(
        padding: const .symmetric(horizontal: 16),
        child: SizedBox.fromSize(
          size: Size.fromHeight(52),
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,

            shape: RoundedRectangleBorder(borderRadius: .circular(100)),
            label: Text("Submit Request"),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  VendorContainer(),
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
                              "Fees for 3 passes",
                              style: AppTextStyles(context).captionRegular
                                  .copyWith(color: AppColors.textSecondary),
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
                            fontSize: AppTextStyles(context).accumulator * 14,
                            fontWeight: .w600,
                          ),
                        ),
                        Text(
                          "After submission, {Vendor/Influencer} will review your booking. You’ll get a payment link once it’s approved.",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textSecondary,
                            fontWeight: .w600,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: .blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 110,
                  color: AppColors.backgroundBase.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
