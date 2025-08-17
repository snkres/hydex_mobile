import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? errorText;
  static final otpController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Verify with email",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We just sent you a text",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    final phone = ref.watch(userNotifierProvider)?.phone ?? "";
                    return Text(
                      "Enter the security code we sent to $phone over WhatsApp",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                    keyboardType: TextInputType.number,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter otp";
                      }
                      return null;
                    },
                    onSubmitted: (_) => context.push("/password"),
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Consumer(
              builder: (context, ref, child) {
                return PrimaryButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await ref
                          .read(authServiceProvider)
                          .verifyOTP(otp: otpController.text)
                          .catchError((error) {
                            setState(() {
                              errorText = error.message;
                            });
                          });
                      context.push("/password");
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
