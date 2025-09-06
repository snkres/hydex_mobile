import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class CreateBooking extends StatelessWidget {
  const CreateBooking({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(
          context,
        ).viewInsets.bottom, // Adjusts for keyboard
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 22),
          Text(
            "Booking Cairo Jazz Club",
            style: AppTextStyles(context).primaryBold,
          ),
          SizedBox(height: 8),
          Text(
            "An iconic nightlife spot in the heart of Cairo, known for its vibrant atmosphere, top DJs, and live performances.",
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),
          Form(
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () => context.pop(),
                                  child: Text(
                                    "Done",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoTheme(
                                data: CupertinoThemeData(
                                  brightness: Theme.brightnessOf(context),
                                ),
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (date) {},
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  decoration: InputDecoration(labelText: "Choose Date & Time"),
                ),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  decoration: InputDecoration(labelText: "Number of Guests"),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          SvgPicture.asset(
                            "img/svg/fee.svg",
                            package: "assets",
                            width: 24,
                          ),
                          Text(
                            "Entry fee",
                            style: AppTextStyles(context).captionMedium,
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          text: "400",
                          style: AppTextStyles(
                            context,
                          ).primaryMedium.copyWith(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: " EGP",
                              style: AppTextStyles(context).captionMedium,
                            ),
                            TextSpan(
                              text: " / per person",
                              style: AppTextStyles(context).captionRegular,
                            ),
                          ],
                        ),
                        style: AppTextStyles(context).primaryMedium,
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  onTap: () async {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  title: "Next",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
