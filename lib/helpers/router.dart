import 'package:flutter/material.dart';
import 'package:uno_assistant/views/game_players/game_players_page.dart';
import 'package:uno_assistant/views/game_round/game_round_page.dart';

import '../views/game/game_page.dart';
import '../views/home/home_page.dart';

const String homeRoute = '/home';
const String newGameRoute = '/newGame';
const String currentGameRoute = '/game';
const String roundPointsRoute = '/roundPoints';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {      
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case newGameRoute:
        return MaterialPageRoute(builder: (_) => const GamePlayersPage());
      case currentGameRoute:
        { 
          if (args is int) {
            return MaterialPageRoute(builder: (_) => GamePage(gameId: args));
          }
          return _errorRoute();
        }        
      case roundPointsRoute:
        if (args is int) {
          return MaterialPageRoute(builder: (_) => GameRoundPage(gameId: args));
        } 
        return _errorRoute();        
      default:
        return _errorRoute();
  }  
}

static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Oops'),
        ),
        body: const Center(
          child: Text('Something went wrong'),
        ),
      );
    });
  }

}