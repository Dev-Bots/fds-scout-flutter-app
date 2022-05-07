import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Data/provider/provider.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider = AuthDataProvider();

  AuthRepository();

  Future login(String username, String password) async {
    return await authDataProvider.login(username, password);
  }

  Future checkAuth() async {
    return await authDataProvider.checkAuth();
  }

  Future logout() async {
    return await authDataProvider.logout();
  }

  Future register(Account account) async {
    return await authDataProvider.register(account);
  }

  Future refreshToken(String refreshToken) async {
    return await authDataProvider.refreshToken(refreshToken);
  }
}
