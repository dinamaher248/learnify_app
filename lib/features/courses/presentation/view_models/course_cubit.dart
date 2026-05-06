import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/course_repo.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepo repo;

  CourseCubit(this.repo) : super(CourseInitial());

 Future<void> getCourses() async {
  emit(CourseLoading());

  try {
final data = await repo.getCoursesWithInstructors();    emit(CourseSuccess(data));
  } catch (e) {
    emit(CourseFailure(e.toString()));
  }
}
}