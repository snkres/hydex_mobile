import 'package:flutter/material.dart';

class AppColors {
  // Surface
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF131318);

  // Surface Dim
  static const Color surfaceDimLight = Color(0xFFfafafa);
  static const Color surfaceDimDark = Color(0xFF121212);

  // Surface Dimmer
  static const Color surfaceDimmerLight = Color(0xFFf5f5f5);
  static const Color surfaceDimmerDark = Color(0xFF1A1A1A);

  // Surface/Surf Container
  static const Color surfaceSurfContainerLight = Color(0xFFf7f7f7);
  static const Color surfaceSurfContainerDark = Color(0xFF202029);

  // Surface/Primary
  static const Color surfacePrimaryLight = Color(0xFF080808);
  static const Color surfacePrimaryDark = Color(0xFFffffff);

  // Surface/On Primary
  static const Color surfaceOnPrimaryLight = Color(0xFFffffff);
  static const Color surfaceOnPrimaryDark = Color(0xFF080808);

  // Surface/Surf Container High
  static const Color surfaceSurfContainerHighLight = Color(0xFFebebeb);
  static const Color surfaceSurfContainerHighDark = Color(0xFF2c2c2c);

  // OnSurface/On Surface
  static const Color onSurfaceLight = Color(0xFF1a1a1a);
  static const Color onSurfaceDark = Color(0xFFd4d4d4);

  // OnSurface/On Surface Var
  static const Color onSurfaceVarLight = Color(0xfff7a7f99);
  static const Color onSurfaceVarDark = Color(0xfffa0a0b0);

  // OnSurface/On Surface Var 2
  static const Color onSurfaceVar2Light = Color(0xFF6e6e6e);
  static const Color onSurfaceVar2Dark = Color(0xFF8a8a8a);

  // OnSurface/Outline
  static const Color onSurfaceOutlineLight = Color(0xFFe1e1e1);
  static const Color onSurfaceOutlineDark = Color(0xFF3a3a3a);

  // OnSurface/Error
  static const Color onSurfaceErrorLight = Color(0xFFc00b0b);
  static const Color onSurfaceErrorDark = Color(0xFFc00b0b);

  // On Surface - Disabled
  static const Color onSurfaceDisabledLight = Color(0xFFc4c4c4);
  static const Color onSurfaceDisabledDark = Color(0xFFa0a0a0);

  // Pop of Color
  static const Color popOfColorLight = Color(0xFF0a7aff);
  static const Color popOfColorDark = Color(0xFF0a7aff);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.surfacePrimaryLight,
  onPrimary: AppColors.surfaceOnPrimaryLight,
  primaryContainer: AppColors.surfaceSurfContainerHighLight,
  onPrimaryContainer: AppColors.onSurfaceLight,
  secondary: AppColors.popOfColorLight,
  onSecondary: AppColors.onSurfaceLight,
  secondaryContainer: AppColors.surfaceSurfContainerLight,
  onSecondaryContainer: AppColors.onSurfaceLight,
  tertiary: AppColors.surfaceDimLight,
  onTertiary: AppColors.onSurfaceLight,
  tertiaryContainer: AppColors.surfaceDimmerLight,
  onTertiaryContainer: AppColors.onSurfaceLight,
  error: AppColors.onSurfaceErrorLight,
  onError: AppColors.surfaceOnPrimaryLight,
  errorContainer: AppColors.onSurfaceErrorLight,
  onErrorContainer: AppColors.surfaceOnPrimaryLight,
  surface: AppColors.surfaceLight,
  onSurface: AppColors.onSurfaceLight,
  onSurfaceVariant: AppColors.onSurfaceVarLight,
  outline: AppColors.onSurfaceOutlineLight,
  shadow: Colors.black,
  inverseSurface: AppColors.surfaceDark,
  onInverseSurface: AppColors.onSurfaceDark,
  inversePrimary: AppColors.surfacePrimaryDark,
  surfaceTint: AppColors.popOfColorLight,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.surfacePrimaryDark,
  onPrimary: AppColors.surfaceOnPrimaryDark,
  primaryContainer: AppColors.surfaceSurfContainerHighDark,
  onPrimaryContainer: AppColors.onSurfaceDark,
  secondary: AppColors.popOfColorDark,
  onSecondary: AppColors.onSurfaceDark,
  secondaryContainer: AppColors.surfaceSurfContainerDark,
  onSecondaryContainer: AppColors.onSurfaceDark,
  tertiary: AppColors.surfaceDimDark,
  onTertiary: AppColors.onSurfaceDark,
  tertiaryContainer: AppColors.surfaceDimmerDark,
  onTertiaryContainer: AppColors.onSurfaceDark,
  error: AppColors.onSurfaceErrorDark,
  onError: AppColors.surfaceOnPrimaryDark,
  errorContainer: AppColors.onSurfaceErrorDark,
  onErrorContainer: AppColors.surfaceOnPrimaryDark,
  surface: AppColors.surfaceDark,
  onSurface: Color(0xFFD4D4D4),
  onSurfaceVariant: AppColors.onSurfaceVarDark,
  outline: AppColors.onSurfaceOutlineDark,
  shadow: Colors.black,
  inverseSurface: AppColors.surfaceLight,
  onInverseSurface: AppColors.onSurfaceLight,
  inversePrimary: AppColors.surfacePrimaryLight,
  surfaceTint: AppColors.popOfColorDark,
);
