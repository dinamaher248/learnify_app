import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../attendance/data/models/course_attendance_model.dart';
import '../../data/repo/parent_attendance_repo.dart';

abstract class ParentAttendanceState {}

class ParentAttendanceInitial extends ParentAttendanceState {}

class ParentAttendanceLoading extends ParentAttendanceState {}

class ParentAttendanceLoaded extends ParentAttendanceState {
  final List<CourseAttendanceModel> items;
  ParentAttendanceLoaded(this.items);
}

class ParentAttendanceError extends ParentAttendanceState {
  final String message;
  ParentAttendanceError(this.message);
}

class ParentAttendanceCubit extends Cubit<ParentAttendanceState> {
  final ParentAttendanceRepo repo;
  ParentAttendanceCubit(this.repo) : super(ParentAttendanceInitial());

  Future<void> loadForChild(String studentId) async {
    emit(ParentAttendanceLoading());
    try {
      final data = await repo.getAttendanceForChild(studentId);
      emit(ParentAttendanceLoaded(data));
    } on ServerException catch (e) {
      emit(ParentAttendanceError(e.errorModel.errorMessage));
    } catch (e) {
      emit(ParentAttendanceError(e.toString()));
    }
  }
}
