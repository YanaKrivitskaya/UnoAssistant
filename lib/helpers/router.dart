import 'package:flutter/material.dart';
import 'package:uno_assistant/views/game_players_page.dart';

import '../views/home_page.dart';

const String homeRoute = '/home';
const String newGameRoute = '/newGame';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {      
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case newGameRoute:
        return MaterialPageRoute(builder: (_) => GamePlayersPage());
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