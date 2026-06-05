import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/profile_student/presentation/view_models/profile_student_state.dart';

import '../../data/repo/student_profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final StudentProfileRepo repo;

  ProfileCubit(this.repo) : super(ProfileInitial());

  Future<void> getProfile() async {
    if (!isClosed) emit(ProfileLoading());

    try {
      final data = await repo.getStudentProfile();

      if (isClosed) return;

      emit(ProfileSuccess(data));
    } catch (e) {
      if (isClosed) return;

      emit(ProfileFailure(e.toString()));
    }
  }
}
