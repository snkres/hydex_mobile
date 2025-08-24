import 'dart:io';

import 'package:flutter/material.dart';

class AppTextStyles {
  final BuildContext context;

  AppTextStyles(this.context);
  String get fontFamily => Platform.isIOS ? "SF Pro" : "Roboto";
  double get accumulator => MediaQuery.widthOf(context) / 375;
  // Display
  TextStyle get displayLargeLight => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 50,
    fontWeight: FontWeight.w300,
    height: 1.12,
  );

  TextStyle get displayLargeRegular => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 50,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: 0.0,
  );

  TextStyle get displayLargeMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 50,
    fontWeight: FontWeight.w500,
    height: 1.12,
    letterSpacing: 0.0,
  );

  TextStyle get displayLargeBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 50,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: 0.0,
  );

  // Primary Body
  TextStyle get primaryRegular => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  );

  TextStyle get primaryMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.0,
  );

  TextStyle get primaryBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 22,
    fontWeight: FontWeight.w700,
    height: 1.27,
    letterSpacing: 0.0,
  );

  // Secondary Body
  TextStyle get secondaryRegular => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 14,
    fontWeight: FontWeight.w400,
    height: 1.25, // 20/16 => 1.25
    letterSpacing: 0.0,
  );

  TextStyle get secondaryMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0.0,
  );

  TextStyle get secondaryBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: 0.0,
  );

  // Small Text
  TextStyle get smallRegular => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 15,
    fontWeight: FontWeight.w400,
    height: 1.43, // 20/14 => 1.43
  );

  TextStyle get smallMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  TextStyle get smallBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 14,
    fontWeight: FontWeight.w700,
    height: 1.43,
  );

  TextStyle get smallSemibold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  // Caption
  TextStyle get captionRegular => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 12,
    fontWeight: FontWeight.w400,
    height: 1.5, // 18/12 => 1.5
  );

  TextStyle get captionMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  TextStyle get captionBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: accumulator * 12,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
}
