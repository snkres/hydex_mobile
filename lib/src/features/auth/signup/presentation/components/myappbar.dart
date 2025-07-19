import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset("img/logo.png", package: "assets", width: 30),
      centerTitle: true,
      leading: context.canPop()
          ? IconButton(
              onPressed: () => context.pop(),
              icon: SvgPicture.asset("img/svg/back.svg", package: "assets"),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class FakeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FakeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset("img/logo.png", package: "assets", width: 30),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("img/svg/back.svg", package: "assets"),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
