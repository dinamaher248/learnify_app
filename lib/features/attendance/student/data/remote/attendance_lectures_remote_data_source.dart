import '../../../../../../core/Api/api_consumer.dart';
import '../../../../../../core/Api/endpoints.dart';
import '../models/lecture_attendance_model.dart';

class AttendanceLecturesRemoteDataSource {
  final ApiConsumer api;

  AttendanceLecturesRemoteDataSource({required this.api});

  Future<List<LectureAttendanceModel>> getLecturesAttendance(String courseId) async {
    final response = await api.get(Endpoints.attendanceCourseLectures(courseId));

    if (response is List) {
      return response
          .map((e) => LectureAttendanceModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }

    throw Exception('Unexpected response format for lectures attendance');
  }
}
