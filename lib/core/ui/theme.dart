import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
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
        border: InputBorder.none,
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
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}
