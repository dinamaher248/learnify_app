import '../../../../core/Api/api_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../models/login_model.dart';

class AuthRepo {
  final ApiConsumer api;

  AuthRepo({required this.api});

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      Endpoints.loginUrl,
      data: {
        "email": email,
        "password": password,
      },
    );

    return LoginModel.fromJson(response);
  }
}