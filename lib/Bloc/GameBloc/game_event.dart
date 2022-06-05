part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GetAllGames extends GameEvent {
  int eventId;
  GetAllGames(this.eventId);
  @override
  List<Object> get props => [eventId];
}
