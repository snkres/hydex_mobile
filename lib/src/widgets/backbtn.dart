import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onClick});

  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(16),
      child: IconButton(
        iconSize: AppTextStyles(context).accumulator * 24,
        alignment: .center,
        padding: .zero,
        style: ButtonStyle(backgroundColor: .all(Color(0xff2C2C2E))),
        onPressed:
            onClick ??
            () {
              if (context.canPop()) {
                context.pop();
              }
            },
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        icon: SvgPicture.asset(
          "img/svg/back.svg",
          package: "assets",
          colorFilter: .mode(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            .srcIn,
          ),
        ),
      ),
    );
  }
}
