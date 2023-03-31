import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:uno_assistant/views/home_page.dart';

import 'helpers/colors.dart';

void main() {
  runApp(const UnoApp());
}

class UnoApp extends StatelessWidget {
  const UnoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uno Assistant',
      theme: ThemeData(
        primaryColor: ColorsPalette.desire,
        scaffoldBackgroundColor: ColorsPalette.white,              
        textTheme: GoogleFonts.encodeSansTextTheme(Theme.of(context).textTheme), 
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorsPalette.maxBlueGreen,
          outline: ColorsPalette.flirtatious
        ),              
      ),
      home: HomePage(),
    );
  }
}

Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset('assets/UNO_Logo.png', height: 150,),
      Text("Uno Assistant", style: encodeStyle(color: Colors.green, fontSize: 40.0)),
    ],
  );
