import 'package:learnify_app/core/Api/api_consumer.dart';

import '../../../courses/data/models/course_models.dart';
import '../../../courses/data/repo/course_repo.dart';

class GradesRepo {
  final ApiConsumer api;

  GradesRepo(this.api);

  /// Temporary: reuse courses endpoint as grades list until a grades API exists
  Future<List<CourseModel>> getGrades() async {
    final courseRepo = CourseRepo(api);
    return await courseRepo.getCourses();
  }
}
