part of 'game_players_cubit.dart';

enum GamePlayersStatus { initial, loading, success, failure }

extension GamePlayersStatusX on GamePlayersStatus {
  bool get isInitial => this == GamePlayersStatus.initial;
  bool get isLoading => this == GamePlayersStatus.loading;
  bool get isSuccess => this == GamePlayersStatus.success;
  bool get isFailure => this == GamePlayersStatus.failure;
}

class GamePlayersState extends Equatable {
  final GamePlayersStatus status;
  final Game? currentGame;
  final List<Player>? players;
  final int? winPoints;

  const GamePlayersState({
    this.status = GamePlayersStatus.initial,
    this.winPoints = 300,
    Game? game,
    List<Player>? gamePlayers    
    }) : currentGame = game, players = gamePlayers;

  GamePlayersState copyWith({
    GamePlayersStatus? status,
    Game? game,
    int? points,
    List<Player>? gamePlayers  
  }) {
    return GamePlayersState(
      status: status ?? this.status,
      game: game ?? currentGame,
      gamePlayers: gamePlayers ?? players,
      winPoints: points ?? winPoints
    );
  }

  @override
  List<Object?> get props => [status, currentGame, players, winPoints];
}
