import '../../data/models/course_models.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseSuccess extends CourseState {
  final List<CourseModel> courses;

  CourseSuccess(this.courses);
}

class CourseFailure extends CourseState {
  final String message;

  CourseFailure(this.message);
}