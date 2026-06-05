import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/grades_repo.dart';
import 'grades_state.dart';

class GradesCubit extends Cubit<GradesState> {
  final GradesRepo repo;

  GradesCubit(this.repo) : super(GradesInitial());

  Future<void> getGrades() async {
    if (!isClosed) emit(GradesLoading());

    try {
      final data = await repo.getGrades();
      if (!isClosed) emit(GradesSuccess(data));
    } catch (e) {
      if (!isClosed) emit(GradesFailure(e.toString()));
    }
  }
}
