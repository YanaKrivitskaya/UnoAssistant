import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/views/game_players/cubit/game_players_cubit.dart';
import 'package:uno_assistant/views/game_players/game_players_view.dart';

class GamePlayersPage extends StatelessWidget {
  const GamePlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GamePlayersCubit()..getAllPlayers(),
      child: const GamePlayersView(),
    );
  }
}
