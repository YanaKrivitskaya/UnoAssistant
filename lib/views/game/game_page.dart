import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/views/game/cubit/game_cubit.dart';
import 'package:uno_assistant/views/game/game_view.dart';

class GamePage extends StatelessWidget {
  final int gameId;
  const GamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..getCurrentGame(gameId),
      child: const GameView(),
    );
  }
}