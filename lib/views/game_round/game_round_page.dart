import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/views/game_round/cubit/game_round_cubit.dart';
import 'package:uno_assistant/views/game_round/game_round_view.dart';

class GameRoundPage extends StatelessWidget {
  final int gameId;
  const GameRoundPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameRoundCubit()..getRoundInfo(gameId),
      child: const GameRoundView(),
    );
  }
}
