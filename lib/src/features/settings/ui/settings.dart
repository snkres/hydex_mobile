import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/settings/domain/settings_domain.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

void showLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Color(0xffDEDEDE),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Log out?",
                      style: AppTextStyles(context).primaryBold.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "You'll need to sign in again to access your account.",
                      style: AppTextStyles(context).smallRegular.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
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
                          unawaited(ref.read(authServiceProvider).logout());
                          if (context.mounted) {
                            context.go("/boarding");
                          }
                        },
                        child: Text(
                          "Log Out",
                          style: AppTextStyles(context).smallBold.copyWith(
                            color: Theme.of(context).colorScheme.primary,
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
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(currentUserProvider);
            return Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppTextStyles(context).accumulator * 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push("/terms"),
                      child: Text(
                        "Privacy Policy",
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
                      onPressed: () => showLogoutBottomSheet(context),
                      style: ButtonStyle(
                        foregroundColor: .all(AppColors.textPrimary),
                        backgroundColor: .all(AppColors.surfaceInputField),
                      ),
                      child: Text("Log out"),
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
                        foregroundColor: .all(AppColors.textPrimary),
                        backgroundColor: .all(AppColors.surfaceInputField),
                      ),
                      child: Text("Delete account"),
                    ),
                  ],
                ),
                Text(
                  "App Version",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: .w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  ref
                      .watch(appVersionProvider)
                      .when(
                        data: (v) => v,
                        loading: () => '...',
                        error: (_, __) => 'Unknown',
                      ),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
