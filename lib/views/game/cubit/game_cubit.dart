import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/game_round.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game/service/game_service.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : 
    _gameService = GameService(),
    super(const GameState());

  final GameService _gameService;

  Future<void> getCurrentGame(int gameId) async{
    emit(state.copyWith(status: GameStatus.loading));

    try{
      var game = await _gameService.getGameById(gameId);
      if(game != null) {
        var players = await _gameService.getGamePlayers(game.id!);
        var rounds = await _gameService.getGameRounds(game.id!);
        emit(state.copyWith(status: GameStatus.success, game: game, gamePlayers: players, gameRounds: rounds));
      } else {
        emit(state.copyWith(status: GameStatus.failure));
      }
      
    }on Exception catch (ex) {
      print(ex.toString());
      emit(state.copyWith(status: GameStatus.failure));
    }
    
  }
}
