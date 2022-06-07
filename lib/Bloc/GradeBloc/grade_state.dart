part of 'grade_bloc.dart';

abstract class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}

class GradeLoading extends GradeState {}

class GradeUploaded extends GradeState {
  final grade;

  const GradeUploaded({required this.grade});
  @override
  List<Object> get props => [grade];
}

class GradeLoaded extends GradeState {
  final grade;

  const GradeLoaded({required this.grade});
  @override
  List<Object> get props => [grade];
}

class GradeFailed extends GradeState {
  final String error;

  const GradeFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventFailure { error: $error }';
}
