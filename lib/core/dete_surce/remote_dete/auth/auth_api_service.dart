import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_dio_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';

abstract class BaseApiService {
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body});
}

class AuthApiService extends BaseApiService {
  final Dio dio;
  AuthApiService([Dio? customDio])
    : dio = customDio ?? ApiDioConfig.createDio();
  @override
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(endpoint, data: body);
      final responseBody = response.data as Map<String, dynamic>;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw responseBody["message"] ?? "Failed to load data";
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      if (e is String) rethrow;
      throw e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<Map<String, String>?> refreshToken(String refreshToken) async {
    try {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiServesConfig.BaseUrl,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      final response = await refreshDio.post(
        ApiServesConfig.authRefresh,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final newAccessToken = data["accessToken"];
        final newRefreshToken = data["refreshToken"];

        if (newAccessToken != null) {
          return {
            "accessToken": newAccessToken,
            if (newRefreshToken != null) "refreshToken": newRefreshToken,
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void _handlerDioException(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final serverMessage =
          e.response?.data['message'] ?? e.response?.data['error'];
      if (serverMessage != null) {
        throw serverMessage.toString();
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw 'Connection timeout - Please check your internet';
      case DioExceptionType.sendTimeout:
        throw 'Send timeout - Please try again';
      case DioExceptionType.receiveTimeout:
        throw 'Receive timeout - Server took too long to respond';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        throw 'Server error ($statusCode): Failed to load data';
      case DioExceptionType.cancel:
        throw 'Request was cancelled';
      case DioExceptionType.connectionError:
        throw 'No internet connection';
      default:
        throw 'Failed to load data';
    }
  }
}
