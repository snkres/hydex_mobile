import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/src/features/boarding/provider/country_picker_provider.dart';
import 'package:hydex/src/features/boarding/ui/components/country_picker.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpComponent extends StatefulWidget {
  const SignUpComponent({super.key});

  @override
  State<SignUpComponent> createState() => _SignUpComponentState();
}

class _SignUpComponentState extends State<SignUpComponent> {
  final textController = TextEditingController();
  String? phoneNumber;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height - 336,
        ),
        child: IntrinsicHeight(
          child: Column(
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
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedCountry = ref
                          .watch(countryPickerNotifierProvider)
                          .requireValue;
                      return Row(
                        spacing: 8,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) =>
                                    CountryPickerBottomSheet(),
                              );
                            },
                            child: Container(
                              height: 70,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Text(
                                    selectedCountry.emoji,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    selectedCountry.dialCode,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Expanded(
                              child: TextFormField(
                                controller: textController,
                                keyboardType: TextInputType.phone,
                                onChanged: (v) {
                                  setState(() {
                                    phoneNumber =
                                        selectedCountry.dialCode +
                                        textController.text;
                                  });
                                },
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "please write phone number";
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9+]+'),
                                  ),
                                ],
                                maxLength: 10,
                                onFieldSubmitted: (v) async {
                                  if (formKey.currentState!.validate()) {
                                    await ref
                                        .read(authServiceProvider)
                                        .sendOTP(phoneNumber!);
                                    if (!context.mounted) return;
                                    context.push("/otp");
                                  }
                                },

                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: "By continuing, you agree to to Hyde’x ",
                      style: TextStyle(color: Color(0xff7A7F99)),
                      children: [
                        TextSpan(
                          text: "Privacy ",
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: "and "),
                        TextSpan(
                          text: "Terms",
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 250),
                child: Consumer(
                  builder: (context, ref, child) {
                    return PrimaryButton(
                      onTap: phoneNumber != null
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(authServiceProvider)
                                    .sendOTP(phoneNumber!);

                                if (!context.mounted) return;

                                context.push("/otp");
                              }
                            }
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
