import 'package:flutter/material.dart';

class AppTheme {
  static final typography = TextTheme(
    displayLarge: TextStyle(fontFamily: "Sf-Pro", fontSize: 50),
  );

  static ThemeData theme() {
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black,),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
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
        constraints: BoxConstraints(minHeight: 55),
        suffixIconColor: Color.fromRGBO(164, 164, 164, 1),
        filled: true,

        prefixIconConstraints: BoxConstraints(minWidth: 23),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(164, 164, 164, 1),
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,

          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.all(20),
        fillColor: Color.fromRGBO(246, 246, 246, 0.7),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(Color(0XFF03392E)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xff01271f)),
        ),
      ),
      textTheme: typography,
    );
  }
}
