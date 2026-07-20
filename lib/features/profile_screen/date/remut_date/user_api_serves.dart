import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/auth/auth_dio_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/interceptor/auth_interceptor.dart';

abstract class BaseApiService {
  Future<dynamic> getProfile(String endpoint, {Map<String, dynamic>? body});
  Future<dynamic> editProfile(String endpoint, {Map<String, dynamic>? body});
  Future<dynamic> deleteProfile(String endpoint); // إضافة دالة الحذف
}

class UserApiServes extends BaseApiService {
  final Dio dio = AuthDioConfig.authCreateDio()
    ..interceptors.add(AuthInterceptor());
  @override
  Future<dynamic> getProfile(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.get(ApiServesConfig.authMy);
      final responseBody = response.data as Map<String, dynamic>;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Failed To Load Data");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
      rethrow;
    } catch (e) {
      throw Exception("Failed To Load Data");
    }
  }

  @override
  Future<dynamic> editProfile(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(ApiServesConfig.authMy, data: body);
      final responseBody = response.data as Map<String, dynamic>;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Failed To Update Profile");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
      rethrow;
    } catch (e) {
      throw Exception("Failed To Update Profile");
    }
  }

  @override
  Future<dynamic> deleteProfile(String endpoint) async {
    try {
      final response = await dio.delete(ApiServesConfig.authMy);
      final responseBody = response.data as Map<String, dynamic>;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Failed To Delete Profile");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
      rethrow;
    } catch (e) {
      throw Exception("Failed To Delete Profile");
    }
  }
}

void _handlerDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw Exception('Connection timeout - Please check your internet');
    case DioExceptionType.sendTimeout:
      throw Exception('Send timeout - Please try again');
    case DioExceptionType.receiveTimeout:
      throw Exception('Receive timeout - Server took too long to respond');
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message =
          e.response?.data?['message'] ?? 'Failed to complete request';
      throw Exception('Server error ($statusCode): $message');
    case DioExceptionType.cancel:
      throw Exception('Request was cancelled');
    case DioExceptionType.connectionError:
      throw Exception('No internet connection');
    default:
      throw Exception('Something went wrong');
  }
}
