part of 'parameter_bloc.dart';

abstract class ParameterEvent extends Equatable {
  const ParameterEvent();

  @override
  List<Object> get props => [];
}

class GetAllParameters extends ParameterEvent {
  final int eventId;
  GetAllParameters(this.eventId);
  @override
  List<Object> get props => [eventId];
}
