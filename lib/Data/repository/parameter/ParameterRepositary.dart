import 'package:dev_scout_fds/Data/provider/parameter/ParameterProvider.dart';
import 'package:dev_scout_fds/Data/provider/provider.dart';

class ParameterRepository {
  final ParameterDataProvider parameterDataProvider = ParameterDataProvider();

  ParameterRepository();

  Future getAllParameters(eventId) async {
    print('reached parameter repository');
    return await parameterDataProvider.getAllParameters(eventId);
  }
}
