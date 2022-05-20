import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamRepository _teamRepository = TeamRepository();

  TeamBloc() : super(TeamLoading()) {
    on<GetTeams>((teams, emit) async {
      emit(TeamLoading());
      var team1 = await _teamRepository.getTeams(teams.team1);
      var team2 = await _teamRepository.getTeams(teams.team2);

      if (team2 != null && team1 != null) {
        emit(TeamLoaded(team1: team1, team2: team2));
      } else {
        emit(const TeamFailed(error: "Failed to load."));
      }
    });
  }
}
