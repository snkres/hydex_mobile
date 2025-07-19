import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/auth/signup/data/type.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/type_container.dart';
import 'package:hydex/src/features/auth/signup/presentation/providers/signup_providers.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, this.appbar, this.showError = false});

  final PreferredSizeWidget? appbar;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ?? MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Hydex!",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            SizedBox(height: 8),
            Text(
              "Please select your role to enjoy your luxurious experience.",
              style: TextStyle(fontSize: 17, color: Color(0xff5A5A5A)),
            ),
            SizedBox(height: 32),
            Consumer(
              builder: (context, ref, child) {
                return Row(
                  spacing: 16,
                  children: [
                    TypeContainer(
                      title: "Customer",
                      description: "I'm here to find luxury services",
                      svgPath: "img/svg/customer.svg",
                      value: UserType.customer,
                      currentValue: ref.watch(typeNotifierProvider),
                      onTap: (v) {
                        ref.read(typeNotifierProvider.notifier).change(v!);
                      },
                    ),
                    TypeContainer(
                      title: "Vendor",
                      description: "I'm here to provide luxury services",
                      svgPath: "img/vendor.png",
                      value: UserType.vendor,
                      currentValue: ref.watch(typeNotifierProvider),
                      onTap: (v) {
                        ref.read(typeNotifierProvider.notifier).change(v!);
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                return Visibility(
                  visible:
                      showError ||
                      ref.watch(typeNotifierProvider) == UserType.none,
                  child: Text(
                    "Please pick an option to proceed.",
                    style: TextStyle(color: Color(0xffC60A04)),
                  ),
                );
              },
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 61,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  return FilledButton.icon(
                    onPressed: () {
                      final value = ref.read(typeNotifierProvider);
                      if (value == null) {
                        ref
                            .read(typeNotifierProvider.notifier)
                            .change(UserType.none);
                        return;
                      }
                      if (value != UserType.none) {
                        context.push("/verify_phone");
                      }
                    },
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "img/svg/next.svg",
                      package: "assets",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
