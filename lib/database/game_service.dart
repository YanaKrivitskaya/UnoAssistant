
import 'package:sqflite/sqflite.dart';
import 'package:uno_assistant/database/uno_repository.dart';
import 'package:uno_assistant/models/game.dart';
import 'package:uno_assistant/models/game_round.dart';
import 'package:uno_assistant/models/player.dart';

class GameService{
  final UnoRepository _unoRepository;

  GameService(): _unoRepository = UnoRepository();

  Future<Game?> getGameById(int id) async{
    var res = await _unoRepository.readDataById('games', id);
    return res!.isNotEmpty ? Game.fromMap(res.first) : null ;
  }

  Future<List<Player>?> getGamePlayers(int gameId) async{
    var query = "select p.* from game_players gp join players p on gp.player_id = p.id where gp.game_id = $gameId";
    var res = await _unoRepository.readDataRaw(query);
    if(res.isNotEmpty){
      List<Player> players = res.map<Player>((map) => Player.fromMap(map)).toList();
      return players;
    }
    return [];
  } 

  Future<List<GameRound>?> getGameRounds(int gameId) async{
    var query = "select gr.* from rounds gr join games g on g.id = gr.game_id where g.id = $gameId";
    var res = await _unoRepository.readDataRaw(query);
    if(res.isNotEmpty){
      List<GameRound> rounds = res.map<GameRound>((map) => GameRound.fromMap(map)).toList();
      return rounds;
    }
    return [];
  } 

  Future<int> getRoundNumbers(int gameId) async{
    var query = "select COALESCE(max(gr.round_number), 0) from rounds gr join games g on g.id = gr.game_id where g.id = $gameId";
    var res = await _unoRepository.readDataRaw(query);
    return res!.isNotEmpty ?  Sqflite.firstIntValue(res) ?? 0 : 0;
  } 

  Future<void> submitRound(GameRound round) async{    
    await _unoRepository.insertData('rounds', round.toMap());    
  }
  
}