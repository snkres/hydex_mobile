import 'package:flutter/material.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';
import 'package:picker_country/view/text_form_fields/outer_text_form_field.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key, this.appbar});
  final PreferredSizeWidget? appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ?? MyAppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Verify your number",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            SizedBox(height: 8),
            Text(
              "We take privacy very seriously and will never share your phone number with anyone.",
              style: TextStyle(fontSize: 17, color: Color(0xff5A5A5A)),
            ),
            SizedBox(height: 24),
            
          ],
        ),
      ),
    );
  }
}
