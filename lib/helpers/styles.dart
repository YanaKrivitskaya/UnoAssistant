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
final double viewWidth90 = 90.w;

// ANCHOR Height 
final double chartBarHeight = 3.h; 
final double cardHeight = 10.h; 
final double minCardHeight = 7.h;
final double maxCardHeight = 25.h;
final double scrollViewHeight = 60.h;
final double scrollViewHeightSm = 30.h;
final double scrollViewHeightXS = 15.h;
final double scrollViewHeightMd = 35.h;

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
final double sizerHeightlg = 5.h;

TextStyle encodeStyle({Color? color, double? fontSize, FontWeight? weight, TextDecoration? decoration}) =>
  GoogleFonts.encodeSans(textStyle: TextStyle(
    color: color ?? Colors.black, 
    fontSize: fontSize, 
    fontWeight: weight ?? FontWeight.normal, 
    decoration: decoration));
