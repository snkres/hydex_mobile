import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/usertype_provider.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class NationalityTellUs extends StatefulWidget {
  const NationalityTellUs({super.key});

  @override
  State<NationalityTellUs> createState() => _NationalityTellUsState();
}

class _NationalityTellUsState extends State<NationalityTellUs> {
  String? type;
  final nationalityController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final referralCodeController = TextEditingController();
  String? codeErrorText;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Image.asset(
                    "img/gradient.png",
                    package: "assets",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Column(
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
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Help us get to know you and tailor your experience.",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 12,
                                      children: [
                                        TextFormField(
                                          autofocus: true,
                                          controller: nationalityController,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your nationality";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Nationality",
                                          ),
                                        ),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            CustomChip(
                                              title: "Self Employed",
                                              isSelected:
                                                  type == "Self Employed",
                                              onTap: () {
                                                setState(() {
                                                  type = "Self Employed";
                                                });
                                              },
                                            ),
                                            CustomChip(
                                              title: "Student",
                                              isSelected: type == "Student",
                                              onTap: () {
                                                setState(() {
                                                  type = "Student";
                                                });
                                              },
                                            ),
                                            CustomChip(
                                              title: "Employed",
                                              isSelected: type == "Employed",
                                              onTap: () {
                                                setState(() {
                                                  type = "Employed";
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 12,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: instagramController,
                                                textInputAction:
                                                    TextInputAction.next,
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
                                                  if (value.isNotEmpty) {
                                                    if (!Uri.tryParse(
                                                          value,
                                                        )!.hasAbsolutePath ==
                                                        true) {
                                                      return "Must be a url";
                                                    }

                                                    Uri? uri = Uri.tryParse(
                                                      value,
                                                    );
                                                    if (uri == null) {
                                                      return "Must be a url";
                                                    }

                                                    // Check if it's a valid Instagram URL
                                                    if (!uri.host.contains(
                                                          'instagram.com',
                                                        ) &&
                                                        !uri.host.contains(
                                                          'instagr.am',
                                                        )) {
                                                      return "Please enter a valid Instagram URL";
                                                    }

                                                    // Check if URL has proper scheme
                                                    if (!uri.hasScheme ||
                                                        (!uri.scheme.startsWith(
                                                              'http',
                                                            ) &&
                                                            !uri.scheme
                                                                .startsWith(
                                                                  'https',
                                                                ))) {
                                                      return "URL must start with http:// or https://";
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: facebookController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType: TextInputType.url,
                                                decoration: InputDecoration(
                                                  labelText: "Facebook Link",
                                                  hintText:
                                                      "https://facebook.com/username",
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter facebook link";
                                                  }
                                                  if (value.isNotEmpty) {
                                                    // Basic URL validation
                                                    if (!Uri.tryParse(
                                                          value,
                                                        )!.hasAbsolutePath ==
                                                        true) {
                                                      return "Please enter a valid URL";
                                                    }

                                                    Uri? uri = Uri.tryParse(
                                                      value,
                                                    );
                                                    if (uri == null) {
                                                      return "Please enter a valid URL";
                                                    }

                                                    // Check if it's a valid Facebook URL
                                                    if (!uri.host.contains(
                                                          'facebook.com',
                                                        ) &&
                                                        !uri.host.contains(
                                                          'fb.com',
                                                        ) &&
                                                        !uri.host.contains(
                                                          'fb.me',
                                                        )) {
                                                      return "Please enter a valid Facebook URL";
                                                    }

                                                    // Check if URL has proper scheme
                                                    if (!uri.hasScheme ||
                                                        (!uri.scheme.startsWith(
                                                              'http',
                                                            ) &&
                                                            !uri.scheme
                                                                .startsWith(
                                                                  'https',
                                                                ))) {
                                                      return "URL must start with http:// or https://";
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            return TextFormField(
                                              controller:
                                                  referralCodeController,
                                              forceErrorText: codeErrorText,
                                              validator: (code) {
                                                if (code == null ||
                                                    code.isEmpty) {
                                                  return null;
                                                }
                                                if (code.length < 8) {
                                                  return "Code must be 8 characters";
                                                }
                                                return null;
                                              },
                                              onFieldSubmitted: (code) async {
                                                if (code.isNotEmpty) {
                                                  ref
                                                      .read(authServiceProvider)
                                                      .verifyReferalCode(
                                                        referralCode: code,
                                                      )
                                                      .catchError((e) {
                                                        setState(() {
                                                          codeErrorText =
                                                              e.message;
                                                        });
                                                      });
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Invitation Code (Optional)",
                                                hintText:
                                                    "Enter 8-character code",
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          "if you don’t have an invite code just skip it.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                              122,
                                              127,
                                              153,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return PrimaryButton(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          ref
                                              .read(
                                                userNotifierProvider.notifier,
                                              )
                                              .create(
                                                nationality:
                                                    nationalityController.text,
                                                socialStatus: type,
                                                instagram:
                                                    instagramController.text,
                                                facebook:
                                                    facebookController.text,
                                                referralCode:
                                                    referralCodeController.text,
                                              );
                                          await ref
                                              .read(authServiceProvider)
                                              .register()
                                              .catchError((error) {
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Center(
                                                        child: Text(
                                                          "❎ ${error.message}",
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              });
                                          final currentType = ref.read(
                                            userTypeNotifierProvider,
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
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
