import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository = EventRepository();

  EventBloc() : super(EventsLoading()) {
    on<GetAllEvents>((event, emit) async {
      var events = await _eventRepository.getAllEvents();

      if (events != null) {
        emit(EventsLoaded(events: events));
      } else {
        emit(const EventsFailed(error: "Failed to load."));
      }
    });
    on<GetEvent>((event, emit) async {
      emit(EventLoading());
      var currentEvent = await _eventRepository.getEvent(event.eventId);
      if (currentEvent != null) {
        emit(EventLoaded(event: currentEvent));
      } else {
        emit(const EventFailed(error: "Failed to load."));
      }
    });
    // on<SearchEvent>((event, emit) async {
    //   emit(EventLoading());
    //   var currentEvent = await _eventRepository.getEventByName(event.eventName);
    //   if (currentEvent != null) {
    //     emit(EventLoaded(event: currentEvent));
    //   } else {
    //     emit(const EventFailed(error: "Failed to load."));
    //   }
    // });
  }
}
