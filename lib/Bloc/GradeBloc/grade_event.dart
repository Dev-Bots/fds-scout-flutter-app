part of 'grade_bloc.dart';

abstract class GradeEvent extends Equatable {
  const GradeEvent();

  @override
  List<Object> get props => [];
}

class GradePlayer extends GradeEvent {
  final grade;
  final gradeId;
  GradePlayer(this.grade, this.gradeId);
  @override
  List<Object> get props => [];
}

class GradeFormPrepare extends GradeEvent {
  @override
  List<Object> get props => [];
}

class GetGrade extends GradeEvent {
  final int playerId;
  final int scoutId;
  final int eventId;
  const GetGrade(this.playerId, this.scoutId, this.eventId);
  @override
  List<Object> get props => [playerId, scoutId, eventId];
}
