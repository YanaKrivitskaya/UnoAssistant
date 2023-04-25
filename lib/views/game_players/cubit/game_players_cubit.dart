import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/database/uno_repository.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/game_player.dart';
import 'package:uno_assistant/models/player.dart';

part 'game_players_state.dart';

class GamePlayersCubit extends Cubit<GamePlayersState> {
  GamePlayersCubit() : 
    _unoRepository = UnoRepository(),
    super(const GamePlayersState());

  final UnoRepository _unoRepository;

  Future<void> getAllPlayers() async{
    emit(state.copyWith(status: GamePlayersStatus.loading));

    try{
      var res = await _unoRepository.readData('players');

      List<Player> players =  res.isNotEmpty ? 
      res.map<Player>((map) => Player.fromMap(map)).toList() : [];      

      emit(state.copyWith(status: GamePlayersStatus.success, gamePlayers: players));
    }on Exception catch(ex){      
      emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: ex.toString()));
    }    
  }

  Future<void> addPlayer(Player newPlayer) async{
    emit(state.copyWith(status: GamePlayersStatus.loading));

    try{
      var res = await _unoRepository.insertData('players', newPlayer.toMap());
      
      if(res != null && res > 0 ) getAllPlayers();
    }on Exception catch(ex) {
      emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: ex.toString()));
    }    
  }

  void switchPlayer(Player player){    
    emit(state.copyWith(status: GamePlayersStatus.loading));
    var pl = player.copyWith(isSelected: !player.isSelected!);
    state.players![state.players!.indexWhere((p) => p.id == player.id)] = pl;
    emit(state.copyWith(status: GamePlayersStatus.success, gamePlayers: state.players));
  } 

  Future<int?> addNewGame(Game game, List<Player> players) async{
    emit(state.copyWith(status: GamePlayersStatus.loading));
    
    var selectedPlayers = players.where((p) => p.isSelected!);

    if(selectedPlayers.length > 1){
      if((game.scoreToWin ?? 0) > 0){
        try{
          var gameId = await _unoRepository.insertData('games', game.toMap());
          
          if(gameId != null && gameId > 0 ) {
            
            for (var player in selectedPlayers) {
              var gamePlayer = GamePlayer(gameId: gameId, playerId: player.id);
              await _unoRepository.insertData('game_players', gamePlayer.toMap());
            }
            return gameId;
          }
          emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: "Game not created"));
        }on Exception catch(ex) {
          emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: ex.toString()));
        }
      }
      else{
      emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: "Specify win score"));
    } 
    }else{
      emit(state.copyWith(status: GamePlayersStatus.failure, errorMessage: "Select at least two players"));
    }   
    
    return null;
  }
}
