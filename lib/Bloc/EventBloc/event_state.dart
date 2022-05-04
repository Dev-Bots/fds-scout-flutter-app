part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

// =====================Get All Events==========================================

class EventsLoading extends EventState {}

class EventsLoaded extends EventState {
  final events;

  const EventsLoaded({required this.events});
  @override
  List<Object> get props => [events];
}

class EventsFailed extends EventState {
  final String error;

  const EventsFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventsFailure { error: $error }';
}

// ==================Get Single Event===============================

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final event;

  const EventLoaded({required this.event});
  @override
  List<Object> get props => [event];
}

class EventFailed extends EventState {
  final String error;

  const EventFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventFailure { error: $error }';
}
