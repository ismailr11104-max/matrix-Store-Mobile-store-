import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart'; // مسار الـ Service الخاص بك
import 'package:matrix_app/features/cart/cart_model/cart_model.dart';

abstract class BaseCartRepository {
  Future<CartModel> getCartItems();

  Future<dynamic> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  });
  Future<dynamic> deleteCartItem(int productId);
}

class CartRepository extends BaseCartRepository {
  final CartApiService cartApiService;
  CartRepository(this.cartApiService);

  @override
  Future<CartModel> getCartItems() async {
    final result = await cartApiService.getCartItems();

    if (result is Map<String, dynamic>) {
      return CartModel.fromJson(result);
    }

    throw Exception("Unexpected data format for Cart");
  }

  @override
  Future<dynamic> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  }) async {
    final result = await cartApiService.uploadOrUpdateCart(
      productId: productId,
      quantity: quantity,
    );
    return result;
  }

  @override
  Future<dynamic> deleteCartItem(int productId) async {
    final result = await cartApiService.deleteCartItem(productId);
    return result;
  }
}
