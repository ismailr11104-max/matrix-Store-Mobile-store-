import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';

class FavoritesDioConfig {
  static Dio createFavoritesDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiServesConfig.BaseUrl,
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8),
        sendTimeout: const Duration(seconds: 8),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
    return dio;
  }
}
