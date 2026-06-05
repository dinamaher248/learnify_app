import '../../../courses/data/models/course_models.dart';

abstract class GradesState {}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesSuccess extends GradesState {
  final List<CourseModel> grades;
  GradesSuccess(this.grades);
}

class GradesFailure extends GradesState {
  final String error;
  GradesFailure(this.error);
}
