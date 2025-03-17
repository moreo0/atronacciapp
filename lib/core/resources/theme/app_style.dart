import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univs/core/resources/theme/colors.dart';

class AppStyle {
  static TextStyle headline1({Color? color}) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.black414,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle headline2({Color? color}) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.black414,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle headline3({Color? color}) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.black414,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle headline4({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.black414,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle title1({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 40,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle title2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 34,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle title3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 30,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle title4({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 28,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle subtitle1({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle subtitle2({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 20,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle subtitle3({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 18,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle subtitle4({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle body1({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle body2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 13,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle body3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 11,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle small({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 9,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle verySmall({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 8,
        color: color,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static TextStyle link({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 18,
        color: color ?? Colors.blue,
      );

  // Font Weight
  static FontWeight superBold = FontWeight.w900;
  static FontWeight bold = FontWeight.bold;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight mediumBold = FontWeight.w500;
  static FontWeight normalBold = FontWeight.normal;
  static FontWeight regularBold = FontWeight.w400;
}
