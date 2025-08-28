import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

final isEmailVerifiedProvider = StateProvider<bool>((ref) => false);

final forgetPhoneProvider = StateProvider<String>((ref) => '');

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? errorText;
  static final emailController = TextEditingController();

  static final formKey = GlobalKey<FormState>();

  bool changeToEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(),
                          changeToEmail
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      changeToEmail = false;
                                    });
                                  },
                                  child: Text(
                                    "Recover with phone",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                              : Consumer(
                                  builder: (context, ref, child) {
                                    return TextButton(
                                      onPressed: () {
                                        setState(() {
                                          changeToEmail = true;
                                        });
                                        ref
                                            .read(forgetPhoneProvider.notifier)
                                            .dispose();
                                      },
                                      child: Text(
                                        "Recover with email",
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "A link will be sent to you over whatsApp.",
                                    style: AppTextStyles(context).smallRegular
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                  SizedBox(height: 24),
                                  changeToEmail
                                      ? ForgotPasswordEmail(
                                          formKey: formKey,
                                          emailController: emailController,
                                          errorText: errorText,
                                        )
                                      : ForgotPasswordPhone(
                                          formKey: formKey,
                                          emailController: emailController,
                                          errorText: errorText,
                                        ),
                                ],
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return PrimaryButton(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        final phone = ref.read(
                                          forgetPhoneProvider,
                                        );
                                        await ref
                                            .read(authServiceProvider)
                                            .forgetPassword(
                                              changeToEmail
                                                  ? emailController.text
                                                  : phone,
                                              changeToEmail
                                                  ? OTPType.email
                                                  : OTPType.phone,
                                            );
                                        if (context.mounted) {
                                          if (changeToEmail) {
                                            context.push(
                                              "/forgot-response",
                                              extra: false,
                                            );
                                          } else {
                                            context.push(
                                              "/forgot-response",
                                              extra: true,
                                            );
                                          }
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordPhone extends StatelessWidget {
  const ForgotPasswordPhone({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.errorText,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedCountry = ref.watch(countryPickerNotifierProvider);

        return selectedCountry.when(
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
                      color: Theme.of(context).colorScheme.secondaryContainer,
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
                      controller: emailController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        if (value.startsWith('0')) {
                          ref.read(forgetPhoneProvider.notifier).state =
                              data.dialCode + emailController.text.substring(1);
                        } else {
                          ref.read(forgetPhoneProvider.notifier).state =
                              data.dialCode + emailController.text;
                        }
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
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                      ],
                      forceErrorText: errorText,

                      onFieldSubmitted: (v) async {},

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(labelText: "Phone Number"),
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
        );
      },
    );
  }
}

class ForgotPasswordEmail extends StatelessWidget {
  const ForgotPasswordEmail({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.errorText,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: emailController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return "Please enter a valid email";
          }
          return null;
        },
        decoration: InputDecoration(labelText: "Email"),
      ),
    );
  }
}
