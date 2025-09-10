import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/vibes/data/confirm_booking.dart';
import 'package:hydex/src/features/vibes/ui/components/review_booking.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';

class CreateBooking extends StatefulWidget {
  const CreateBooking({
    super.key,
    required this.controller,
    required this.eventName,
    required this.description,
    required this.id,
  });
  final PageController controller;
  final String eventName, description, id;

  @override
  State<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking> {
  final dateController = TextEditingController();

  final peopleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            "Booking ${widget.eventName}",
            style: AppTextStyles(context).primaryBold,
          ),
          SizedBox(height: 8),
          Text(
            widget.description,
            style: AppTextStyles(context).captionRegular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16),
          Form(
            key: formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: dateController,
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
                                  onPressed: () {
                                    if (dateController.text.isEmpty) {
                                      final DateFormat formatter = DateFormat(
                                        'EEE, d MMM',
                                      );
                                      String formatted = formatter.format(
                                        DateTime.now(),
                                      );
                                      setState(() {
                                        dateController.text = formatted;
                                      });
                                    }
                                    context.pop();
                                  },
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
                                  minimumDate: DateTime.now(),
                                  onDateTimeChanged: (date) {
                                    final DateFormat formatter = DateFormat(
                                      'EEE, d MMM',
                                    );
                                    String formatted = formatter.format(date);
                                    setState(() {
                                      dateController.text = formatted;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter booking date";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Choose Date & Time"),
                ),
                TextFormField(
                  controller: peopleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter people count";
                    }
                    return null;
                  },
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
                Consumer(
                  builder: (context, ref, child) {
                    return PrimaryButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();

                          ref
                              .read(bookingProvider.notifier)
                              .state = ConfirmBooking(
                            eventID: widget.id,
                            people: int.parse(peopleController.text),
                            bookingDate: dateController.text,
                          );

                          widget.controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      title: "Next",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
