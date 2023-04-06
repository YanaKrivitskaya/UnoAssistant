import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/helpers/router.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:d_chart/d_chart.dart';
import 'package:uno_assistant/helpers/widgets.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/game_round.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game/cubit/game_cubit.dart';

import '../../helpers/colors.dart';

class GameView extends StatefulWidget{
  const GameView({super.key});


  @override
  State<StatefulWidget> createState() {
    return _GameViewState();
  }
}

class _GameViewState extends State<GameView>{
  late Game game;
  late List<Player> players;
  late List<GameRound> rounds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,    
        centerTitle: true,
        title: Text('Game', style:encodeStyle(fontSize: smallHeaderFontSize)),
        backgroundColor: ColorsPalette.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsPalette.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state){
          if(state.status == GameStatus.initial || state.status == GameStatus.loading){
            return loadingWidget(ColorsPalette.maxBlueGreen);
          }else if(state.currentGame != null){

            game = state.currentGame!;
            players = state.players!;
            rounds = state.rounds!;

            return Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Score to win: ${game.scoreToWin!}", style: encodeStyle(fontSize: accentFontSize)),
                ],),
                const Divider(color: ColorsPalette.blueGrey),         
                SizedBox(height: sizerHeight),

                SizedBox(
                  height: scrollViewHeightXS,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      if (players.isNotEmpty) ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: players.length,
                        itemBuilder: (context, position){
                          final player = players[position];
                          var score = rounds.where((r) => r.playerId == player.id).fold<int>(0, (sum, element) => sum + element.score!.toInt());
                          return Column(children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(player.name, style: encodeStyle(fontSize: accentFontSize)),
                              SizedBox(
                                height: chartBarHeight,
                                width: formWidth70,
                                child: DChartSingleBar(
                                    forgroundColor: gameColors[position],
                                    forgroundLabel: Text(score.toString(), style: encodeStyle(color: ColorsPalette.white, weight: FontWeight.bold)),
                                    forgroundLabelPadding: const EdgeInsets.only(right: 10.0),
                                    backgroundLabel: Text(game.scoreToWin!.toString(), style: encodeStyle(color: ColorsPalette.black, weight: FontWeight.bold)),
                                    backgroundLabelPadding: const EdgeInsets.only(right: 10.0),
                                    value: score.toDouble(),
                                    max: game.scoreToWin!.toDouble(),
                                  ),
                            )
                            ]),
                            SizedBox(height: sizerHeight),
                          ],) ;
                        }
                      )
                    ],)
                  )
                ),
                const Divider(color: ColorsPalette.blueGrey),    
                SizedBox(height: sizerHeight),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text("Round", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
                    Text("Winner", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
                    Text("Points", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
                  ],),
                const Divider(color: ColorsPalette.blueGrey),
                SizedBox(
                  height: scrollViewHeightMd,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      if (rounds.isNotEmpty) ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rounds.length,
                        itemBuilder: (context, position){
                          final round = rounds[position];
                          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text(round.roundNumber.toString(), style: encodeStyle(fontSize: accentFontSize)),
                            Text(players.firstWhere((p) => p.id == round.playerId).name, style: encodeStyle(fontSize: accentFontSize)),
                            Text(round.score.toString(), style: encodeStyle(fontSize: accentFontSize)),
                          ],) ;
                        }
                      )
                    ],)
                  )
                )
              ]),
            );
          } 
          return loadingWidget(ColorsPalette.maxBlueGreen);
        }
      ) ,
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){          
          Navigator.pushNamed(context, roundPointsRoute, arguments: game.id).then((value) {
            context.read<GameCubit>().getCurrentGame(game.id!);
          });
        },
        tooltip: 'End Round',
        backgroundColor: ColorsPalette.flirtatious,
        label: Text("End Round", style: encodeStyle(color: ColorsPalette.white),)        
      ),
    );
  }

}