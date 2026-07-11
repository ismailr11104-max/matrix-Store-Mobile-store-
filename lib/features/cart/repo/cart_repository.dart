import 'package:matrix_app/core/dete_surce/local_dete/cart_local_data.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart';
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
  final CartLocalData cartLocalData;

  CartRepository(this.cartApiService, this.cartLocalData);

  @override
  Future<CartModel> getCartItems() async {
    try {
      final result = await cartApiService.getCartItems();
      if (result is Map) {
        final Map<String, dynamic> targetMap = Map<String, dynamic>.from(
          result,
        );
        final cart = CartModel.fromJson(targetMap);
        await cartLocalData.saveCart(cart);
        return cart;
      }
      throw Exception(
        "Unexpected data format for Cart. Expected Map, got ${result.runtimeType}",
      );
    } catch (e) {
      print("Cart Repository Error: $e");
      final cachedCart = cartLocalData.getCart();

      if (cachedCart != null) {
        return cachedCart;
      }
      rethrow;
    }
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
    await getCartItems();
    return result;
  }

  @override
  Future<dynamic> deleteCartItem(int productId) async {
    final result = await cartApiService.deleteCartItem(productId);
    await getCartItems();
    return result;
  }
}
