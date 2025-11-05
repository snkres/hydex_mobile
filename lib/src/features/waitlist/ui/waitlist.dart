import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:lottie/lottie.dart';

class WaitlistScreen extends ConsumerStatefulWidget {
  const WaitlistScreen({super.key});

  @override
  ConsumerState<WaitlistScreen> createState() => _WaitlistScreenState();
}

class _WaitlistScreenState extends ConsumerState<WaitlistScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    final loadingPath = Theme.brightnessOf(context) == Brightness.dark
        ? "json/waitlist_dark.json"
        : "json/waitlist_light.json";
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.read(authServiceProvider).logout();
                      if (context.mounted) {
                        context.go("/boarding");
                      }
                    },
                    child: Text("Logout"),
                  ),
                ),
                SizedBox(height: 33),

                LottieBuilder.asset(loadingPath, package: "assets", width: 134),
                Text(
                  "Your membership is under review",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Our team is reviewing your details to ensure the best fit for our exclusive community.",
                  textAlign: TextAlign.center,

                  style: AppTextStyles(context).smallRegular.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "img/gold-ticket.png",
                        package: "assets",
                        width: 56,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your exclusive ticket awaits",
                              style: AppTextStyles(context).secondaryMedium
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                  ),
                            ),
                            Text(
                              "Once your membership is approved, you’ll unlock access to our private launch event.",
                              style: AppTextStyles(context).captionRegular
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),
                Text(
                  "You’ll receive a notification once your membership is approved.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles(context).captionRegular.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
