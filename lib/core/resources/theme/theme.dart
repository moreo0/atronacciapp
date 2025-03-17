// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univs/core/resources/theme/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme(
          primary: const Color.fromARGB(255, 246, 246, 246),
          secondary: AppColors.primaryColor,
          surface: AppColors.colorWhite,
          background: AppColors.colorWhite,
          error: AppColors.colorRed,
          onPrimary: AppColors.colorWhite,
          onSecondary: AppColors.colorWhite,
          onSurface: Colors.black,
          onBackground: AppColors.colorWhite,
          onError: AppColors.colorWhite,
          brightness: Brightness.light,
        ),
      );

  // Part
  static TextStyle get heading5 => GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get heading6 => GoogleFonts.poppins(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  static TextStyle get subtitle => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      );

  static TextStyle get bodyText => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
}

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}
