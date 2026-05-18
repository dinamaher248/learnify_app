import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart';
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
}
