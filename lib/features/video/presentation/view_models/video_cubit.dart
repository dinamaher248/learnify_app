import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/lecture_video_repo.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final LectureVideoRepo repo;

  VideoCubit(this.repo) : super(VideoInitial());

  Future<void> getLectureVideo(String lectureId) async {
    if (!isClosed) emit(VideoLoading());

    try {
      final model = await repo.getLectureVideo(lectureId);
      if (!isClosed) emit(VideoSuccess(model));
    } catch (e) {
      if (!isClosed) emit(VideoFailure(e.toString()));
    }
  }

  Future<void> markVideoViewed(String lectureId) async {
    try {
      await repo.markVideoViewed(lectureId);
    } catch (_) {}
  }
}
