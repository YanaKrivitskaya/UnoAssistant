import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:uno_assistant/helpers/widgets.dart';
import 'package:uno_assistant/models/card.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game_round/cubit/game_round_cubit.dart';
import 'package:badges/badges.dart' as badges;

import '../../helpers/colors.dart';
import '../../helpers/router.dart';

class GameRoundView extends StatefulWidget{
  const GameRoundView({super.key});


  @override
  State<StatefulWidget> createState() {
    return _GameRoundViewState();
  }
}


class _GameRoundViewState extends State<GameRoundView>{
  TextEditingController? _roundPointsController;  

  @override
  void initState() {
    super.initState();
    _roundPointsController = TextEditingController(text: "0");    
  }

  @override
  void dispose() {
    _roundPointsController!.dispose();   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,    
        centerTitle: true,
        title: Text('Round points', style:encodeStyle(fontSize: smallHeaderFontSize)),
        backgroundColor: ColorsPalette.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsPalette.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),        
      ),
      body: BlocListener<GameRoundCubit, GameRoundState>(
        listener: (context, state) {
          if(state.status == GameRoundStatus.created){
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              backgroundColor: ColorsPalette.highBlue,
              content: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: const [ 
                    Icon(Icons.check, color: ColorsPalette.white,)
                ],
                ),
              ));
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context, 1);
              });
          }
        },
        child: BlocBuilder<GameRoundCubit, GameRoundState>(
          builder: (context, state){
            if(state.status == GameRoundStatus.initial || state.status == GameRoundStatus.loading){
              return loadingWidget(ColorsPalette.maxBlueGreen);
            }          
            else{

              _roundPointsController!.text = state.winPoints.toString();

              return Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Winner:', style: encodeStyle(fontSize: accentFontSize)),                   
                    _winnerSelector(state)
                  ],),
                  SizedBox(height: sizerHeight),            
                  Row(children: [
                    Text("Enter points:", style: encodeStyle(fontSize: accentFontSize)),
                    SizedBox(width: sizerWidthsm),
                    SizedBox(width: formWidth40,
                      child: TextFormField(     
                        keyboardType: TextInputType.number,  
                        textAlign: TextAlign.center,         
                        style:  encodeStyle(fontSize: accentFontSize),
                        decoration: const InputDecoration(
                          border: InputBorder.none,                  
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        onEditingComplete:() {
                          context.read<GameRoundCubit>().resetCards(int.parse(_roundPointsController!.text));
                          FocusScope.of(context).unfocus();
                        },
                        controller: _roundPointsController
                      ),
                    ),
                  ],),
                  SizedBox(height: sizerHeight),
                  const Divider(color: ColorsPalette.blueGrey),         
                  SizedBox(height: sizerHeight),
                  Text("...or select cards:", style: encodeStyle(fontSize: accentFontSize)),
                  SizedBox(height: sizerHeight),
                  SizedBox(                  
                    width: viewWidth80,
                    child: Wrap(
                      spacing: 5.0,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: List<Widget>.generate(state.cards!.length, (int index){
                          return badges.Badge(
                            position: badges.BadgePosition.topEnd(top: -5, end:  -3),
                            badgeAnimation: const badges.BadgeAnimation.slide(
                              toAnimate: false,                            
                              curve: Curves.easeIn,
                            ),
                            showBadge: state.cards![index].timesSelected > 0,
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: ColorsPalette.algalFuel,
                            ),
                            badgeContent: Text(
                              state.cards![index].timesSelected.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: InkWell(
                              child: Image.asset(state.cards![index].imagePath, height: cardHeight),
                              onTap: (){
                                context.read<GameRoundCubit>().cardSelected(state.cards![index]);
                              },
                            ),
                          );
                        })
                    )
                  ),
                  SizedBox(height: sizerHeightlg),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      _resetPointsButton(context), 
                      _submitPointsButton(context),
                  ]),
                ],)
              );
            }
          })
        )  ,
    );
  }

  Widget _submitPointsButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.maxBlueGreen),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      var points = int.parse(_roundPointsController!.text);
      context.read<GameRoundCubit>().submitRound(points).then((value){
        /*Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context, 1);
        });*/
      });
    },
    child: const Text("Submit")
  );

  Widget _resetPointsButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.desire),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      context.read<GameRoundCubit>().resetCards(0);
    },
    child: const Text("Reset")
  );

  Widget _winnerSelector(GameRoundState state) =>
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: -10)
        ),
        value: state.winner?.name ?? state.players!.first.name,
        isExpanded: true,        
        items:
          state.players!.map((Player player) {
          return DropdownMenuItem<String>(
              value: player.name,
              child: Row(
                children: [                  
                  Text( player.name),
                ],
              ));
        }).toList(),
        isDense: true,
        onChanged: (String? value) {
          Player winner = state.players!.firstWhere((p) => p.name == value);
          context.read<GameRoundCubit>().setWinner(winner);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value == null ? 'Required field' : null;
        },
      );
}