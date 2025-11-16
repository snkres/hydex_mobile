import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/verify_email.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:pinput/pinput.dart';

class OtpEmailScreen extends StatefulWidget {
  const OtpEmailScreen({super.key});
  @override
  State<OtpEmailScreen> createState() => _OtpEmailScreenState();
}

class _OtpEmailScreenState extends State<OtpEmailScreen> {
  String? errorText;
  static final otpController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
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
                                    "We just sent you a text",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final email =
                                          ref.watch(userProvider)?.email ?? "";
                                      return Text(
                                        "Enter the security code we sent to $email",
                                        style: AppTextStyles(context)
                                            .smallRegular
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24),
                                  Form(
                                    key: formKey,
                                    child: Pinput(
                                      autofocus: true,
                                      forceErrorState: true,

                                      controller: otpController,
                                      errorText: errorText,
                                      onChanged: (v) {
                                        setState(() {
                                          otp = v;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      pinputAutovalidateMode:
                                          PinputAutovalidateMode.onSubmit,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "please enter otp";
                                        }
                                        return null;
                                      },
                                      onSubmitted: (_) =>
                                          context.push("/password"),
                                      defaultPinTheme: PinTheme(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    spacing: 16,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () => context.pop(),
                                        icon: SvgPicture.asset(
                                          "img/svg/edit.svg",
                                          package: "assets",
                                        ),
                                        label: Text(
                                          "Change Email",
                                          style: AppTextStyles(context)
                                              .smallRegular
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurfaceVariant,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            return TextButton.icon(
                                              icon: SvgPicture.asset(
                                                "img/svg/resend.svg",
                                                package: "assets",
                                              ),
                                              onPressed: () async {
                                                final email = ref
                                                    .read(userProvider)
                                                    ?.email;
                                                await ref
                                                    .read(authServiceProvider)
                                                    .sendOTP(
                                                      email!,
                                                      OTPType.email,
                                                    );

                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Center(
                                                        child: Text(
                                                          "✅ Code resent successfully",
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              label: Text(
                                                "Resend Code",
                                                style: AppTextStyles(context)
                                                    .smallRegular
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return PrimaryButton(
                                    onTap: otp?.length == 4
                                        ? () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final email = ref
                                                  .read(userProvider)
                                                  ?.email;

                                              await ref
                                                  .read(authServiceProvider)
                                                  .verifyOTP(
                                                    otp: otpController.text,
                                                    identifier: email!,
                                                  )
                                                  .catchError((error) {
                                                    setState(() {
                                                      errorText = error.message;
                                                    });
                                                  });

                                              ref
                                                      .read(
                                                        isEmailVerifiedProvider
                                                            .notifier,
                                                      )
                                                      .state =
                                                  true;

                                              if (!context.mounted) return;

                                              context.push("/password");
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
