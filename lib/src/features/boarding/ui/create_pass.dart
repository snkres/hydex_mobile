import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

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
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (v) {},
                    decoration: InputDecoration(labelText: "Confirm Password"),
                  ),
                ],
              ),
            ),
            Spacer(),
            PrimaryButton(onTap: () => context.go("/tellus")),
          ],
        ),
      ),
    );
  }
}
