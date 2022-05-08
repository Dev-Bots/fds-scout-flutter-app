import 'package:dev_scout_fds/Data/provider/provider.dart';

class EventRepository {
  final EventDataProvider eventDataProvider = EventDataProvider();

  EventRepository();

  Future getAllEvents() async {
    print('reached event repository');
    return await eventDataProvider.getAllEvents();
  }

  Future getEvent(eventID) async {
    return await eventDataProvider.getEvent(eventID);
  }
}
