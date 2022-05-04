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

class AccountDataProvider {
  AccountDataProvider();

  final _baseUrl = baseURL;

  Future getCurrentUser(id) async {
    try {
      final response = await httpClient
          .get(Uri.http(_baseUrl, '/api/scouts/$id/'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final account = jsonDecode(response.body);
        return Account.fromJson(account);

        // return accounts.map((account) => Account.fromJson(account)).toList();
        // return accounts[0]['userName'];
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future getLocalAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = prefs.getString('user');
      if (user != null) {
        print(user);
        final passeduser = Account.fromJson(jsonDecode(user));
        print(passeduser.userName);
        return Account.fromJson(jsonDecode(user));
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future updateAccount(int id, Account account) async {
    AuthDataProvider authDataProvider = AuthDataProvider();
    final token = await authDataProvider.getLocalAccessToken();
    try {
      final response = await httpClient.patch(
          Uri.http(_baseUrl, '/api/scouts/$id/'),
          body: jsonEncode(account.toJson()));
      return response.body;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future updateLocalAccount() async {
    AccountDataProvider accountDataProvider = AccountDataProvider();
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.getString('user'));
      accountDataProvider.getCurrentUser(prefs.getString('user')).then((user) {
        prefs.setString('user', jsonEncode(user));
      });
      print(prefs.getString('user'));
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future getPlayer(id) async {
    try {
      final response = await httpClient
          .get(Uri.http(_baseUrl, '/api/players/$id/'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final account = jsonDecode(response.body);
        return account;

        // return accounts.map((account) => Account.fromJson(account)).toList();
        // return accounts[0]['userName'];
      } else if (response.statusCode == 400) {
        print('400 Error');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
