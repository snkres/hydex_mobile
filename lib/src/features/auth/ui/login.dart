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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? phoneNumber;
  String? phoneError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final selectedCountry = ref.watch(
                            countryPickerNotifierProvider,
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Sign in to your world of experiences.",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  selectedCountry.when(
                                    data: (data) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              width: 95,
                                              height: 55,
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                      data.emoji,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
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
                                                controller: phoneController,
                                                autofocus: true,

                                                keyboardType:
                                                    TextInputType.phone,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onChanged: (v) {
                                                  if (phoneController.text
                                                      .startsWith("0")) {
                                                    setState(() {
                                                      phoneNumber =
                                                          data.dialCode +
                                                          phoneController.text
                                                              .substring(1);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      phoneNumber =
                                                          data.dialCode +
                                                          phoneController.text;
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
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    await ref
                                                        .read(
                                                          authServiceProvider,
                                                        )
                                                        .sendOTP(
                                                          phoneNumber!,
                                                          OTPType.phone,
                                                        );
                                                    if (!context.mounted)
                                                      return;

                                                    context.push("/otp");
                                                  }
                                                },

                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
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
                                    loading: () => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your password";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          fontSize:
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              12,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: PrimaryButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      await ref
                                          .read(authServiceProvider)
                                          .login(
                                            phoneNumber!,
                                            passwordController.text,
                                          )
                                          .catchError((error) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                        "❌ ${error.message}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                      if (context.mounted) {
                                        context.go("/");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
