import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/ui/colors.dart';

SnackBar errorSnackBar(ApiException error, BuildContext context) {
  return SnackBar(
    backgroundColor: AppColors.signalFunError,
    dismissDirection: .none,

    content: Row(
      spacing: 6,
      children: [
        SvgPicture.asset("img/svg/error.svg", package: "assets"),
        Expanded(
          child: Text(
            error.message.toString(),
            style: TextStyle(color: AppColors.textError, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
