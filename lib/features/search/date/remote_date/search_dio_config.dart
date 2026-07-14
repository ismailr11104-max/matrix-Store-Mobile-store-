import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';

class SearchDioConfig {
  static Dio createSearchDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiServesConfig.BaseUrl,
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
    return dio;
  }
}
