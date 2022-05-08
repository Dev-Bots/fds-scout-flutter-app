part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

// =====================Get All Events==========================================

class GamesLoading extends GameState {}

class GamesLoaded extends GameState {
  final games;

  const GamesLoaded({required this.games});
  @override
  List<Object> get props => [games];
}

class GamesFailed extends GameState {
  final String error;

  const GamesFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventsFailure { error: $error }';
}

// ==================Get Single Event===============================

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final game;

  const GameLoaded({required this.game});
  @override
  List<Object> get props => [game];
}

class GameFailed extends GameState {
  final String error;

  const GameFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventFailure { error: $error }';
}
