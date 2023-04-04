import 'dart:async';

import 'package:uno_assistant/database/uno_repository.dart';

import '../models/game.dart';

class GamesService{
  late UnoRepository _unoRepository;

  GamesService(){
    _unoRepository = UnoRepository();
  }

  //Save Game
  saveGame(Game game) async{
    return await _unoRepository.insertData('games', game.toMap());
  }
  //Read All Games
  readAllGames() async{
    return await _unoRepository.readData('games');
  }

  getCurrentGame() async{
    return await _unoRepository.getCurrentGame();
  }

  //Edit Game
  updateGame(Game game) async{
    return await _unoRepository.updateData('games', game.toMap());
  }

  deleteGame(gameId) async {
    return await _unoRepository.deleteDataById('games', gameId);
  }
}