part of 'game_round_cubit.dart';

enum GameRoundStatus { initial, loading, success, failure, created }

extension GameRoundStatusX on GameRoundStatus {
  bool get isInitial => this == GameRoundStatus.initial;
  bool get isLoading => this == GameRoundStatus.loading;
  bool get isSuccess => this == GameRoundStatus.success;
  bool get isCreated => this == GameRoundStatus.created;
  bool get isFailure => this == GameRoundStatus.failure;
}

 class GameRoundState extends Equatable {
  final GameRoundStatus status;
  final int? gameId;
  final List<Player>? players;
  final List<GameCard>? cards;
  final Player? winner;
  final int winPoints;

  const GameRoundState({
    this.status = GameRoundStatus.initial,
    this.winPoints = 0,
    this.gameId,
    List<Player>? gamePlayers,
    List<GameCard>? gameCards,
    Player? gameWinner    
    }) : winner = gameWinner,
         cards = gameCards,
         players = gamePlayers;

  GameRoundState copyWith({
    GameRoundStatus? status,
    int? gameId,
    int? points,
    List<Player>? gamePlayers,
    List<GameCard>? gameCards,
    Player? gameWinner   
  }) {
    return GameRoundState(
      status: status ?? this.status,
      gameId: gameId ?? this.gameId,
      gamePlayers: gamePlayers ?? players,
      winPoints: points ?? winPoints,
      gameCards: gameCards ?? cards,  
      gameWinner: gameWinner ?? winner
    );
  }

  @override
  List<Object?> get props => [status, gameId, players, winPoints, winner, cards];
}

