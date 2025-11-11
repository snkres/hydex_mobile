import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class GuestForm extends ConsumerStatefulWidget {
  const GuestForm({super.key,required this.controller});

  final PageController controller;

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
  @override
  Widget build(BuildContext context) {
        final selectedCountry = ref.watch(countryPickerNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              "Add First Guest Info",
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
              controller: nameController,
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
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please add your phone number";
                          }
                          if (v.length > 13) {
                            return "Phone shouldn't be more than 13 characters";
                          }
                          return null;
                        },
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

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "Phone Number"),
                      ),
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
