import '../../data/models/lecture_model.dart';
abstract class LectureState {}

class LectureInitial extends LectureState {}

class LectureLoading extends LectureState {}

class LectureSuccess extends LectureState {
  final List<LectureModel> lectures;

  LectureSuccess(this.lectures);
}

class LectureFailure extends LectureState {
  final String message;

  LectureFailure(this.message);
}