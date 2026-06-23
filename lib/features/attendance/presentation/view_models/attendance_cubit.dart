import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../data/repo/attendance_repo.dart';
import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());

  Future<void> fetchCoursesAttendance() async {
    emit(AttendanceLoading());

    try {
      final courses = await repo.getCoursesAttendance();
      emit(AttendanceSuccess(courses));
    } catch (e) {
      if (e is ServerException) {
        emit(AttendanceFailure(e.errorModel.errorMessage));
      } else {
        emit(AttendanceFailure(e.toString()));
      }
    }
  }

  Future<void> registerAttendance(String lectureId, String code) async {
    emit(AttendanceRegisterLoading());
    try {
      await repo.registerAttendance(lectureId, code);
      emit(AttendanceRegisterSuccess());
      // Re-fetch attendance stats
      fetchCoursesAttendance();
    } catch (e) {
      if (e is ServerException) {
        emit(AttendanceRegisterFailure(e.errorModel.errorMessage));
      } else {
        emit(AttendanceRegisterFailure(e.toString()));
      }
    }
  }
}
