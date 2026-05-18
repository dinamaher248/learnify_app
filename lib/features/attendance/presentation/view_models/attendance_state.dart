import '../../data/models/course_attendance_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final List<CourseAttendanceModel> attendanceCourses;

  AttendanceSuccess(this.attendanceCourses);
}

class AttendanceFailure extends AttendanceState {
  final String message;

  AttendanceFailure(this.message);
}
