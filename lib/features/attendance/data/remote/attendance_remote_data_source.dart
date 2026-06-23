import '../../../../../core/Api/api_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../models/course_attendance_model.dart';

class AttendanceRemoteDataSource {
  final ApiConsumer api;

  AttendanceRemoteDataSource({required this.api});

  Future<List<CourseAttendanceModel>> getStudentAttendanceCourses() async {
    final response = await api.get(Endpoints.attendanceCoursesUrl);

    if (response is List) {
      return response
          .map(
            (e) => CourseAttendanceModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }

    throw Exception('Unexpected attendance API response format');
  }

  Future<void> registerAttendance(String lectureId, String code) async {
    await api.post(
      '/api/v1/attendance/lectures/$lectureId/register',
      data: {
        "code": code
      },
    );
  }
}
