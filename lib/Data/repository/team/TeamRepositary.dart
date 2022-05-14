import 'package:dev_scout_fds/Data/provider/provider.dart';

class TeamRepository {
  final TeamDataProvider teamDataProvider = TeamDataProvider();

  TeamRepository();

  Future getTeams(teamId) async {
    print('reached team repository');
    var team = await teamDataProvider.getTeam(teamId);
    print(team);
    return team;
  }
}
