part of 'parameter_bloc.dart';

abstract class ParameterState extends Equatable {
  const ParameterState();

  @override
  List<Object> get props => [];
}

class ParameterInitial extends ParameterState {}

// =====================Get All Events==========================================

class ParametersLoading extends ParameterState {}

class ParametersLoaded extends ParameterState {
  final parameter;

  const ParametersLoaded({required this.parameter});
  @override
  List<Object> get props => [parameter];
}

class ParametersFailed extends ParameterState {
  final String error;

  const ParametersFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ParametersFailure { error: $error }';
}
