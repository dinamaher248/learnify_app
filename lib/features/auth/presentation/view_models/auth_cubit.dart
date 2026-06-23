import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/auth/presentation/view_models/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/errors/exceptions.dart';
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
      final accessToken = response["data"]["accessToken"];
      await CacheHelper.saveData(key: "token", value: accessToken);
      await CacheHelper.saveData(
        key: "refreshToken",
        value: response["data"]["refreshToken"],
      );
      
      // Attempt to extract role from JWT token
      String? role;
      try {
        final parts = accessToken.split('.');
        if (parts.length == 3) {
          final payloadString = parts[1];
          // Add padding if necessary
          final normalized = base64Url.normalize(payloadString);
          final decodedPayload = utf8.decode(base64Url.decode(normalized));
          final Map<String, dynamic> payloadMap = json.decode(decodedPayload);
          
          // Check standard role claims
          role = payloadMap['role']?.toString() ?? 
                 payloadMap['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']?.toString();
        }
      } catch (e) {
        print("Failed to decode JWT for role: $e");
      }

      // Fallback to response body if JWT didn't contain it
      if (role == null) {
        if (response["data"]["roles"] != null &&
            response["data"]["roles"] is List &&
            (response["data"]["roles"] as List).isNotEmpty) {
          role = response["data"]["roles"][0].toString();
        } else if (response["roles"] != null &&
            response["roles"] is List &&
            (response["roles"] as List).isNotEmpty) {
          role = response["roles"][0].toString();
        } else {
          role = response["data"]["role"]?.toString() ??
              response["role"]?.toString();
        }
      }

      if (role != null) {
        await CacheHelper.saveData(key: 'role', value: role);
      } else {
        await CacheHelper.removeData(key: 'role');
      }

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
      await CacheHelper.removeData(key: "role");
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
        email: "molearnifytest@gmail.com",
        firstName: "Learnify",
        lastName: "Test1",
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
      final resp = await repo.activateAccount(
        code: code.toString(),
        password: password.toString(),
      );

      String? role = resp['data']?['role']?.toString();
      if (role == null && resp['data']?['roles'] != null && resp['data']['roles'] is List && (resp['data']['roles'] as List).isNotEmpty) {
        role = resp['data']['roles'][0].toString();
      }
      if (role != null) await CacheHelper.saveData(key: 'role', value: role);

      emit(ActivateAccountSuccess());
    } on ServerException catch (e) {
      emit(ActivateAccountFailure(e.errorModel.errorMessage));
    }
  }

  /// Activate Parent account
  Future<void> activateParent({
    required String code,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(ActivateAccountLoading());

    try {
      final resp = await repo.activateParent(
        code: code,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      // save tokens
      final access = resp['data']['accessToken'];
      final refresh = resp['data']['refreshToken'];
      await CacheHelper.saveData(key: 'token', value: access);
      await CacheHelper.saveData(key: 'refreshToken', value: refresh);
      String? role = resp['data']?['role']?.toString();
      if (role == null && resp['data']?['roles'] != null && resp['data']['roles'] is List && (resp['data']['roles'] as List).isNotEmpty) {
        role = resp['data']['roles'][0].toString();
      }
      if (role != null) await CacheHelper.saveData(key: 'role', value: role);

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

  Future<void> generateParentCode() async {
    emit(GenerateParentCodeLoading());

    try {
      final parentCode = await repo.generateParentCode();

      emit(GenerateParentCodeSuccess(parentCode));
    } on ServerException catch (e) {
      emit(GenerateParentCodeFailure(e.errorModel.errorMessage));
    } catch (e) {
      emit(GenerateParentCodeFailure(e.toString()));
    }
  }
}
