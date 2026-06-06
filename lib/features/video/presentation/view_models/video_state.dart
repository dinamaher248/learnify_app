import '../../data/models/lecture_video_model.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoSuccess extends VideoState {
  final LectureVideoModel video;
  VideoSuccess(this.video);
}

class VideoFailure extends VideoState {
  final String message;
  VideoFailure(this.message);
}
