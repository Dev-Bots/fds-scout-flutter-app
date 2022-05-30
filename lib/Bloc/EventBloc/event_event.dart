part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetAllEvents extends EventEvent {
  @override
  List<Object> get props => [];
}

class GetEvent extends EventEvent {
  final int eventId;

  const GetEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class SearchEvent extends EventEvent {
  final String eventName;

  const SearchEvent({required this.eventName});

  @override
  List<Object> get props => [eventName];
}
