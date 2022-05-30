import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:dev_scout_fds/Data/models/Account/Account.dart';
import 'package:dev_scout_fds/Data/provider/auth/AuthProvider.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/Data/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GradeDataProvider {
  GradeDataProvider();

  final _baseUrl = baseURL;

  Future gradePlayer(Grade grade) async {
    AuthDataProvider authDataProvider = AuthDataProvider();
    final token = await authDataProvider.getLocalAccessToken();
    try {
      final response = await httpClient.post(Uri.http(_baseUrl, '/api/grade/'),
          body: jsonEncode(grade.toJson()));
      return response.body;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
