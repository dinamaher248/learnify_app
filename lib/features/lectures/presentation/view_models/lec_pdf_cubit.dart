import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/lecture_pdf_repo.dart';
import 'lec_pdf_state.dart';

class LecturePdfCubit extends Cubit<LecturePdfState> {
  final LecturePdfRepo repo;

  LecturePdfCubit(this.repo) : super(LecturePdfInitial());

  Future<void> getLecturePdf(String lectureId) async {
    emit(LecturePdfLoading());

    try {
      final pdf = await repo.getLecturePdf(lectureId);
      emit(LecturePdfSuccess(pdf));
    } catch (e) {
      emit(LecturePdfFailure(e.toString()));
    }
  }
}