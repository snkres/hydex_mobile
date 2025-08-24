import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool dontShow = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String? _validatePasswordConfirmation(String? value) {
    if (value!.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "Password must be at least 8 characters, contain letters and numbers";
    }
    return null;
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create your password",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "This is your key to the good life. Make it strong.",
                          style: TextStyle(
                            fontSize:
                                AppTextStyles(context).accumulator *
                                AppTextStyles(context).accumulator *
                                14,
                          ),
                        ),
                        SizedBox(height: 16),
                        Form(
                          key: formKey,
                          child: Column(
                            spacing: 10,
                            children: [
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,

                                validator: _validatePassword,

                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                ),
                              ),
                              TextFormField(
                                controller: passwordConfirmController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,

                                obscureText: true,
                                onChanged: (value) {
                                  bool hasError =
                                      _validatePasswordConfirmation(value) !=
                                      null;

                                  setState(() {
                                    dontShow = hasError;
                                  });
                                },
                                validator: _validatePasswordConfirmation,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {},
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Consumer(
                          builder: (context, ref, child) {
                            return PrimaryButton(
                              onTap: dontShow
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        ref
                                            .read(userNotifierProvider.notifier)
                                            .create(
                                              password:
                                                  passwordConfirmController
                                                      .text,
                                            );
                                        context.go("/tellus");
                                      }
                                    },
                            );
                          },
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
    );
  }
}
