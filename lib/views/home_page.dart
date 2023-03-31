import 'package:flutter/material.dart';

import '../helpers/colors.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [          
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/UNO_Logo.png', height: 150,)
          ]),
          const SizedBox(height: 50.0,),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _continueGameButton(context),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _newGameButton(context),
          ]),            
        ]));
  }


  Widget _newGameButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.maxBlueGreen),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      //Navigator.pushNamed(context, tripStartPlanningRoute).then((value) {} /*context.read<TripsBloc>().add(GetAllTrips())*/);
    },
    child: const Text("New Game")
  );

  Widget _continueGameButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.flirtatious),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      //Navigator.pushNamed(context, tripStartPlanningRoute).then((value) {} /*context.read<TripsBloc>().add(GetAllTrips())*/);
    },
    child: const Text("Continue")
  );
}