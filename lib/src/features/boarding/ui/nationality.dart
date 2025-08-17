import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/boarding/provider/usertype_provider.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            TextFormField(
                              autofocus: true,
                              controller: nationalityController,
                              textInputAction: TextInputAction.next,
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
                                  isSelected: type == "Self Employed",
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
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: "Instagram",
                                      hintText: "username",
                                      prefixText: "@",
                                      prefixStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9._]'),
                                      ),
                                    ],
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        if (value.length < 3) {
                                          return "Username must be at least 3 characters";
                                        }
                                        if (value.length > 30) {
                                          return "Username must be less than 30 characters";
                                        }
                                        if (!RegExp(
                                          r'^[a-zA-Z0-9._]+$',
                                        ).hasMatch(value)) {
                                          return "Only letters, numbers, dots and underscores allowed";
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: facebookController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: "Facebook",
                                      hintText: "username",
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9.]'),
                                      ),
                                    ],
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        if (value.length < 5) {
                                          return "Username must be at least 5 characters";
                                        }
                                        if (value.length > 50) {
                                          return "Username must be less than 50 characters";
                                        }
                                        if (!RegExp(
                                          r'^[a-zA-Z0-9.]+$',
                                        ).hasMatch(value)) {
                                          return "Only letters, numbers and dots allowed";
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Invitation Code",
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
                    child: Consumer(
                      builder: (context, ref, child) {
                        return PrimaryButton(
                          onTap: () async {
                            ref
                                .read(userNotifierProvider.notifier)
                                .create(
                                  nationality: nationalityController.text,
                                  socialStatus: type,
                                  instagram: "@${instagramController.text}",
                                  facebook: facebookController.text,
                                );
                            await ref
                                .read(authServiceProvider)
                                .register()
                                .catchError((error) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(
                                          child: Text("❎ ${error.message}"),
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
                          },
                        );
                      },
                    ),
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
