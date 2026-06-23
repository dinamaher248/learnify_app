import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // If the request contains FormData (multipart) let Dio set the
    // Content-Type header including the boundary. Manually setting
    // 'multipart/form-data' removes the boundary and can break uploads.
    if (options.data is FormData) {
      options.headers.remove('Content-Type');
    } else {
      options.headers['Content-Type'] = 'application/json';
    }
    //final token = CacheHelper.getData(key: 'token');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
