import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/src/features/boarding/provider/country_picker_provider.dart';
import 'package:hydex/src/features/boarding/ui/boarding.dart';
import 'package:hydex/src/features/boarding/ui/components/country_picker.dart';
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
  final FocusNode _focusNode = FocusNode();

  void _remove() {
    if (!_focusNode.hasFocus) {
      ref.read(heightProvider.notifier).state = 340;
    } else {
      ref.read(heightProvider.notifier).state = 650;
    }
  }

  @override
  void initState() {
    _focusNode.addListener(_remove);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: CupertinoColors.extraLightBackgroundGray,
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () async {
                  node.unfocus();
                  if (formKey.currentState!.validate()) {
                    await ref.read(authServiceProvider).sendOTP(phoneNumber!);
                    if (!context.mounted) return;
                    context.push("/otp");
                  }
                },
                child: Container(
                  color: CupertinoColors.extraLightBackgroundGray,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Done",
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(countryPickerNotifierProvider);
    return KeyboardActions(
      config: _buildConfig(context),
      child: Column(
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
                          height: 80,
                          width: 95,
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
                                Text(
                                  data.emoji,
                                  style: TextStyle(fontSize: 20),
                                ),
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
                            focusNode: _focusNode,
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            onChanged: (v) {
                              setState(() {
                                phoneNumber =
                                    data.dialCode + textController.text;
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
                error: (e, s) {
                  return Center(child: Text("Error"));
                },
                loading: () => Center(child: CircularProgressIndicator()),
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
            padding: const EdgeInsets.only(bottom: 16),
            child: PrimaryButton(
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
            ),
          ),
        ],
      ),
    );
  }
}
