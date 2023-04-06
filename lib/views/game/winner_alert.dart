

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uno_assistant/helpers/colors.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game/cubit/game_cubit.dart';

class WinnerAlert extends StatefulWidget {
  Player winner;

  WinnerAlert(    
    this.winner, {super.key}
  );

  @override
  _WinnerAlertState createState() => _WinnerAlertState();
}

class _WinnerAlertState extends State<WinnerAlert>{ 
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10)); 
    _controllerCenter.play();   
  }

  @override
  void dispose() {
    _controllerCenter.dispose();    
    super.dispose();
  } 

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state){
        return AlertDialog(          
          //title: const Text('New Player'),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[            
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 25.0, right: 25.0)),
                backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.flirtatious),
                foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)                
              ),
              child: const Text('Congrats!'),                  
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      true, // start again as soon as the animation is finished
                  colors: const [
                    ColorsPalette.algalFuel,
                    ColorsPalette.highBlue,
                    ColorsPalette.desire,
                    ColorsPalette.beniukonBronze,
                    ColorsPalette.gloomyPurple,
                    ColorsPalette.flirtatious,
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/trophy.png', height: cardHeight,)
                ]),
                 SizedBox(height: sizerHeight),
                Text('${widget.winner.name} wins!', style: encodeStyle(fontSize: accentFontSize))
              ],
            ),
          ),
        );
      }
    );
  }
}