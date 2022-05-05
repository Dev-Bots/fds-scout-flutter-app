import 'dart:async';
import 'dart:convert';

import 'package:dev_scout_fds/Bloc/EventBloc/event_bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/Data/provider/interceptors/interceptors.dart';
// import 'package:mobile_banking/infrastructure/data_provider/config.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
// import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EventDataProvider {
  EventDataProvider();

  // final http.Client httpClient;

  final _baseUrl = baseURL;

  final httpClient = InterceptedHttp.build(interceptors: [
    Interceptors(),
  ], retryPolicy: ExpiredTokenRetryPolicy());

  Future getAllEvents() async {
    print('reached event provider');
    try {
      final response = await httpClient.get(Uri.http(_baseUrl, '/api/events/'));

      if (response.statusCode == 200) {
        final events = jsonDecode(response.body);

        print('events: $events');
        return events.map((event) => Event.fromJson(event)).toList();
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      // throw Exception(e.toString());
      // print('error: $e');
    }
  }

  Future getEvent(eventId) async {
    print('Provider called with ID: $eventId');
    try {
      final response =
          await httpClient.get(Uri.http(_baseUrl, '/api/events/$eventId/'));

      if (response.statusCode == 200) {
        final event = jsonDecode(response.body);

        print('event: $event');
        return Event.fromJson(event);
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
