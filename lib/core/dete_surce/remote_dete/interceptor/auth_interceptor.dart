import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/auth/auth_api_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  AuthApiService? _authApi;

  AuthInterceptor(this.dio);

  AuthApiService get authApi => _authApi ??= AuthApiService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserRepository().getAccessToken();
    print("🔑 Current Saved Access Token: $token");
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final user = UserRepository().getUser();

      if (user?.refreshToken != null && user!.refreshToken!.isNotEmpty) {
        try {
          final tokenResult = await authApi.refreshToken(user.refreshToken!);

          final newAccessToken = tokenResult?['accessToken'];
          final newRefreshToken = tokenResult?['refreshToken'];

          if (newAccessToken != null) {
            await UserRepository().updateTokens(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
            );
            final request = err.requestOptions;
            request.headers["Authorization"] = "Bearer $newAccessToken";

            final response = await dio.fetch(request);
            return handler.resolve(response);
          }
        } catch (e) {
          await UserRepository().clearAll();
          return handler.reject(err);
        }
      }

      await UserRepository().clearAll();
    }

    handler.next(err);
  }

  Future<String?> refreshToken() async {
    final refreshToken = UserRepository().getRefreshToken();

    if (refreshToken == null) {
      return null;
    }

    final response = await dio.post(
      ApiServesConfig.authRefresh,
      data: {"refreshToken": refreshToken},
    );

    return response.data['accessToken'];
  }
}
