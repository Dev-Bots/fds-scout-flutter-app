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

class GameDataProvider {
  GameDataProvider();

  // final http.Client httpClient;

  final _baseUrl = baseURL;

  final httpClient = InterceptedHttp.build(interceptors: [
    Interceptors(),
  ], retryPolicy: ExpiredTokenRetryPolicy());

  Future getAllGames() async {
    try {
      final response =
          await httpClient.get(Uri.http(_baseUrl, '/api/view_match/'));

      if (response.statusCode == 200) {
        final games = jsonDecode(response.body);

        print('Games: $games');
        return games.map((game) => Game.fromJson(game)).toList();
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      // throw Exception(e.toString());
      // print('error: $e');
    }
  }
}
