import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.onTap});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            onTap != null ? Colors.black : Color.fromRGBO(235, 235, 235, 1),
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        child: Text("Continue"),
      ),
    );
  }
}
