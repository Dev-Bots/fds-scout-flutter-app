import 'package:dev_scout_fds/Data/provider/provider.dart';

class GradeRepository {
  final GradeDataProvider gameDataProvider = GradeDataProvider();

  GradeRepository();

  Future gradePlayer(grade, gradeId) async {
    print('reached grade repository');
    return await gameDataProvider.gradePlayer(grade, gradeId);
  }

  Future getGrade(playerId, scoutId, eventId) async {
    print('reached grade repository');
    return await gameDataProvider.getGrade(playerId, scoutId, eventId);
  }
}
