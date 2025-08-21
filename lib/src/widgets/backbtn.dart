import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: IconButton(
        iconSize: 24,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        icon: Icon(Icons.arrow_back_sharp),
      ),
    );
  }
}
