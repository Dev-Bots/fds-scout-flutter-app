part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GetAllGames extends GameEvent {
  @override
  List<Object> get props => [];
}