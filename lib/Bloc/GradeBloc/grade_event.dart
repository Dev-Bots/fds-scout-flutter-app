part of 'grade_bloc.dart';

abstract class GradeEvent extends Equatable {
  const GradeEvent();

  @override
  List<Object> get props => [];
}

class GradePlayer extends GradeEvent {
  final grade;
  GradePlayer(this.grade);
  @override
  List<Object> get props => [];
}

class GradeFormPrepare extends GradeEvent {
  @override
  List<Object> get props => [];
}
