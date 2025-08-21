import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydex/core/ui/colors.dart';

class AppTheme {
  static final typography = TextTheme(
    displayLarge: TextStyle(
      fontFamily: Platform.isIOS ? "Sf-Pro" : "",
      fontSize: 50,
    ),
  );

  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: lightColorScheme,
      snackBarTheme: SnackBarThemeData(
        width: 400,
        insetPadding: EdgeInsets.all(100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(99),
        ),
        backgroundColor: lightColorScheme.secondaryContainer,
        contentTextStyle: TextStyle(
          color: lightColorScheme.onSecondaryContainer,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Color.fromRGBO(164, 164, 164, 1),
        filled: true,

        prefixIconConstraints: BoxConstraints(minWidth: 23),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(164, 164, 164, 1),
        ),

        border: UnderlineInputBorder(
          borderSide: BorderSide.none,

          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.all(20),
        fillColor: Color.fromRGBO(246, 246, 246, 0.7),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xff01271f)),
        ),
      ),

      textTheme: typography,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(darkColorScheme.primary),
          foregroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Color.fromRGBO(164, 164, 164, 1),
        filled: true,

        prefixIconConstraints: BoxConstraints(minWidth: 23),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(164, 164, 164, 1),
        ),

        border: UnderlineInputBorder(
          borderSide: BorderSide.none,

          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.all(20),
        fillColor: darkColorScheme.secondaryContainer,
      ),

      textTheme: typography,
    );
  }
}
