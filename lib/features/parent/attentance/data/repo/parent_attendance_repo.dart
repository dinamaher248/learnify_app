import 'package:learnify_app/core/Api/api_consumer.dart';
import 'package:learnify_app/core/Api/endpoints.dart';

import '../../../../attendance/data/models/course_attendance_model.dart';

class ParentAttendanceRepo {
  final ApiConsumer api;
  ParentAttendanceRepo({required this.api});

  Future<List<CourseAttendanceModel>> getAttendanceForChild(
    String studentId,
  ) async {
    // endpoint: /api/v1/attendance/parent/children/{studentId}/courses
    final path = '/api/v1/attendance/parent/children/$studentId/courses';
    final response = await api.get(path);

    if (response is List) {
      return response
          .map(
            (e) => CourseAttendanceModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }

    // fallback to global attendance endpoint
    final fallback = await api.get(Endpoints.attendanceCoursesUrl);
    if (fallback is List) {
      return fallback
          .map(
            (e) => CourseAttendanceModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }

    return [];
  }
}
