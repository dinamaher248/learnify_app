import '../models/lecture_attendance_model.dart';
import '../remote/attendance_lectures_remote_data_source.dart';

class AttendanceLecturesRepo {
  final AttendanceLecturesRemoteDataSource remote;

  AttendanceLecturesRepo({required this.remote});

  Future<List<LectureAttendanceModel>> getLecturesAttendance(String courseId) async {
    return await remote.getLecturesAttendance(courseId);
  }
}
