import 'dart:async';
import 'dart:convert';

import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/Data/provider/interceptors/interceptors.dart';
// import 'package:mobile_banking/infrastructure/data_provider/config.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
// import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ParameterDataProvider {
  ParameterDataProvider();

  // final http.Client httpClient;

  final _baseUrl = baseURL;

  final httpClient = InterceptedHttp.build(interceptors: [
    Interceptors(),
  ], retryPolicy: ExpiredTokenRetryPolicy());

  Future getAllParameters(eventId) async {
    print("Reached parameter provider");
    try {
      final response =
          await httpClient.get(Uri.http(_baseUrl, '/api/parameters/$eventId'));

      if (response.statusCode == 200) {
        final parameters = jsonDecode(response.body);
        return parameters;
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      // throw Exception(e.toString());
      // print('error: $e');
    }
  }
}
