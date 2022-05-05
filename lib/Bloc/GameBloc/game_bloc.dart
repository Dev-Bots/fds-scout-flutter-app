import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _gameRepository = GameRepository();

  GameBloc() : super(GamesLoading()) {
    on<GetAllGames>((event, emit) async {
      var games = await _gameRepository.getAllGames();

      if (games != null) {
        emit(GamesLoaded(games: games));
      } else {
        emit(const GamesFailed(error: "Failed to load."));
      }
    });
  }
}
