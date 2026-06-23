import '../models/course_attendance_model.dart';
import '../remote/attendance_remote_data_source.dart';

class AttendanceRepo {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepo({required this.remoteDataSource});

  Future<List<CourseAttendanceModel>> getCoursesAttendance() async {
    return await remoteDataSource.getStudentAttendanceCourses();
  }

  Future<void> registerAttendance(String lectureId, String code) async {
    return await remoteDataSource.registerAttendance(lectureId, code);
  }
}
