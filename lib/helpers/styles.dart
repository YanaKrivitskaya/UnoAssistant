import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

final double fullWidth = 100.w;
final double fullheight = 100.h;

//ANCHOR Width
final double formWidth40 = 40.w;
final double formWidth60 = 60.w;
final double formWidth70 = 70.w;
final double viewWidth80 = 80.w;

//ANCHOR Font Size
final double headerFontSize = 25.sp; // View headers
final double smallHeaderFontSize = 20.sp; // View headers
final double accentFontSize = 16.sp; // Form headers
final double fontSize = 14.sp; // Form fields
final double fontSizesm = 12.sp;
final double fontSizexs = 10.sp;

//ANCHOR Sizer
final double sizerHeightsm = 1.h;
final double sizerWidthsm = 1.w;
final double sizerWidthMd = 2.w;
final double sizerHeight = 1.5.h;
final double sizerHeightlg = 2.h;

TextStyle encodeStyle({Color? color, double? fontSize, FontWeight? weight, TextDecoration? decoration}) =>
  GoogleFonts.encodeSans(textStyle: TextStyle(
    color: color ?? Colors.black, 
    fontSize: fontSize, 
    fontWeight: weight ?? FontWeight.normal, 
    decoration: decoration));
