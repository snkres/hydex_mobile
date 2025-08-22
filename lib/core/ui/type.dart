import 'dart:io';

import 'package:flutter/material.dart';

class AppTextStyles {
  static String get fontFamily => Platform.isIOS ? "SF Pro" : "Roboto";

  // Display
  static final displayLargeLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.w300,
    height: 1.12,
    letterSpacing: 0.0,
  );

  static final displayLargeRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: 0.0,
  );

  static final displayLargeMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.w500,
    height: 1.12,
    letterSpacing: 0.0,
  );

  static final displayLargeBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: 0.0,
  );

  // Primary Body
  static final primaryRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  );

  static final primaryMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.0,
  );

  static final primaryBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.27,
    letterSpacing: 0.0,
  );

  // Secondary Body
  static final secondaryRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.25, // 20/16 = 1.25
    letterSpacing: 0.0,
  );

  static final secondaryMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0.0,
  );

  static final secondaryBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: 0.0,
  );

  // Small Text
  static final smallRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.43, // 20/14 = 1.43
    letterSpacing: 0.0,
  );

  static final smallMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.0,
  );

  static final smallBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.43,
    letterSpacing: 0.0,
  );

  static final smallSemibold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.0,
  );

  // Caption
  static final captionRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5, // 18/12 = 1.5
    letterSpacing: 0.0,
  );

  static final captionMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.0,
  );

  static final captionBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.0,
  );
}
