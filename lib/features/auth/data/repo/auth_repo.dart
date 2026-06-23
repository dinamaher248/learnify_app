import 'package:dio/dio.dart';

import '../../../../../core/Api/api_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../../profile_student/data/models/parent_code_model.dart';

class AuthRepo {
  final ApiConsumer api;

  AuthRepo({required this.api});

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await api.post(
      Endpoints.loginUrl,
      data: {
        "username": username,
        "password": password,
        "rememberMe": rememberMe,
      },
    );

    return response;
  }

  Future<Map<String, dynamic>> activateAccount({
    required String code,
    required String password,
  }) async {
    final response = await api.post(
      Endpoints.activateUrl,
      data: {"code": code, "password": password},
    );

    return response as Map<String, dynamic>;
  }

  Future<void> createStudentWithToken({
    required String token,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String departmentId,
  }) async {
    await api.post(
      "/api/v1/auth/admin/students",
      data: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "departmentId": departmentId,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  //! Refresh Token
  Future<Map<String, dynamic>> refreshAccessToken({
    required String refreshToken,
  }) async {
    final response = await api.post(
      Endpoints.refreshTokenUrl,
      data: {"refreshToken": refreshToken},
    );
    return response;
  }

  //! Logout
  Future<void> logout({required String refreshToken}) async {
    await api.post(Endpoints.logoutUrl, data: {"refreshToken": refreshToken});
  }

  //! Forgot Password - send OTP
  Future<void> forgotPassword({required String emailOrId}) async {
    await api.post(Endpoints.forgotPasswordUrl, data: {"emailOrId": emailOrId});
  }

  //! Resend OTP
  Future<void> resendOtp({required String emailOrId}) async {
    await api.post(Endpoints.resendOtpUrl, data: {"emailOrId": emailOrId});
  }

  //! Verify OTP
  Future<void> verifyOtp({
    required String emailOrId,
    required String otp,
  }) async {
    await api.post(
      Endpoints.verifyOtpUrl,
      data: {"emailOrId": emailOrId, "otp": otp},
    );
  }

  //! Reset Password with token
  Future<void> resetPasswordWithToken({
    required String emailOrId,
    required String resetToken,
    required String newPassword,
  }) async {
    await api.post(
      Endpoints.resetPasswordUrl,
      data: {
        "emailOrId": emailOrId,
        "resetToken": resetToken,
        "newPassword": newPassword,
      },
    );
  }

  Future<ParentCodeModel> generateParentCode() async {
    final response = await api.post(
      '/api/v1/auth/parent/generate-code',
      data: {},
    );

    return ParentCodeModel.fromJson(response);
  }

  Future<Map<String, dynamic>> activateParent({
    required String code,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await api.post(
      '/api/v1/auth/parent/activate',
      data: {
        'code': code,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return response as Map<String, dynamic>;
  }
}
