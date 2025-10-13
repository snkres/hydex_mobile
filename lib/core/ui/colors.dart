import 'package:flutter/material.dart';

class AppColors {
  // ------------------
  // 1. Background
  // ------------------
  static const Color backgroundBase = Color(0xFF131316); // before: Surface.Dark
  static const Color backgroundOverlay = Color(
    0xFF1F1D26,
  ); // before: Surface.SurfContainerDark

  // ------------------
  // 2. Surfaces
  // ------------------
  static const Color surfaceInputField = Color(
    0xFF1B1921,
  ); // before: Surface.Dim.Dark (updated)
  static const Color surfaceContainer = Color(
    0xFF1B1921,
  ); // before: Surface.Dimmer.Dark
  static const Color surfaceContainerInverse = Color(
    0xFFFFFFFF,
  ); // before: Surface.Light

  static const Color surfaceContainerLighter = Color(0xff2C2C2E);
  // ------------------
  // 3. Signals
  // ------------------
  // Brand
  static const Color signalBrandSolid = Color(0xFFA25BFF); // new (brand color)
  static const Color signalBrandTint = Color(0xFF1F1037); // new
  static const Color signalPopColor = Color(0xFF0A7AFF); // before: PopOfColor

  // Functional
  static const Color signalFunError = Color(
    0xFF301113,
  ); // before: OnSurface.Error
  static const Color signalFunSuccess = Color(0xFF172921); // new
  static const Color signalFunWarning = Color(0xFF302617); // new

  // ------------------
  // 4. Text
  // ------------------
  static const Color textPrimary = Color(0xFFFFFFFF); // before: OnSurface.Dark
  static const Color textSecondary = Color(
    0xFF89898F,
  ); // before: OnSurface.Var.Light
  static const Color textDisabled = Color(
    0xFF424246,
  ); // before: OnSurface.Disabled.Dark
  static const Color textBrand = Color(0xFFA25BFF); // new (brand color)
  static const Color textInverse = Color(0xFF1D1F1F); // new
  static const Color textError = Color(0xFFFF0003); // before: OnSurface.Error
  static const Color textWarning = Color(0xFFFFB020); // new
  static const Color textSuccess = Color(0xFF2ECC71); // new

  // ------------------
  // 5. Border
  // ------------------
  static const Color borderDefault = Color(
    0xFF3A3A3A,
  ); // before: OnSurface.Outline.Dark
  static const Color borderBrand = Color(0xFFA25BFF); // new (brand color)
  static const Color borderError = Color(0xFFFF0003); // before: OnSurface.Error
  static const Color borderSuccess = Color(0xFF2ECC71); // new
  static const Color borderWarning = Color(0xFFFFB020); // new

  // ------------------
  // 8. Buttons
  // ------------------
  static const Color buttonPrimary = Color(0xFFA25BFF); // before: PopOfColor
  static const Color buttonSecondary = Color(0xFF2A2A2E); // new
}

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Brand / Primary
  primary: AppColors.signalBrandSolid,
  onPrimary: AppColors.textPrimary,
  primaryContainer: AppColors.signalBrandTint,
  onPrimaryContainer: AppColors.textBrand,

  // Secondary / Accent
  secondary: AppColors.signalPopColor,
  onSecondary: AppColors.textInverse,
  secondaryContainer: AppColors.surfaceContainer,
  onSecondaryContainer: AppColors.textSecondary,

  // Tertiary (optional accent - you can keep brand tint or surface)
  tertiary: AppColors.surfaceInputField,
  onTertiary: AppColors.textPrimary,
  tertiaryContainer: AppColors.surfaceContainer,
  onTertiaryContainer: AppColors.textSecondary,

  // Error / Functional
  error: AppColors.textError,
  onError: AppColors.textInverse,
  errorContainer: AppColors.signalFunError,
  onErrorContainer: AppColors.textError,

  // Surfaces
  surface: AppColors.backgroundBase,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.borderDefault,
  shadow: Colors.black,

  // Inverse
  inverseSurface: AppColors.surfaceContainerInverse,
  onInverseSurface: AppColors.textInverse,
  inversePrimary: AppColors.signalBrandSolid,

  // Tint (used for elevation overlays)
  surfaceTint: AppColors.signalBrandSolid,
);
