import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/ui/components/access_container.dart';
import 'package:hydex/src/features/booking/ui/components/bottom_bar.dart';
import 'package:hydex/src/features/booking/ui/components/date_container.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/booking/ui/components/slots_container.dart';
import 'package:hydex/src/features/vibes/domain/event_notifier.dart';
import 'package:hydex/src/widgets/backbtn.dart';

class CreateBooking extends StatefulWidget {
  const CreateBooking({super.key, required this.book});

  final CreateBook book;

  @override
  State<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: BottomBar(),
      body: Stack(
        alignment: .bottomCenter,
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 195,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.signalBrandSolid,
                          AppColors.signalBrandSolid.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomBackButton(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  widget.book.name,
                                  style: TextStyle(
                                    fontWeight: .w600,
                                    fontSize:
                                        AppTextStyles(context).accumulator * 16,
                                  ),
                                ),
                                Text(
                                  widget.book.startTime?.toPrettyString() ??
                                      "Date",
                                  style: AppTextStyles(context).primaryRegular
                                      .copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(),
                          SizedBox(width: 16),
                        ],
                      ),
                      SizedBox(height: 6),
                      GuestsContainer(),
                      // SizedBox(height: 24),
                      // PerkContainer(),
                      SizedBox(height: 24),
                      DateContainer(
                        selectedDate: selectedDate,
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      SlotsContainer(
                        selectedDate: selectedDate,
                        operatingHours: widget.book.operatingHours,
                        startTime: widget.book.startTime,
                      ),
                      SizedBox(height: 24),
                      AccessSection(passes: widget.book.passes),
                      // SizedBox(height: 24),
                      // ExclusivePerks(),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 90,
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
