import '../../../../core/Api/api_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../models/lecture_model.dart';
class LectureRepo {
  final ApiConsumer api;

  LectureRepo(this.api);

  Future<List<LectureModel>> getLectures(String courseId) async {
    final response = await api.get(
      "${Endpoints.courseUrl}/$courseId/lectures",
    );

    return (response as List)
        .map((e) => LectureModel.fromJson(e))
        .toList();
  }
}