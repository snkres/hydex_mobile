import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/cache/cache_helper.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/waitlist_provider.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:lottie/lottie.dart';

class WaitlistScreen extends StatefulWidget {
  const WaitlistScreen({super.key});

  @override
  State<WaitlistScreen> createState() => _WaitlistScreenState();
}

class _WaitlistScreenState extends State<WaitlistScreen> {
  bool isHome = true;

  @override
  void initState() {
    super.initState();
    CacheHelper.setBool("waitlist", value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: LiquidGlass(
          glassContainsChild: false,

          settings: LiquidGlassSettings(
            ambientStrength: 0.5,
            lightAngle: 0.5 * pi,
            lightIntensity: 0.5,
            blur: 20,
          ),
          shape: LiquidRoundedRectangle(borderRadius: Radius.circular(32)),
          child: Container(
            width: double.infinity,
            height: 72,
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 28.5,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHome = true;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "img/svg/home.svg",
                        package: "assets",
                        width: 19,
                        colorFilter: ColorFilter.mode(
                          isHome
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: isHome
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                          fontWeight: isHome ? FontWeight.w700 : null,
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHome = false;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "img/svg/settings.svg",
                        package: "assets",

                        width: 19,
                        colorFilter: ColorFilter.mode(
                          isHome
                              ? Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5)
                              : Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 6),

                      Text(
                        "Settings",
                        style: TextStyle(
                          color: isHome
                              ? Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5)
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isHome ? FontWeight.w700 : null,
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          isHome
              ? Image.asset(
                  "img/gradient_2.png",
                  width: double.infinity,
                  package: "assets",
                  fit: BoxFit.cover,
                )
              : SizedBox.shrink(),

          isHome
              ? LottieBuilder.asset(
                  'json/confetti.json',
                  package: "assets",

                  repeat: false,
                  height: MediaQuery.heightOf(context),
                  fit: BoxFit.cover,
                )
              : SizedBox.shrink(),

          isHome
              ? SingleChildScrollView(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final waitlist = ref.watch(waitlistProvider);
                      return waitlist.when(
                        data: (data) {
                          return WaitingWidget(
                            position: data.originalPosition,
                            code: data.referralCode,
                          );
                        },
                        error: (e, s) {
                          return Center(child: Text("Error"));
                        },
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                )
              : SettingsWaitlist(),
        ],
      ),
    );
  }
}

class SettingsWaitlist extends StatelessWidget {
  const SettingsWaitlist({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(currentUserProvider);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: AppTextStyles(context).accumulator * 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push("/terms"),
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,

                          decoration: TextDecoration.underline,
                          fontSize: AppTextStyles(context).accumulator * 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                user.when(
                  data: (data) {
                    return Column(
                      key: UniqueKey(),
                      children: [
                        TextFormField(
                          initialValue: data!.fullName,
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          initialValue: data.email,
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          initialValue: data.phone,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ],
                    );
                  },
                  error: (e, s) {
                    print("❌ ERROR: $e | StackTrace: $s");
                    return Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () {
                    return Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 6,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 4,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                color: Color(0xffDEDEDE),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            "Log out?",
                                            style: AppTextStyles(context)
                                                .primaryBold
                                                .copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                                ),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            "You’ll need to sign in again to access your account.",
                                            style: AppTextStyles(context)
                                                .smallRegular
                                                .copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                                ),
                                          ),
                                          SizedBox(height: 32),
                                          PrimaryButton(
                                            onTap: () async => context.pop(),
                                            title: "Cancel",
                                          ),
                                          SizedBox(height: 8),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: double.infinity,
                                              minHeight: 50,
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                await ref
                                                    .read(authServiceProvider)
                                                    .logout();
                                                CacheHelper.remove("waitlist");
                                                if (context.mounted) {
                                                  context.go("/boarding");
                                                }
                                              },
                                              child: Text(
                                                "Log Out",
                                                style: AppTextStyles(context)
                                                    .smallBold
                                                    .copyWith(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 4,
                                          width: 44,
                                          decoration: BoxDecoration(
                                            color: Color(0xffDEDEDE),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        "Delete your account?",
                                        style: AppTextStyles(context)
                                            .primaryBold
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        "This action is permanent. All your data and access will be removed.",
                                        style: AppTextStyles(context)
                                            .smallRegular
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                      SizedBox(height: 32),
                                      PrimaryButton(
                                        onTap: () async => context.pop(),
                                        title: "Cancel",
                                      ),
                                      SizedBox(height: 8),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: double.infinity,
                                          minHeight: 50,
                                        ),

                                        child: TextButton(
                                          onPressed: () async {
                                            await ref
                                                .read(authServiceProvider)
                                                .deleteUser();
                                            if (context.mounted) {
                                              context.go("/boarding");
                                            }
                                          },
                                          child: Text(
                                            "Delete Account",
                                            style: AppTextStyles(context)
                                                .smallBold
                                                .copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                      child: Text(
                        "Delete account",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key, required this.position, required this.code});

  final String position, code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 104),

        LottieBuilder.asset(
          'json/stars.json',
          package: "assets",
          width: 100,
          
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Congrats! You’re",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: AppTextStyles(context).accumulator * 32,
                ),
              ),
              Text(
                "${position}th on the waitlist.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: AppTextStyles(context).accumulator * 32,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39.5),
          child: Text.rich(
            TextSpan(
              text: "Your ticket to our ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,

                fontSize: AppTextStyles(context).accumulator * 14,
              ),
              children: [
                TextSpan(
                  text: "exclusive launch event ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(text: "unlocks when you’re in!"),
              ],
            ),

            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: AppTextStyles(context).accumulator * 14,
            ),
          ),
        ),
        SizedBox(height: 58),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 68.5),
          child: Text.rich(
            TextSpan(
              text:
                  "P.S. Skip the line? Refer 2 friends to move up 10 spots! with code ",
              children: [
                TextSpan(
                  text: "#$code ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                WidgetSpan(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 16,
                      constraints: BoxConstraints(),
                      alignment: Alignment.center,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: "#$code"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(child: Text("Code is copied")),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        "img/svg/copy.svg",
                        package: "assets",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: AppTextStyles(context).accumulator * 14,
            ),
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
