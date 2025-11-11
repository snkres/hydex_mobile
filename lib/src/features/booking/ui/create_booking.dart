import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/ui/components/access_container.dart';
import 'package:hydex/src/features/booking/ui/components/bottom_bar.dart';
import 'package:hydex/src/features/booking/ui/components/date_container.dart';
import 'package:hydex/src/features/booking/ui/components/exclusive_perks.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/booking/ui/components/perk_container.dart';
import 'package:hydex/src/features/booking/ui/components/slots_container.dart';
import 'package:hydex/src/widgets/backbtn.dart';

class CreateBooking extends StatelessWidget {
  const CreateBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomBackButton(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Plan Your Experience",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: AppTextStyles(context).accumulator * 16,
                            ),
                          ),
                          Text(
                            "La Jardin",
                            style: AppTextStyles(context).primaryRegular
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 6),
                  GuestsContainer(),
                  SizedBox(height: 24),
                  PerkContainer(),
                  SizedBox(height: 24),
                  DateContainer(),
                  SizedBox(height: 24),
                  SlotsContainer(),
                  SizedBox(height: 24),
                  AccessSection(),
                  SizedBox(height: 24),
                  ExclusivePerks(),
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
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
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
