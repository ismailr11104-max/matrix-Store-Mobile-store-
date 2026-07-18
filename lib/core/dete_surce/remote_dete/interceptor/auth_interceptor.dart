import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;

    if (token != null) {
      options.headers["Authorization"] = 'Bearer $token';
    }
    handler.next(options);
  }
}
