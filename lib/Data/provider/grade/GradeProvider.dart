import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:dev_scout_fds/Data/models/Account/Account.dart';
import 'package:dev_scout_fds/Data/provider/account/AccountProvider.dart';
import 'package:dev_scout_fds/Data/provider/auth/AuthProvider.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/Data/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GradeDataProvider {
  GradeDataProvider();

  final _baseUrl = baseURL;

  Future gradePlayer(Grade grade, int gradeId) async {
    AuthDataProvider authDataProvider = AuthDataProvider();
    final token = await authDataProvider.getLocalAccessToken();
    try {
      final response = await httpClient.patch(
          Uri.http(_baseUrl, '/api/grade/$gradeId/'),
          body: jsonEncode(grade.toJson()));
      return response.body;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future getGrade(int playerId, int scoutId, int eventId) async {
    AuthDataProvider authDataProvider = AuthDataProvider();
    final token = await authDataProvider.getLocalAccessToken();

    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString('user');
    final accountID = jsonDecode(user!)['id'];

    final Map<String, String> _queryParameters = <String, String>{
      'event': eventId.toString(),
      'scout': accountID.toString()
    };
    try {
      final response = await httpClient
          .get(Uri.http(_baseUrl, '/api/results/$playerId/', _queryParameters));
      if (response.statusCode == 200) {
        final grade = jsonDecode(response.body);

        print('event: $grade');
        return Grade.fromJson(grade['scores'][0]);
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
