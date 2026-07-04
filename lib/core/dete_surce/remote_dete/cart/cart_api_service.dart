import 'package:dio/dio.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';

import 'cart_dio_config.dart'; // استيراد إعدادات الـ Dio الخاصة بالسلة

abstract class BaseCartApiService {
  Future<dynamic> getCartItems();
  Future<dynamic> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  });
  Future<dynamic> deleteCartItem(int productId);
}

class CartApiService extends BaseCartApiService {
  // استخدام الـ configuration الموحد والنظيف الخاص بالـ Cart
  final dio = CartDioConfig.cartDioConfig();

  // 1. دالة جلب منتجات السلة (GET)
  @override
  Future<dynamic> getCartItems() async {
    try {
      final response = await dio.get(ApiServesConfig.Cart);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Load Cart Data");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      throw Exception("Failed To Load Cart Data");
    }
  }

  // 2. دالة إضافة أو تحديث كمية منتج في السلة (POST)
  // تأخذ المعطيات كـ Body بصيغة {"productId": x, "quantity": y} كما طلبت
  @override
  Future<dynamic> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await dio.post(
        ApiServesConfig.Cart,
        data: {"productId": productId, "quantity": quantity},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Upload Item To Cart");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      throw Exception("Failed To Upload Item To Cart");
    }
  }

  // 3. دالة حذف منتج من السلة (DELETE)
  // ترسل الـ ID مباشرة في الـ URL ديناميكياً
  @override
  Future<dynamic> deleteCartItem(int productId) async {
    try {
      final response = await dio.delete(ApiServesConfig.deleteCart(productId));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Delete Item From Cart");
      }
    } on DioException catch (e) {
      _handlerDioException(e);
    } catch (e) {
      throw Exception("Failed To Delete Item From Cart");
    }
  }

  // ميثود معالجة أخطاء الـ Dio الموحدة في مشروعك
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
        final message = e.response?.data?['message'] ?? 'Cart operation failed';
        throw Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        throw Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        throw Exception('No internet connection - Please verify your network');
      default:
        throw Exception('Unexpected error occurred');
    }
  }
}
