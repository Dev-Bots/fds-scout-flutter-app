import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'parameter_event.dart';
part 'parameter_state.dart';

class ParameterBloc extends Bloc<ParameterEvent, ParameterState> {
  final ParameterRepository _parameterRepository = ParameterRepository();

  ParameterBloc() : super(ParametersLoading()) {
    on<GetAllParameters>((event, emit) async {
      var parameter =
          await _parameterRepository.getAllParameters(event.eventId);

      if (parameter != null) {
        emit(ParametersLoaded(parameter: parameter));
      } else {
        emit(const ParametersFailed(error: "Failed to load."));
      }
    });
  }
}
