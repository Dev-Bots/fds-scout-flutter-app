part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class GetTeams extends TeamEvent {
  final int team1;
  final int team2;

  GetTeams(this.team1, this.team2);
  @override
  List<Object> get props => [team1, team2];
}
