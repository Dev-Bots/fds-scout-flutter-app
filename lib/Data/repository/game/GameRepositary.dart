import 'package:dev_scout_fds/Data/provider/provider.dart';

class GameRepository {
  final GameDataProvider gameDataProvider = GameDataProvider();

  GameRepository();

  Future getAllGames(int eventId) async {
    print('reached event repository');
    return await gameDataProvider.getAllGames(eventId);
  }
}
