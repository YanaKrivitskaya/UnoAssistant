import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:uno_assistant/helpers/widgets.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game_players/add_player_dialog.dart';
import 'package:uno_assistant/views/game_players/cubit/game_players_cubit.dart';

import '../../helpers/colors.dart';
import '../../helpers/router.dart';

class GamePlayersView extends StatefulWidget{
  const GamePlayersView({super.key});


  @override
  State<StatefulWidget> createState() {
    return _GamePlayersViewState();
  }
}

class _GamePlayersViewState extends State<GamePlayersView>{

  TextEditingController? _winScoreController;

  bool isSelectedYK = false;
  bool isSelectedSP = false;

  late List<Player> players;

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
      resizeToAvoidBottomInset: false,
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
      body: BlocListener<GamePlayersCubit, GamePlayersState>(
        listener: (context, state) {
          if(state.status == GamePlayersStatus.failure && state.exception != null){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          state.exception.toString(), style: encodeStyle(color: ColorsPalette.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                      const Icon(Icons.error, color: ColorsPalette.white,)],
                  ),
                // duration: const Duration(seconds: 5),
                  backgroundColor: ColorsPalette.desire,
                ),
              );
          }
        },
        child: BlocBuilder<GamePlayersCubit, GamePlayersState>(
          builder: (context, state){
            if(state.status == GamePlayersStatus.initial || state.status == GamePlayersStatus.loading){
              return loadingWidget(ColorsPalette.maxBlueGreen);
            }else{

              players = state.players ?? List.empty(growable: true);

              //_winScoreController!.text == '' ? _winScoreController!.text = state.winPoints.toString();

              return Container(
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
                        decoration: const InputDecoration(
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
                      _startGameButton(context, players),
                  ]),
                  const SizedBox(height: 25.0),
                  if (players.isNotEmpty) Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text("Players:", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
                  ]),
                  const Divider(color: ColorsPalette.blueGrey,),
                  SizedBox(
                    height: scrollViewHeightMd,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        if (players.isNotEmpty) ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: players.length,
                          itemBuilder: (context, position){
                            final player = players[position];
                            return InkWell(
                              child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Column(children: [
                                  Text(player.name, style: encodeStyle(fontSize: accentFontSize)),
                                ],),
                                Column(children: [
                                  _switchPlayer(context, player)
                                ],)
                              ]),
                              onTap: (){
                                context.read<GamePlayersCubit>().switchPlayer(player);
                              },
                            );
                          }
                        )
                      ],)
                    )
                  ),                
                ]),
              );
            }
          }
        ),
        ),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          showDialog(barrierDismissible: false, context: context,builder: (_) =>
              BlocProvider.value(
                value: context.read<GamePlayersCubit>(),
                child: AddPlayerDialog(),
              )
          );
        },
        tooltip: 'Add New Player',
        backgroundColor: ColorsPalette.maxBlueGreen,
        label: Text("New Player", style: encodeStyle(color: ColorsPalette.white),),
        icon: const Icon(Icons.add, color: ColorsPalette.white),
      ),
    );
  }

  Widget _startGameButton(BuildContext context, List<Player> players) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.desire),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {

      var scoreToWin = int.tryParse(_winScoreController?.text ?? '0') ?? 0;

      if(scoreToWin < 0){
        
      }else{
        var game = Game(scoreToWin: scoreToWin);
        context.read<GamePlayersCubit>().addNewGame(game, players).then((gameId){
          if(gameId != null) Navigator.pushNamed(context, currentGameRoute, arguments: gameId).then((value) {});
        });        
      }      
    },
    child: const Text("Start!")
  );

  Widget _switchPlayer(BuildContext context, Player player) {
    
    return Switch(
      value: player.isSelected ?? false,
      activeColor: ColorsPalette.flirtatious,
      onChanged: (bool value) {
        context.read<GamePlayersCubit>().switchPlayer(player);
      },
  );
  }

}