import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/profile_summary/components/ticket.dart';
import 'package:hydex/src/features/scan/ui/components/rsv_component.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ScanOutput extends StatelessWidget {
  const ScanOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                BackButton(),
                Text(
                  "TICKET#1231231",
                  style: TextStyle(fontSize: 20, fontWeight: .w700),
                ),
                TicketContainer(
                  backgroundColor: AppColors.surfaceContainer,
                  upperChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Neon Nights Festival",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: ShapeDecoration(
                              color: AppColors.surfaceContainer,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.borderDefault,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "12 Harbor Blvd, Miami, US",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 11,
                            color: Color(0xff77767B),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        "Guest Name",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 11,
                          color: Color(0xff77767B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Alex Johnson",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "VIP Ticket",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                          color: Color(0xff77767B),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                              Text(
                                "Sat",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "14 Jun 2025",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                              Text(
                                "09:00 PM",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Doors open 1h before",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        spacing: 8,
                        children: [
                          Icon(Icons.qr_code, size: 125),
                          Text(
                            "Scan at entrance",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                RsvComponent(status: .entered),
                Row(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: 212,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'img/svg/correct.svg',
                          package: "assets",
                          width: 20,
                          height: 20,
                        ),
                        label: Text(
                          "Confirm Entry",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff6e1fd8),
                          shape: SmoothRectangleBorder(
                            smoothness: 1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'img/svg/error.svg',
                            package: "assets",
                            width: 20,
                            height: 20,
                          ),
                          label: Text(
                            "No Entry",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffff0003),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff301113),
                            shape: SmoothRectangleBorder(
                              smoothness: 1,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
