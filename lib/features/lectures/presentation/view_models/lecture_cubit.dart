import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/lectures/presentation/view_models/lecture_state.dart';

import '../../data/repo/lecture_repo.dart';

class LectureCubit extends Cubit<LectureState> {
  final LectureRepo repo;

  LectureCubit(this.repo) : super(LectureInitial());

  Future<void> getLectures(String courseId) async {
    emit(LectureLoading());

    try {
      final data = await repo.getLectures(courseId);
      emit(LectureSuccess(data));
    } catch (e) {
      emit(LectureFailure(e.toString()));
    }
  }
}