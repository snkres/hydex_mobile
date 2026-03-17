import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final formkey = GlobalKey<FormState>();
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

  bool _hasNameError = false;
  bool _hasInstagramError = false;
  bool _hasAgeError = false;
  bool _hasEmailError = false;
  bool _hasPhoneError = false;

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(countryPickerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formkey,
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
              decoration: InputDecoration(
                labelText: "Full Name",
                filled: true,
                fillColor: _hasNameError
                    ? AppColors.signalFunError
                    : AppColors.surfaceInputField,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.borderError,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.borderError,
                    width: 2,
                  ),
                ),
                errorStyle: TextStyle(color: AppColors.textError),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  setState(() {
                    _hasNameError = true;
                  });
                  return "Please enter your full name";
                }
                if (v.trim().length < 2) {
                  setState(() {
                    _hasNameError = true;
                  });
                  return "Name is too short";
                }
                _hasNameError = false;
                setState(() {
                  _hasNameError = false;
                });
                return null;
              },
            ),

            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: instagramController,
                    decoration: InputDecoration(
                      labelText: "Instagram",
                      filled: true,
                      fillColor: _hasInstagramError
                          ? AppColors.signalFunError
                          : AppColors.surfaceInputField,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.borderError,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.borderError,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(color: AppColors.textError),
                    ),
                    keyboardType: TextInputType.url,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        setState(() {
                          _hasInstagramError = true;
                        });
                        return "Instagram is not correct";
                      }

                      final uri = Uri.tryParse(v.trim());
                      if (uri == null || !uri.hasAbsolutePath) {
                        setState(() {
                          _hasInstagramError = true;
                        });
                        return "Invalid URL";
                      }

                      if (!v.contains("instagram.com")) {
                        setState(() {
                          _hasInstagramError = true;
                        });
                        return "Must be a valid Instagram URL";
                      }

                      setState(() {
                        _hasInstagramError = false;
                      });
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: "Age",
                      counterText: "",
                      filled: true,
                      fillColor: _hasAgeError
                          ? AppColors.signalFunError
                          : AppColors.surfaceInputField,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.borderError,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.borderError,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(color: AppColors.textError),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.startsWith('0')) {
                          return oldValue;
                        }
                        return newValue;
                      }),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        setState(() {
                          _hasAgeError = true;
                        });
                        return "Age is required";
                      }
                      setState(() {
                        _hasAgeError = false;
                      });
                      return null;
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: _hasEmailError
                    ? AppColors.signalFunError
                    : AppColors.surfaceInputField,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.borderError,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.borderError,
                    width: 2,
                  ),
                ),
                errorStyle: TextStyle(color: AppColors.textError),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  setState(() {
                    _hasEmailError = true;
                  });
                  return "Email is required";
                }

                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (!emailRegex.hasMatch(v.trim())) {
                  setState(() {
                    _hasEmailError = true;
                  });
                  return "Enter a valid email";
                }

                setState(() {
                  _hasEmailError = false;
                });
                return null;
              },
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
                            setState(() {
                              _hasPhoneError = true;
                            });
                            return "Please add your phone number";
                          }
                          if (v.length > 13) {
                            setState(() {
                              _hasPhoneError = true;
                            });
                            return "Phone shouldn't be more than 13 characters";
                          }
                          setState(() {
                            _hasPhoneError = false;
                          });
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

                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          filled: true,
                          fillColor: _hasPhoneError
                              ? AppColors.signalFunError
                              : AppColors.surfaceInputField,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.borderError,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.borderError,
                              width: 2,
                            ),
                          ),
                          errorStyle: TextStyle(color: AppColors.textError),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          iconColor: AppColors.textSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () async {
                          if (await Permission.contacts.request().isGranted) {
                            final selectedContact =
                                await context.push("/contacts") as String;
                            setState(() {
                              phoneController.text = selectedContact.substring(
                                3,
                              );
                            });
                          }
                        },
                        child: Icon(Icons.person_outline),
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
                if (formkey.currentState!.validate() &&
                    selectedGender != null) {
                  final guest = Guest(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    email: emailController.text,
                    phoneNumber: phoneNumber!,
                    instagram: instagramController.text,
                    gender: selectedGender!,
                  );
                  await ref
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
                if (selectedGender == null) {
                  Fluttertoast.showToast(
                    msg: "Please select your gender",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
