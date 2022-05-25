part of 'team_bloc.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {}

// =================Get Single Event===============================

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final team1;
  final team2;

  const TeamLoaded({required this.team1, this.team2});
  @override
  List<Object> get props => [team1, team1];
}

class TeamFailed extends TeamState {
  final String error;

  const TeamFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TeamFailure { error: $error }';
}
