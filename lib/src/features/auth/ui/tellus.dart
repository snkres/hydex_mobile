import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/usertype_provider.dart';
import 'package:hydex/src/features/auth/ui/verify_email.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';

class Tellus extends StatefulWidget {
  const Tellus({super.key});

  @override
  State<Tellus> createState() => _TellusState();
}

class _TellusState extends State<Tellus> {
  String? gender;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();
  final referralCodeController = TextEditingController();
  final nationalityController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  String? requiredBirth;
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
                                    style: AppTextStyles(context).smallRegular
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                  SizedBox(height: 16),
                                  Form(
                                    key: formkey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: nameController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your name";
                                            }
                                            return null;
                                          },
                                          autofocus: true,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            labelText: "Full Name",
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            return Visibility(
                                              visible: !ref.watch(
                                                isEmailVerifiedProvider,
                                              ),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: emailController,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please enter your email";
                                                      }
                                                      final emailRegex = RegExp(
                                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                                      );
                                                      if (!emailRegex.hasMatch(
                                                        value,
                                                      )) {
                                                        return "Please enter a valid email";
                                                      }
                                                      return null;
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                      labelText: "Email",
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            );
                                          },
                                        ),

                                        TextFormField(
                                          controller: birthController,
                                          readOnly: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter date of birth";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  children: [
                                                    SizedBox(height: 20),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 40,
                                                          ),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: TextButton(
                                                          onPressed: () =>
                                                              context.pop(),
                                                          child: Text(
                                                            "Done",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: CupertinoTheme(
                                                        data: CupertinoThemeData(
                                                          brightness:
                                                              Theme.brightnessOf(
                                                                context,
                                                              ),
                                                        ),
                                                        child: CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          initialDateTime:
                                                              DateTime.now(),

                                                          minimumDate:
                                                              DateTime.now()
                                                                  .subtract(
                                                                    Duration(
                                                                      days:
                                                                          10000,
                                                                    ),
                                                                  ),
                                                          onDateTimeChanged: (date) {
                                                            final DateFormat
                                                            formatter =
                                                                DateFormat(
                                                                  'd/M/yyyy',
                                                                );
                                                            final DateFormat
                                                            requiredFormatter =
                                                                DateFormat(
                                                                  'yyyy/MM/dd',
                                                                );

                                                            String formatted =
                                                                formatter
                                                                    .format(
                                                                      date,
                                                                    );
                                                            String
                                                            requiredFormat =
                                                                requiredFormatter
                                                                    .format(
                                                                      date,
                                                                    );
                                                            setState(() {
                                                              birthController
                                                                      .text =
                                                                  formatted;
                                                              requiredBirth =
                                                                  requiredFormat;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText: "Date of Birth",
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        TextFormField(
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      CustomChip(
                                        title: "Male",
                                        isSelected: gender == "Male",
                                        onTap: () {
                                          setState(() {
                                            gender = "Male";
                                          });
                                        },
                                      ),
                                      CustomChip(
                                        title: "Female",
                                        isSelected: gender == "Female",
                                        onTap: () {
                                          setState(() {
                                            gender = "Female";
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),

                                  Consumer(
                                    builder: (context, ref, child) {
                                      final userType = ref.watch(
                                        userTypeNotifierProvider,
                                      );
                                      return Visibility(
                                        visible: userType == Role.owner,
                                        child: Column(
                                          spacing: 4,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFormField(
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
                                                label: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Invitation Code"),
                                                    Text("(Optional)"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "If you don’t have an invite code just skip it.",
                                              style: AppTextStyles(context)
                                                  .captionRegular
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return PrimaryButton(
                                      onTap: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (gender == null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Center(
                                                  child: Text(
                                                    "Please choose your gender",
                                                  ),
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          ref
                                              .read(
                                                userNotifierProvider.notifier,
                                              )
                                              .create(
                                                nationality:
                                                    nationalityController.text,
                                                gender: gender,
                                                dateOfBirth: requiredBirth,
                                                referralCode:
                                                    referralCodeController.text,
                                                email: emailController.text,
                                                fullName: nameController.text,
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
                                            context.push("/nationality");
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

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: AppTextStyles(context).accumulator * 14,
            height: 1.7,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
