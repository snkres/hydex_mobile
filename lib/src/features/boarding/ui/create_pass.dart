import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  static final formKey = GlobalKey<FormState>();
  static final passwordController = TextEditingController();
  static final passwordConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create your password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              "This is your key to the good life. Make it strong.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Form(
              key: formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    controller: passwordController,
                    autofocus: true,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      final passwordRegex = RegExp(
                        r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
                      );
                      if (!passwordRegex.hasMatch(value)) {
                        return "Password must be at least 8 characters, contain letters and numbers";
                      }

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  TextFormField(
                    controller: passwordConfirmController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (v) {},
                    decoration: InputDecoration(labelText: "Confirm Password"),
                  ),
                ],
              ),
            ),
            Spacer(),
            Consumer(
              builder: (context, ref, child) {
                return PrimaryButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(userNotifierProvider.notifier)
                          .create(password: passwordConfirmController.text);
                      context.go("/tellus");
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
