import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/auth_interceptor.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/logging_interceptor.dart';

class ProductDioConfig {
  static Dio productDioConfig() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiServesConfig.BaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    dio.interceptors.addAll([AuthInterceptor(), LoggingInterceptor()]);
    return dio;
  }
}
