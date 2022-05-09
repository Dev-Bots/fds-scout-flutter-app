import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final GradeRepository _gradeRepository = GradeRepository();
  GradeBloc() : super(GradeInitial()) {
    on<GradePlayer>((event, emit) async {
      emit(GradeLoading());
      var grade = await _gradeRepository.gradePlayer(event.grade);
      if (grade != null) {
        emit(GradeUploaded(grade: grade));
      } else {
        emit(const GradeFailed(error: "Failed to load."));
      }
    });

    on<GradeFormPrepare>((event, emit) async {
      emit(GradeLoading());
      print("Form event is ready.");
    });
  }
}
