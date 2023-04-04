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
      print(ex.toString());
      emit(state.copyWith(status: GamePlayersStatus.failure));
    }    
  }

  Future<void> addPlayer(Player newPlayer) async{
    emit(state.copyWith(status: GamePlayersStatus.loading));

    try{
      var res = await _unoRepository.insertData('players', newPlayer.toMap());
      
      if(res != null && res > 0 ) getAllPlayers();
    }on Exception catch(ex) {
      print(ex.toString());
      emit(state.copyWith(status: GamePlayersStatus.failure));
    }    
  }

  void switchPlayer(Player player){    
    emit(state.copyWith(status: GamePlayersStatus.loading));
    var pl = player.copyWith(isSelected: !player.isSelected!);
    state.players![state.players!.indexWhere((p) => p.id == player.id)] = pl;
    emit(state.copyWith(status: GamePlayersStatus.success, gamePlayers: state.players));
  } 

  Future<void> addNewGame(Game game, List<Player> players) async{
    emit(state.copyWith(status: GamePlayersStatus.loading));

    try{
      var gameId = await _unoRepository.insertData('games', game.toMap());
      
      if(gameId != null && gameId > 0 ) {
        var selectedPlayers = players.where((p) => p.isSelected!);
        for (var player in selectedPlayers) {
          var gamePlayer = GamePlayer(gameId: gameId, playerId: player.id);
          await _unoRepository.insertData('game_players', gamePlayer.toMap());
        }
      }
    }on Exception catch(ex) {
      print(ex.toString());
      emit(state.copyWith(status: GamePlayersStatus.failure));
    }    
  }
}
