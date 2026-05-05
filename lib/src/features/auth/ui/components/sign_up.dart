import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class SignUpComponent extends ConsumerStatefulWidget {
  const SignUpComponent({super.key});

  @override
  ConsumerState<SignUpComponent> createState() => _SignUpComponentState();
}

class _SignUpComponentState extends ConsumerState<SignUpComponent> {
  final textController = TextEditingController();
  String? phoneNumber;
  final formKey = GlobalKey<FormState>();
  String? phoneError;

  bool enableBtn = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(countryPickerProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign up",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            SizedBox(height: 8),
            Text(
              "Access exclusive spots and luxury experiences.",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16),
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
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: textController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onChanged: (v) {
                            setState(() {
                              phoneNumber = data.dialCode + textController.text;
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
                            TextInputFormatter.withFunction((
                              oldValue,
                              newValue,
                            ) {
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

                          onFieldSubmitted: (v) async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(authServiceProvider)
                                  .sendOTP(phoneNumber!, OTPType.phone);
                              if (!context.mounted) return;
                              context.push("/otp");
                            }
                          },

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (e, s) {
                return Center(child: Text("Error"));
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "By continuing, you agree to to Hyde’x ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: AppTextStyles(context).accumulator * 12,
                ),
                children: [
                  TextSpan(
                    text: "Privacy ",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(text: "and "),
                  TextSpan(
                    text: "Terms",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: PrimaryButton(
            nullbgColor: Color(0xff080808),
            nullfrColor: AppColors.surfaceContainer,
            bgColor: Colors.white,
            frColor: Colors.black,

            onTap: textController.text != ''
                ? () async {
                    if (phoneError != null) {
                      setState(() {
                        phoneError = null;
                      });
                    }

                    if (formKey.currentState!.validate()) {
                      await ref
                          .read(authServiceProvider)
                          .sendOTP(phoneNumber!, OTPType.phone)
                          .catchError((e) {
                            if (e.message.contains("already exists")) {
                              setState(() {
                                phoneError = "Phone already exists";
                              });
                            } else {
                              setState(() {
                                phoneError = e.message;
                              });
                            }
                            return '';
                          });
                      if (context.mounted) {
                        context.push("/otp");
                      }
                    }
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
