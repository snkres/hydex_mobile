import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

final isEmailVerifiedProvider = StateProvider<bool>((ref) => false);

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String? errorText;
  static final emailController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  String? email;
  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "img/gradient.png",
            package: "assets",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter your email",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "A code will be sent to your inbox",
                                    style: AppTextStyles(context).smallRegular
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                  SizedBox(height: 24),
                                  Form(
                                    key: formKey,
                                    child: TextFormField(
                                      controller: emailController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your email";
                                        }
                                        final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        );
                                        if (!emailRegex.hasMatch(value)) {
                                          return "Please enter a valid email";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return PrimaryButton(
                                    onTap: email != ''
                                        ? () async {
                                            ref
                                                .read(
                                                  userNotifierProvider.notifier,
                                                )
                                                .create(
                                                  email: emailController.text,
                                                );
                                            if (formKey.currentState!
                                                .validate()) {
                                              ref
                                                  .read(
                                                    userNotifierProvider
                                                        .notifier,
                                                  )
                                                  .create(
                                                    email: emailController.text,
                                                  );

                                              await ref
                                                  .read(authServiceProvider)
                                                  .sendOTP(
                                                    emailController.text,
                                                    OTPType.email,
                                                  )
                                                  .catchError((error) {
                                                    if (error.message.contains(
                                                      "already exists",
                                                    )) {
                                                      setState(() {
                                                        errorText =
                                                            "Email already exists";
                                                      });
                                                    } else {
                                                      setState(() {
                                                        errorText =
                                                            error.message;
                                                      });
                                                    }
                                                  });
                                              if (!context.mounted) return;
                                              ref
                                                  .read(
                                                    userNotifierProvider
                                                        .notifier,
                                                  )
                                                  .create(
                                                    email: emailController.text,
                                                  );
                                              context.push("/otp/email");
                                            }
                                          }
                                        : null,
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
