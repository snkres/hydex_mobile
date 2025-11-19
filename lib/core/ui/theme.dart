import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydex/core/ui/colors.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      snackBarTheme: SnackBarThemeData(
        width: 250,
        insetPadding: EdgeInsets.all(100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(99),
        ),
        backgroundColor: darkColorScheme.secondaryContainer,
        contentTextStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
        behavior: SnackBarBehavior.floating,
      ),
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: darkColorScheme.onSurface,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color.fromRGBO(23, 23, 23, 0.80),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.borderDefault),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(AppColors.buttonSecondary),
          foregroundColor: WidgetStatePropertyAll(AppColors.textPrimary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Color.fromRGBO(164, 164, 164, 1),

        filled: true,
        prefixIconConstraints: BoxConstraints(minWidth: 23),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: .fromRGBO(164, 164, 164, 1),
        ),

        border: UnderlineInputBorder(
          borderSide: BorderSide.none,

          borderRadius: BorderRadius.circular(16),
        ),
        fillColor: AppColors.surfaceContainer,
      ),
    );
  }
}
