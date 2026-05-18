import 'package:learnify_app/features/lectures/data/models/lecture_details_model.dart';

import '../../../../core/Api/api_consumer.dart';
import '../../../../core/Api/endpoints.dart';

class LectureDetailsRepo {
  final ApiConsumer api;

  LectureDetailsRepo(this.api);

  Future<LectureDetailsModel> getLectureCheckerDetails(
    String courseId,
    String lectureId,
  ) async {
    final response = await api.get(
      "${Endpoints.courseUrl}/$courseId/lectures/$lectureId",
    );
   
    return LectureDetailsModel.fromJson(response);
  }
}