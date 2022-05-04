import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dev_scout_fds/Bloc/AuthBloc/auth_bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/main.dart';
// import 'package:mobile_banking/infrastructure/data_provider/config.dart';

// import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dev_scout_fds/Data/provider/config/config.dart';

class AuthDataProvider {
  final _baseUrl = baseURL;

  Future login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await httpClient.post(Uri.http(_baseUrl, '/api/token/'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'username': username, 'password': password}));
      // print(jsonDecode(response.body)['account']);

      if (response.statusCode == 200) {
        final accessToken = jsonDecode(response.body)['access'];
        final refreshToken = jsonDecode(response.body)['refresh'];
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        final user = jsonDecode(response.body)['account'];

        print('Jooooooooly');
        print(response.body);
        if (user['type'] == 'SCOUT') {
          print(user['type'] == 'SCOUT');
          Account account = Account.fromJson(user);
          await prefs.setString('user', jsonEncode(account));
          print(account.firstName);
          return account;
        } else {
          return null;
        }
      }
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }

  // ======================== Working Refresh ========================

  Future RefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    // AuthBloc authBloc = AuthBloc();
    print('boooouuuuuujeeeeeeeeeeeeeeeeee + ${prefs.getString('user')}');

    final user = prefs.getString('user');
    final accountID = Account.fromJson(jsonDecode(user!));
    print('ACCOUNT ID $accountID');

    try {
      final response =
          await httpClient.post(Uri.http(_baseUrl, '/api/token/refresh/'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({'refresh': prefs.getString('refreshToken')}));
      print(response.body);

      if (response.statusCode == 200) {
        final accessToken = jsonDecode(response.body)['access'];
        prefs.setString('accessToken', accessToken);
        return response.body;
      }
      if (response.statusCode == 401) {
        expiredRelogin();
        print('Refresh Token has also expired!');
        // await login(
        //     prefs.getString('username'), prefs.getString('password'));
      }
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }

  Future expiredRelogin() async {
    final prefs = await SharedPreferences.getInstance();
    var token = await getLocalAccessToken();
    try {
      final response =
          await httpClient.get(Uri.http(_baseUrl, '/api-auth/logout/'));

      // prefs.remove('accessToken');
      // prefs.remove('refreshToken');
      print('objecter');
      prefs.clear();
      navigatorKey.currentState!.pushNamed('/login');
      print('object');
      return response.body;
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }

// =====================Experimental code===================================

  Future refreshToken(refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    print(
        'boooouuuuuujeeeeeeeeeeeeeeeeee + ${prefs.getString('refreshToken')}');
    AuthBloc authBloc = AuthBloc();
    try {
      final response =
          await httpClient.post(Uri.http(_baseUrl, '/api/token/refresh/'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({'refresh': refreshToken}));
      print(response.body);

      if (response.statusCode == 200) {
        final accessToken = jsonDecode(response.body)['access'];
        prefs.setString('accessToken', accessToken);
        return response.body;
      }
      if (response.statusCode == 401) {
        print('Refresh Token has also expired!!!!');

        // await login(
        //     prefs.getString('username'), prefs.getString('password'));
      }
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }

  // ==========================================================================================

  // Future getToken() async {
  //   try {
  //     final response = await httpClient.get(Uri.http(
  //         _baseUrl, '/api/auth/token/')); // This is to be corrected later
  //     print(response.body);
  //     return response.body;
  //   } catch (e) {
  //     print('AUTH ERROR $e');
  //   }
  // }

  Future checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final IsAuthenticated = user != null ? true : false;
    print('Is Authenticated $IsAuthenticated');
    return IsAuthenticated;
  }

  Future getLocalAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    // var token = await getLocalAccessToken();
    try {
      print('LOGOUT PROVIDER');
      final response = await httpClient.post(
        Uri.http(_baseUrl, '/api-auth/logout/'),
      );
      // if (response.statusCode == 200) {
      //   // prefs.remove('accessToken');
      //   // prefs.remove('refreshToken');

      //   return response.body;
      // }

      prefs.clear();
      print(prefs.getString('accessToken'));
      navigatorKey.currentState!.pushNamed('/login');
      // return
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }

  Future register(Account account) async {
    // var token = await getToken();
    try {
      var request =
          http.MultipartRequest('POST', Uri.http(_baseUrl, '/api/scouts/'));
      request.fields['username'] = (account.userName).toString();
      request.fields['password'] = (account.password).toString();
      request.fields['first_name'] = (account.firstName).toString();
      request.fields['last_name'] = (account.lastName).toString();
      request.fields['more'] = (account.more).toString();

      // request.files.add(await http.MultipartFile.fromPath(
      //     'profile_picture', account.profilePicture!.path,
      //     contentType: MediaType('image', 'jpeg')));

      // request.files.add(await http.MultipartFile.fromPath(
      //     'birth_certificate', account.profilePicture!.path,
      //     contentType: MediaType('image', 'jpeg')));

      // request.files.add(await http.MultipartFile.fromPath(
      //     'highest_education_evidence', account.profilePicture!.path,
      //     contentType: MediaType('image', 'jpeg')));

      // var proPic = await http.MultipartFile.fromPath('profile_picture', account.profilePicture);
      // request.files.add(proPic);

      final response = await httpClient.post(
        Uri.http(_baseUrl, '/api/scouts/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer ' + token
        },
        body: jsonEncode(account.toJson()),
      );

      // print(response.body);
      // return response.body;
    } catch (e) {
      print('AUTH ERROR $e');
    }
  }
}
