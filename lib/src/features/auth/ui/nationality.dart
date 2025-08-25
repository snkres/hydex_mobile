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
  final businessController = TextEditingController();
  final linkController = TextEditingController();
  final facebookController = TextEditingController();
  final referralCodeController = TextEditingController();
  String? codeErrorText;
  final formKey = GlobalKey<FormState>();

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
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
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
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Help us get to know you and boost your growth.",
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
                                          decoration: InputDecoration(
                                            labelText:
                                                "Instagram or Website link",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter instagram or website link";
                                            }
                                            if (value.isNotEmpty) {
                                              if (!Uri.tryParse(
                                                    value,
                                                  )!.hasAbsolutePath ==
                                                  true) {
                                                return "Must be a url";
                                              }

                                              Uri? uri = Uri.tryParse(value);
                                              if (uri == null) {
                                                return "Must be a url";
                                              }

                                              // Check if URL has proper scheme
                                              if (!uri.hasScheme ||
                                                  (!uri.scheme.startsWith(
                                                        'http',
                                                      ) &&
                                                      !uri.scheme.startsWith(
                                                        'https',
                                                      ))) {
                                                return "URL must start with http:// or https://";
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: businessController,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your business name";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Category",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: businessController,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your business name";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText:
                                                "City of primary activity",
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
                                                    businessController.text,
                                                socialStatus: type,
                                                instagram: linkController.text,
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
                                          if (context.mounted) {
                                            context.push("/describe");
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
