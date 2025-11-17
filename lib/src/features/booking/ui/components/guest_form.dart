import 'dart:developer';

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class GuestForm extends ConsumerStatefulWidget {
  const GuestForm({
    super.key,
    required this.controller,
    required this.guestNumber,
    required this.totalGuests,
  });

  final PageController controller;
  final int guestNumber, totalGuests;

  @override
  ConsumerState<GuestForm> createState() => _GuestFormState();
}

class _GuestFormState extends ConsumerState<GuestForm> {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final instagramController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  String? phoneNumber, phoneError;
  String? selectedGender;

  String toOrdinal(int number) {
    if (number <= 0) return number.toString();

    final exceptions = [11, 12, 13];
    final lastTwo = number % 100;
    final lastDigit = number % 10;

    if (exceptions.contains(lastTwo)) {
      return '${number}th';
    }

    switch (lastDigit) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(countryPickerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              "Add ${toOrdinal(widget.guestNumber)} Guest Info",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: instagramController,
                    decoration: InputDecoration(labelText: "Instagram Link"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: ageController,

                    decoration: InputDecoration(labelText: "Age"),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            selectedCountry.when(
              data: (data) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CountryPickerBottomSheet(),
                        );
                      },
                      child: Container(
                        width: 95,
                        height: 55,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(data.emoji, style: TextStyle(fontSize: 20)),
                              Text(data.dialCode),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        onChanged: (v) {
                          setState(() {
                            phoneNumber = data.dialCode + phoneController.text;
                          });
                        },
                        // validator: (v) {
                        //   if (v!.isEmpty) {
                        //     return "Please add your phone number";
                        //   }
                        //   if (v.length > 13) {
                        //     return "Phone shouldn't be more than 13 characters";
                        //   }
                        //   return null;
                        // },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (data.code == "EG" &&
                                newValue.text.startsWith('0')) {
                              return oldValue;
                            }
                            return newValue;
                          }),
                          LengthLimitingTextInputFormatter(
                            data.code == "EG" ? 10 : 13,
                          ),
                        ],

                        forceErrorText: phoneError,

                        onFieldSubmitted: (v) async {},

                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "Phone Number"),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // <-- rounded rectangle
                        ),
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () async {
                        final selectedContact =
                            await context.push("/contacts") as String;
                        setState(() {
                          phoneController.text = selectedContact.substring(3);
                        });
                      },
                      child: Icon(Icons.person_outline),
                    ),
                  ],
                );
              },
              error: (e, s) => SizedBox.shrink(),
              loading: () => SizedBox.shrink(),
            ),

            Row(
              spacing: 8,
              children: [
                CustomChip(
                  title: "Male",
                  isSelected: selectedGender == "Male",
                  onTap: () {
                    setState(() {
                      selectedGender = "Male";
                    });
                  },
                ),
                CustomChip(
                  title: "Female",
                  isSelected: selectedGender == "Female",
                  onTap: () {
                    setState(() {
                      selectedGender = "Female";
                    });
                  },
                ),
              ],
            ),

            PrimaryButton(
              onTap: () async {
                if (key.currentState!.validate()) {
                  final guest = Guest(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumber!,
                    instagram: instagramController.text,
                    gender: selectedGender!,
                  );

                  ref
                      .read(guestFormProvider(widget.totalGuests).notifier)
                      .saveGuest(guest);
                  ref
                      .read(guestFormProvider(widget.totalGuests).notifier)
                      .next();
                  if (widget.guestNumber + 1 == widget.totalGuests) {
                    context.push("/summary");
                    return;
                  }

                  widget.controller.nextPage(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
