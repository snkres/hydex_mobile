import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class GuestsSummary extends ConsumerWidget {
  const GuestsSummary({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalGuests = ref.watch(guestsProvider);
    final currentGuests = ref.watch(guestFormProvider(totalGuests));
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Guest(s) details",
            style: AppTextStyles(
              context,
            ).secondaryRegular.copyWith(fontWeight: .w700),
          ),
          SizedBox(height: 12),
          currentGuests.when(
            data: (data) {
              log("Guests: ${data.guests}");
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: .center,
                children: data.guests
                    .mapIndexed(
                      (index, guest) =>
                          GuestDetail(guest: guest!, number: index + 1),
                    )
                    .toList(),
              );
            },
            error: (e, s) {
              log("Error:", stackTrace: s, error: e);
              return Text("Error");
            },
            loading: () => Container(
              width: 177,
              decoration: ShapeDecoration(
                color: AppColors.textDisabled,
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: .circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuestDetail extends StatelessWidget {
  const GuestDetail({super.key, required this.guest, required this.number});
  final Guest guest;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12),
      width: 177,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: .circular(16),
          side: BorderSide(color: AppColors.borderDefault),
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 15,
                color: AppColors.textSecondary,
              ),
              Visibility(
                visible: number != 1,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Wrap(
                        children: [
                          GuestFormPopup(
                            guestNumber: number,
                            totalGuests: 3,
                            initialName: guest.name,
                            initialPhone: guest.phoneNumber,
                            initialEmail: guest.email,
                            initialInstagram: guest.instagram,
                            initialGender: guest.gender,
                            selectedGuestIndex: number - 1,
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    size: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(guest.name, style: AppTextStyles(context).smallSemibold),
          SizedBox(height: 2),

          Text(
            "Guest $number",
            style: AppTextStyles(
              context,
            ).captionRegular.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class GuestFormPopup extends ConsumerStatefulWidget {
  const GuestFormPopup({
    super.key,
    this.initialName,
    this.initialInstagram,
    this.initialPhone,
    this.initialEmail,
    this.initialAge,
    this.initialGender,
    required this.guestNumber,
    required this.totalGuests,
    required this.selectedGuestIndex,
  });

  final String? initialName;
  final String? initialInstagram;
  final String? initialPhone;
  final String? initialEmail;
  final String? initialAge;
  final String? initialGender;
  final int guestNumber, totalGuests, selectedGuestIndex;

  @override
  ConsumerState<GuestFormPopup> createState() => _GuestFormPopupState();
}

class _GuestFormPopupState extends ConsumerState<GuestFormPopup> {
  final key = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController instagramController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController ageController;
  String? phoneNumber;
  String? phoneError;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName ?? "");
    instagramController = TextEditingController(
      text: widget.initialInstagram ?? "",
    );
    phoneController = TextEditingController(text: widget.initialPhone ?? "");
    emailController = TextEditingController(text: widget.initialEmail ?? "");
    ageController = TextEditingController(text: widget.initialAge ?? "");
    selectedGender = widget.initialGender;
  }

  String toOrdinal(int number) {
    if (number <= 0) return number.toString();
    final exceptions = [11, 12, 13];
    final lastTwo = number % 100;
    final lastDigit = number % 10;
    if (exceptions.contains(lastTwo)) return '${number}th';
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
                        //   if (v!.isEmpty) return "Please add your phone number";
                        //   if (v.length > 13)
                        //     return "Phone shouldn't be more than 13 characters";
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
                        decoration: InputDecoration(labelText: "Phone Number"),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () async {
                        final selectedContact =
                            await context.push("/contacts") as String?;
                        if (selectedContact != null) {
                          setState(() {
                            phoneController.text = selectedContact.substring(3);
                          });
                        }
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
                    phoneNumber: phoneNumber ?? "",
                    instagram: instagramController.text,
                    gender: selectedGender!,
                  );
                  ref
                      .read(guestFormProvider(3).notifier)
                      .saveGuest(
                        guest,
                        selectedIndex: widget.selectedGuestIndex,
                      );
                  context.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
