part of 'game_cubit.dart';

enum GameStatus { initial, loading, success, failure }

extension GameStatusX on GameStatus {
  bool get isInitial => this == GameStatus.initial;
  bool get isLoading => this == GameStatus.loading;
  bool get isSuccess => this == GameStatus.success;
  bool get isFailure => this == GameStatus.failure;
}

class GameState extends Equatable {
  final GameStatus status;
  final Game? currentGame;
  final List<Player>? players;
  final List<GameRound>? rounds;

  const GameState({
    this.status = GameStatus.initial,    
    Game? game,
    List<Player>? gamePlayers,
    List<GameRound>? gameRounds      
    }) : currentGame = game, players = gamePlayers, rounds = gameRounds;

  GameState copyWith({
    GameStatus? status,
    Game? game,    
    List<Player>? gamePlayers,
    List<GameRound>? gameRounds   
  }) {
    return GameState(
      status: status ?? this.status,
      game: game ?? currentGame,
      gamePlayers: gamePlayers ?? players,
      gameRounds: gameRounds ?? rounds
    );
  }  

  @override
  List<Object?> get props => [status, currentGame, players, rounds];
}

