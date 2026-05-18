import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../data/repo/attendance_lectures_repo.dart';
import 'attendance_lectures_state.dart';

class AttendanceLecturesCubit extends Cubit<AttendanceLecturesState> {
  final AttendanceLecturesRepo repo;

  AttendanceLecturesCubit(this.repo) : super(AttendanceLecturesInitial());

  Future<void> fetchLectures(String courseId) async {
    emit(AttendanceLecturesLoading());

    try {
      final lectures = await repo.getLecturesAttendance(courseId);
      emit(AttendanceLecturesSuccess(lectures));
    } catch (e) {
      if (e is ServerException) {
        emit(AttendanceLecturesFailure(e.errorModel.errorMessage));
      } else {
        emit(AttendanceLecturesFailure(e.toString()));
      }
    }
  }
}
