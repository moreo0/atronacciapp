// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBold extends StatelessWidget {
  final String _text;
  final TextAlign? alignment;
  final int? maxlines;
  final TextOverflow? textOverflow;
  final Color? color;
  final double? fontSize;

  const TextBold(
    this._text, {
    Key? key,
    this.maxlines,
    this.textOverflow,
    this.alignment = TextAlign.left,
    this.color = Colors.black,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Text(
      _text,
      textAlign: alignment,
      maxLines: maxlines,
      overflow: textOverflow,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class TextMedium extends StatelessWidget {
  final String _text;
  final TextAlign? alignment;
  final int? maxlines;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextMedium(
    this._text, {
    Key? key,
    this.alignment = TextAlign.left,
    this.color = Colors.black,
    this.maxlines,
    this.overflow,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Text(
      _text,
      maxLines: maxlines,
      overflow: overflow,
      textAlign: alignment,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
