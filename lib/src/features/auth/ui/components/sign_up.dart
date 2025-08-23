import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/boarding.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(countryPickerNotifierProvider);
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
              "Access the city’s most coveted spots, luxury deals, and curated experiences.",
              style: TextStyle(fontSize: 14, color: Color(0xff7A7F99)),
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
                          autofocus: true,

                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onChanged: (v) {
                            if (textController.text.startsWith("0")) {
                              setState(() {
                                phoneNumber =
                                    data.dialCode +
                                    textController.text.substring(1);
                              });
                            } else {
                              setState(() {
                                phoneNumber =
                                    data.dialCode + textController.text;
                              });
                            }
                          },
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Please write phone number";
                            }
                            if (v.length > 13) {
                              return "Phone shouldn't be more than 13 characters";
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9+]+'),
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
                  color: Color(0xff7A7F99),
                  fontSize: AppTextStyles(context).accumulator * 12,
                ),
                children: [
                  TextSpan(
                    text: "Privacy ",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: "and "),
                  TextSpan(
                    text: "Terms",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(decoration: TextDecoration.underline),
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
            onTap: phoneNumber != null
                ? () async {
                    if (formKey.currentState!.validate()) {
                      await ref
                          .read(authServiceProvider)
                          .sendOTP(phoneNumber!, OTPType.phone);
                      if (context.mounted) {
                        context.go("/otp");
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
