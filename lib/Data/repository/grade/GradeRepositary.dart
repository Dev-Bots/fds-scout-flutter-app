import 'package:dev_scout_fds/Data/provider/provider.dart';

class GradeRepository {
  final GradeDataProvider gameDataProvider = GradeDataProvider();

  GradeRepository();

  Future gradePlayer(grade) async {
    print('reached grade repository');
    return await gameDataProvider.gradePlayer(grade);
  }
}
