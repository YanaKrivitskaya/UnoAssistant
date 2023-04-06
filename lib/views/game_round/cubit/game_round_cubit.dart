import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/database/game_service.dart';
import 'package:uno_assistant/models/card.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/game_round.dart';
import 'package:uno_assistant/models/player.dart';

part 'game_round_state.dart';

class GameRoundCubit extends Cubit<GameRoundState> {
  GameRoundCubit() : 
    _gameService = GameService(),
    super(const GameRoundState());

  final GameService _gameService;

  List<GameCard> cards = [
      GameCard(id: 0, value: 0, imagePath: 'assets/card_0.png', timesSelected: 0),
      GameCard(id: 1, value: 1, imagePath: 'assets/card_1.png', timesSelected: 0),
      GameCard(id: 2, value: 2, imagePath: 'assets/card_2.png', timesSelected: 0),
      GameCard(id: 3, value: 3, imagePath: 'assets/card_3.png', timesSelected: 0),
      GameCard(id: 4, value: 4, imagePath: 'assets/card_4.png', timesSelected: 0),
      GameCard(id: 5, value: 5, imagePath: 'assets/card_5.png', timesSelected: 0),
      GameCard(id: 6, value: 6, imagePath: 'assets/card_6.png', timesSelected: 0),
      GameCard(id: 7, value: 7, imagePath: 'assets/card_7.png', timesSelected: 0),
      GameCard(id: 8, value: 8, imagePath: 'assets/card_8.png', timesSelected: 0),
      GameCard(id: 9, value: 9, imagePath: 'assets/card_9.png', timesSelected: 0),
      GameCard(id: 10, value: 40, imagePath: 'assets/card_custom.png', timesSelected: 0),
      GameCard(id: 11, value: 40, imagePath: 'assets/card_reverse.png', timesSelected: 0),
      GameCard(id: 12, value: 20, imagePath: 'assets/card_skip.png', timesSelected: 0),
      GameCard(id: 13, value: 50, imagePath: 'assets/card_take_four.png', timesSelected: 0),
      GameCard(id: 14, value: 20, imagePath: 'assets/card_take_two.png', timesSelected: 0),
      GameCard(id: 15, value: 50, imagePath: 'assets/card_wild.png', timesSelected: 0)
    ];

  Future<void> getRoundInfo(int gameId) async{
    emit(state.copyWith(status: GameRoundStatus.loading));

    try{
      var players = await _gameService.getGamePlayers(gameId);
        
      emit(state.copyWith(status: GameRoundStatus.success, gamePlayers: players, gameCards: cards, gameId: gameId));
      
    }on Exception catch (ex) {
      print(ex.toString());
      emit(state.copyWith(status: GameRoundStatus.failure));
    }    
  }

  void cardSelected(GameCard card) {
    emit(state.copyWith(status: GameRoundStatus.loading));

    int totalScore = state.winPoints + card.value;
    card.timesSelected ++;
    state.cards![state.cards!.indexWhere((c) => c.id == card.id)] = card;

    emit(state.copyWith(status: GameRoundStatus.success, points: totalScore, gameCards: state.cards));
  }

  void setWinner(Player player) {
    emit(state.copyWith(status: GameRoundStatus.loading));
    
    emit(state.copyWith(status: GameRoundStatus.success, gameWinner: player));
  }

  void resetCards(int points) {
    emit(state.copyWith(status: GameRoundStatus.loading));

    for (var card in cards) { card.timesSelected = 0;}

    emit(state.copyWith(status: GameRoundStatus.success, gameCards: cards, points: points));
  }

  Future<void> submitRound(int points) async{
    emit(state.copyWith(status: GameRoundStatus.loading));

    try{      
      int roundNumbers = await _gameService.getRoundNumbers(state.gameId!);

      var roundNumber = roundNumbers + 1;

      GameRound round = GameRound(gameId: state.gameId, playerId: state.winner?.id ?? state.players!.first.id, score: points, roundNumber: roundNumber);
      
      await _gameService.submitRound(round);
              
      emit(state.copyWith(status: GameRoundStatus.created));
      
    }on Exception catch (ex) {
      print(ex.toString());
      emit(state.copyWith(status: GameRoundStatus.failure));
    }    
  }

}
