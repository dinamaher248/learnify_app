import '../../../../../core/Api/dio_consumer.dart';
import '../models/lecture_video_model.dart';

class LectureVideoRepo {
  final DioConsumer dioConsumer;

  LectureVideoRepo({required this.dioConsumer});

  Future<LectureVideoModel> getLectureVideo(String lectureId) async {
    final response = await dioConsumer.get(
      '/api/v1/academic/lectures/$lectureId/video',
    );
    return LectureVideoModel.fromJson(response);
  }

  Future<void> markVideoViewed(String lectureId) async {
    await dioConsumer.put('/api/v1/academic/lectures/$lectureId/video/viewed');
  }
}
