import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/auth/presentation/view_models/auth_state.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final user = await repo.login(
        email: email,
        password: password,
      );

      // save token
      await CacheHelper.saveData(
        key: 'token',
        value: user.token,
      );

      emit(LoginSuccess());
    } catch (e) {
      if (e is ServerException) {
        emit(LoginFailure(e.errorModel.errorMessage));
      } else {
        emit(LoginFailure("Something went wrong"));
      }
    }
  }
}