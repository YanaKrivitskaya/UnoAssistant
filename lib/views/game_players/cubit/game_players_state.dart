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
  final String? exception;

  const GamePlayersState({
    this.status = GamePlayersStatus.initial,
    this.winPoints = 300,
    Game? game,
    List<Player>? gamePlayers,
    String? errorMessage
    }) : currentGame = game, players = gamePlayers, exception = errorMessage;

  GamePlayersState copyWith({
    GamePlayersStatus? status,
    Game? game,
    int? points,
    String? errorMessage,
    List<Player>? gamePlayers  
  }) {
    return GamePlayersState(
      status: status ?? this.status,
      game: game ?? currentGame,
      gamePlayers: gamePlayers ?? players,
      errorMessage: errorMessage ?? exception,
      winPoints: points ?? winPoints
    );
  }

  @override
  List<Object?> get props => [status, currentGame, players, winPoints, exception];
}
