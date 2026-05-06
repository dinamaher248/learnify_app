import 'package:learnify_app/core/Api/endpoints.dart';

import '../../../../core/Api/api_consumer.dart';
import '../models/course_models.dart';
import '../models/instructor_model.dart';
class CourseRepo {
  final ApiConsumer api;

  CourseRepo(this.api);

  Future<List<CourseModel>> getCourses() async {
    final response = await api.get(
      Endpoints.courseUrl,
      queryParameters: {"pageNumber": 1, "pageSize": 10},
    );

    final List courses = response['data'];
    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

  Future<InstructorModel> getInstructor(String courseId) async {
    final response = await api.get(
      "${Endpoints.courseUrl}/$courseId/instructor",
    );

    return InstructorModel.fromJson(response);
  }

  Future<List<CourseModel>> getCoursesWithInstructors() async {
    final courses = await getCourses();

    await Future.wait(
      courses.map((course) async {
        final instructor = await getInstructor(course.id);
        course.instructor = instructor;
      }),
    );

    return courses;
  }
}