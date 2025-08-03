import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                Text(
                  "Enter the security code we sent to *******27 over WhatsApp",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 24),
                Pinput(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => context.push("/password"),
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 247, 247, 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),

            PrimaryButton(onTap: () => context.push("/password")),
          ],
        ),
      ),
    );
  }
}
