import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/auth/presentation/view_models/auth_state.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial());

  //! LOGIN
  Future<void> login(String username, String password, bool rememberMe) async {
    emit(LoginLoading());

    try {
      final response = await repo.login(
        username: username,
        password: password,
        rememberMe: rememberMe,
      );

      //! save token
      await CacheHelper.saveData(key: "token", value: response["accessToken"]);
      await CacheHelper.saveData(
        key: "refreshToken",
        value: response["refreshToken"],
      );
      if (!isClosed) {
        emit(LoginSuccess());
      }
    } on ServerException catch (e) {
      if (!isClosed) emit(LoginFailure(e.errorModel.errorMessage));
    }
  }

  //! Refresh Token
  Future<void> refreshToken(String refreshToken) async {
    emit(RefreshTokenLoading());

    try {
      final response = await repo.refreshAccessToken(
        refreshToken: refreshToken,
      );
      final newAccessToken = response["accessToken"];
      final newRefreshToken = response["refreshToken"];

      // Save new tokens in cache
      await CacheHelper.saveData(key: "token", value: newAccessToken);
      await CacheHelper.saveData(key: "refreshToken", value: newRefreshToken);

      emit(RefreshTokenSuccess());
    } on ServerException catch (e) {
      emit(RefreshTokenFailure(e.errorModel.errorMessage));
    }
  }

  //! Logout
  Future<void> logout(String refreshToken) async {
    emit(LogoutLoading());

    try {
      await repo.logout(refreshToken: refreshToken);
      // Clear tokens from cache
      await CacheHelper.removeData(key: "token");
      await CacheHelper.removeData(key: "refreshToken");
      emit(LogoutSuccess());
    } on ServerException catch (e) {
      emit(LogoutFailure(e.errorModel.errorMessage));
    }
  }

  //! create student before activate

  Future<void> createStudent() async {
    emit(CreateStudentLoading());

    try {
      //! 1. login as admin
      final adminLogin = await repo.login(
        username: "superadmin@university.com",
        password: "SuperAdmin@123",
        rememberMe: true,
      );

      final adminToken = adminLogin["data"]["accessToken"];
      //! 2. create student
      await repo.createStudentWithToken(
        token: adminToken,
        email: "dinamaher248@gmail.com",
        firstName: "Dina",
        lastName: "Maher",
        gender: "female",
        departmentId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      );
      print("CREATE STUDENT DONE");
      emit(CreateStudentSuccess());
    } catch (e) {
      emit(CreateStudentFailure("Failed to create student"));
    }
  }

  //! ACTIVATE
  Future<void> activateAccount(String code, String password) async {
    emit(ActivateAccountLoading());

    try {
      await repo.activateAccount(
        code: code.toString(),
        password: password.toString(),
      );

      emit(ActivateAccountSuccess());
    } on ServerException catch (e) {
      emit(ActivateAccountFailure(e.errorModel.errorMessage));
    }
  }

  //! Forgot Password
  Future<void> forgotPassword(String emailOrId) async {
    emit(ForgotPasswordLoading());

    try {
      await repo.forgotPassword(emailOrId: emailOrId);
      emit(ForgotPasswordSuccess());
    } on ServerException catch (e) {
      emit(ForgotPasswordFailure(e.errorModel.errorMessage));
    }
  }

  //! Resend OTP
  Future<void> resendOtp(String emailOrId) async {
    emit(ResendOtpLoading());

    try {
      await repo.resendOtp(emailOrId: emailOrId);
      emit(ResendOtpSuccess());
    } on ServerException catch (e) {
      emit(ResendOtpFailure(e.errorModel.errorMessage));
    }
  }

  //! Verify OTP
  Future<void> verifyOtp(String emailOrId, String otp) async {
    emit(VerifyOtpLoading());

    try {
      await repo.verifyOtp(emailOrId: emailOrId, otp: otp);
      emit(VerifyOtpSuccess());
    } on ServerException catch (e) {
      emit(VerifyOtpFailure(e.errorModel.errorMessage));
    }
  }

  //! Reset Password with token
  Future<void> resetPasswordWithToken({
    required String emailOrId,
    required String resetToken,
    required String newPassword,
  }) async {
    emit(ResetPasswordWithTokenLoading());

    try {
      await repo.resetPasswordWithToken(
        emailOrId: emailOrId,
        resetToken: resetToken,
        newPassword: newPassword,
      );
      emit(ResetPasswordWithTokenSuccess());
    } on ServerException catch (e) {
      emit(ResetPasswordWithTokenFailure(e.errorModel.errorMessage));
    }
  }
}
