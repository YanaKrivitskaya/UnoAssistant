import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

TextStyle encodeStyle({Color? color, double? fontSize, FontWeight? weight, TextDecoration? decoration}) =>
  GoogleFonts.encodeSans(textStyle: TextStyle(
    color: color ?? Colors.black, 
    fontSize: fontSize, 
    fontWeight: weight ?? FontWeight.normal, 
    decoration: decoration));
