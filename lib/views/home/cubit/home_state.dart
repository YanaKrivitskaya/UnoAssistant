part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  final HomeStatus status;
  final Game? currentGame;

  const HomeState({
    this.status = HomeStatus.initial,
    Game? game
    }) : currentGame = game;

  HomeState copyWith({
    HomeStatus? status,
    Game? game
  }) {
    return HomeState(
      status: status ?? this.status,
      game: game ?? currentGame
    );
  }

  @override
  List<Object?> get props => [status, currentGame];
}
