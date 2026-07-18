import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/product/product_dio_config.dart';

abstract class BaseApiService {
  Future<dynamic> getCategory(String endpoint, {Map<String, dynamic>? body});
  Future<dynamic> getProduct(String endpoint, {Map<String, dynamic>? body});
}

class ProductsApiService extends BaseApiService {
  final dio = ProductDioConfig.productDioConfig();

  @override
  Future<dynamic> getCategory(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.get(endpoint, data: body);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Load Data");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      throw Exception("Failed To Lode Data");
    }
  }

  @override
  Future<dynamic>getProduct(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.get(endpoint, data: body);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Load Data");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      throw Exception("Failed To Lode Data");
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
        final message = e.response?.data?['message'] ?? 'Failed to load news';
        throw Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        throw Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        throw Exception('No internet connection');
      default:
        throw Exception('Failed to load news');
    }
  }
}
