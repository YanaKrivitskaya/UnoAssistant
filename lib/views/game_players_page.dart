import 'package:flutter/material.dart';
import 'package:uno_assistant/helpers/styles.dart';

import '../helpers/colors.dart';
import '../helpers/router.dart';

class GamePlayersPage extends StatefulWidget{
  const GamePlayersPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _GamePlayersPageState();
  }
}

class _GamePlayersPageState extends State<GamePlayersPage>{

  TextEditingController? _winScoreController;

  bool isSelectedYK = false;
  bool isSelectedSP = false;

  @override
  void initState() {
    super.initState();
    _winScoreController = TextEditingController(text: "300");    
  }

  @override
  void dispose() {
    _winScoreController!.dispose();   
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,    
        centerTitle: true,
        title: Text('New Game', style:encodeStyle(fontSize: smallHeaderFontSize)),
        backgroundColor: ColorsPalette.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsPalette.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [          
          Row(children: [
            Text("Score to win:", style: encodeStyle(fontSize: accentFontSize)),
            SizedBox(width: sizerWidthsm),
            SizedBox(width: formWidth40,
              child: TextFormField(     
                keyboardType: TextInputType.number,  
                textAlign: TextAlign.center,         
                style:  encodeStyle(fontSize: accentFontSize),
                decoration: InputDecoration(
                  border: InputBorder.none,                  
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                controller: _winScoreController
              ),
            ),
          ],),
          const SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _startGameButton(context),
          ]),
          const SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text("Players:", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
          ]),
          Divider(color: ColorsPalette.blueGrey,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(children: [
              Text("Yana", style: encodeStyle(fontSize: accentFontSize)),
            ],),
            Column(children: [
              _switchPlayer(context)
            ],)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(children: [
              Text("SP", style: encodeStyle(fontSize: accentFontSize)),
            ],),
            Column(children: [
              _switchPlayer(context)
            ],)
          ]),
          //const SizedBox(height: 25.0),
          //const Divider(color: ColorsPalette.blueGrey)
        ]),
      ),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){          
          
        },
        tooltip: 'Add New Player',
        backgroundColor: ColorsPalette.maxBlueGreen,
        label: Text("New Player", style: encodeStyle(color: ColorsPalette.white),),
        icon: const Icon(Icons.add, color: ColorsPalette.white),
      ),
    );
  }

  Widget _startGameButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.desire),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {

      var scoreToWin = int.parse(_winScoreController?.text ?? "");

      if(scoreToWin < 0){
        
      }
      Navigator.pushNamed(context, currentGameRoute).then((value) {} /*context.read<TripsBloc>().add(GetAllTrips())*/);
    },
    child: const Text("Start!")
  );

  Widget _switchPlayer(BuildContext context) {
    
    return Switch(
    value: isSelectedYK,
    activeColor: ColorsPalette.flirtatious,
    onChanged: (bool value) {
      // This is called when the user toggles the switch.
      setState(() {
        isSelectedYK = value;
      });
    },
  );
  }

}