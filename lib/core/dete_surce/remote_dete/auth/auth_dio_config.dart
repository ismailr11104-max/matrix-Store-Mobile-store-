import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/auth/auth_api_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/auth_interceptor.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/logging_interceptor.dart';

class AuthDioConfig {
  static Dio authCreateDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AuthApiConfig.authBaseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
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
