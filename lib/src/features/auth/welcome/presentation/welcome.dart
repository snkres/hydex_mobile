import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';
import 'package:hydex/src/features/auth/welcome/presentation/personal_info.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, this.appbar});

  final PreferredSizeWidget? appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ?? MyAppBar(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity, minHeight: 61),

          child: FilledButton.icon(
            onPressed: () {},
            iconAlignment: IconAlignment.end,
            label: Text(
              "Let's Go !",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleHeaderDescription(
              title: "We’re excited to have you!",
              description:
                  "Let's start with a few questions to help us tailor your experience.",
            ),

            SizedBox(height: 80),
            Center(
              child: SvgPicture.asset("img/svg/welcome.svg", package: "assets"),
            ),
          ],
        ),
      ),
    );
  }
}
