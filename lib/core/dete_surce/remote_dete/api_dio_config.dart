import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/auth_interceptor.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/logging_interceptor.dart';

class ApiDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiServesConfig.BaseUrl,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio));
    dio.interceptors.add(LoggingInterceptor()); // إن وجد

    return dio;
  }
}
