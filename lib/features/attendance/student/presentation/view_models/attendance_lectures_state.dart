import '../../data/models/lecture_attendance_model.dart';

abstract class AttendanceLecturesState {}

class AttendanceLecturesInitial extends AttendanceLecturesState {}

class AttendanceLecturesLoading extends AttendanceLecturesState {}

class AttendanceLecturesSuccess extends AttendanceLecturesState {
  final List<LectureAttendanceModel> lectures;

  AttendanceLecturesSuccess(this.lectures);
}

class AttendanceLecturesFailure extends AttendanceLecturesState {
  final String message;

  AttendanceLecturesFailure(this.message);
}
