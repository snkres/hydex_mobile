// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class NationalityTellUs extends StatefulWidget {
  const NationalityTellUs({super.key});

  @override
  State<NationalityTellUs> createState() => _NationalityTellUsState();
}

class _NationalityTellUsState extends State<NationalityTellUs> {
  String? codeErrorText;

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
            child: Consumer(
              builder: (context, ref, child) {
                final userType = ref.watch(userProvider.select((v) => v?.role));

                return CustomScrollView(
                  slivers: [
                    userType == Role.owner
                        ? BusinessOnlyWidget(ref: ref)
                        : TellusForOthers(ref: ref),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessOnlyWidget extends StatelessWidget {
  BusinessOnlyWidget({super.key, required this.ref});

  final businessController = TextEditingController();
  final linkController = TextEditingController();
  final categoryController = TextEditingController();
  final cityPriamryController = TextEditingController();
  String? type;
  final formKey = GlobalKey<FormState>();
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About your business",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Help us get to know you and boost your growth.",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: AppTextStyles(context).accumulator * 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            TextFormField(
                              autofocus: true,
                              controller: businessController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your business name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Business Name",
                              ),
                            ),

                            TextFormField(
                              controller: linkController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.url,
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              decoration: InputDecoration(
                                labelText: "Instagram or Website link",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter instagram or website link";
                                }
                                final uri = Uri.tryParse(value.trim());
                                if (uri == null ||
                                    !uri.hasScheme ||
                                    uri.host.isEmpty) {
                                  return "Must be a url";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: categoryController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your business category";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Category",
                              ),
                            ),
                            TextFormField(
                              controller: cityPriamryController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your city primary";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "City of primary activity",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(userProvider.notifier)
                              .create(
                                businessName: businessController.text,
                                instagram: linkController.text,
                              );
                          unawaited(
                            ref.read(authServiceProvider).createProfile(),
                          );
                          if (context.mounted) {
                            context.push("/describe");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TellusForOthers extends StatefulWidget {
  const TellusForOthers({super.key, required this.ref});
  final WidgetRef ref;
  @override
  State<TellusForOthers> createState() => _TellusForOthersState();
}

class _TellusForOthersState extends State<TellusForOthers> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController instagramController = TextEditingController();

  final nationalityController = TextEditingController();

  final TextEditingController facebookController = TextEditingController();

  final TextEditingController cityPriamryController = TextEditingController();

  final TextEditingController referralCodeController = TextEditingController();

  String? codeErrorText;
  String? typeErrorText;
  String? type;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tell us about yourself",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Help us get to know you and tailor your experience.",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    CustomChip(
                                      title: "Self Employed",
                                      isSelected: type == "Self Employed",
                                      onTap: () {
                                        setState(() {
                                          type = "Self Employed";
                                          typeErrorText = null;
                                        });
                                      },
                                    ),
                                    CustomChip(
                                      title: "Student",
                                      isSelected: type == "Student",
                                      onTap: () {
                                        setState(() {
                                          type = "Student";
                                          typeErrorText = null;
                                        });
                                      },
                                    ),
                                    CustomChip(
                                      title: "Employed",
                                      isSelected: type == "Employed",
                                      onTap: () {
                                        setState(() {
                                          type = "Employed";
                                          typeErrorText = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                if (typeErrorText != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      typeErrorText!,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: instagramController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.url,
                                    decoration: InputDecoration(
                                      labelText: "Instagram Link",
                                      hintText:
                                          "https://instagram.com/username",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter instagram link";
                                      }
                                      final trimmed = value.trim().replaceAll(
                                        '"',
                                        '',
                                      );
                                      final uri = Uri.tryParse(trimmed);
                                      if (uri == null ||
                                          !uri.hasScheme ||
                                          uri.host.isEmpty) {
                                        return "Must be a url";
                                      }
                                      if (!uri.host.contains('instagram.com') &&
                                          !uri.host.contains('instagr.am')) {
                                        return "Please enter a valid Instagram URL";
                                      }
                                      if (!uri.scheme.startsWith('http')) {
                                        return "URL must start with http:// or https://";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: facebookController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.url,
                                    decoration: InputDecoration(
                                      labelText: "Facebook Link (Optional)",
                                      hintText: "https://facebook.com/username",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }
                                      final trimmed = value.trim().replaceAll(
                                        '"',
                                        '',
                                      );
                                      final uri = Uri.tryParse(trimmed);
                                      if (uri == null ||
                                          !uri.hasScheme ||
                                          uri.host.isEmpty) {
                                        return "Please enter a valid URL";
                                      }
                                      if (!uri.host.contains('facebook.com') &&
                                          !uri.host.contains('fb.com') &&
                                          !uri.host.contains('fb.me')) {
                                        return "Please enter a valid Facebook URL";
                                      }
                                      if (!uri.scheme.startsWith('http')) {
                                        return "URL must start with http:// or https://";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: referralCodeController,
                              forceErrorText: codeErrorText,
                              validator: (code) {
                                if (code == null || code.isEmpty) {
                                  return null;
                                }

                                if (code.length < 8) {
                                  return "Code must be 8 characters";
                                }

                                return null;
                              },
                              onFieldSubmitted: (code) async {
                                if (code.isNotEmpty) {
                                  widget.ref
                                      .read(authServiceProvider)
                                      .verifyReferalCode(referralCode: code)
                                      .catchError((e) {
                                        setState(() {
                                          codeErrorText = e.message;
                                        });
                                        return '';
                                      });
                                }
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Invitation Code (Optional)",
                                hintText: "Enter 8-character code",
                              ),
                            ),
                            Text(
                              "if you don’t have an invite code just skip it.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(122, 127, 153, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      onTap: () async {
                        if (type == null || type!.isEmpty) {
                          setState(() {
                            typeErrorText = "Please select an employment type";
                          });
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          widget.ref
                              .read(userProvider.notifier)
                              .create(
                                socialStatus: type,
                                instagram: instagramController.text,
                                facebook: facebookController.text,

                                referralCode: referralCodeController.text,
                              );

                          final currentType = widget.ref.read(
                            userProvider.select((v) => v?.role),
                          );
                          if (context.mounted) {
                            switch (currentType) {
                              case Role.seeker:
                                context.push("/seeker");
                                break;
                              case Role.ambassador:
                                context.push("/seeker");
                                break;
                              case Role.owner:
                                context.push("/describe");
                                break;
                              default:
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
