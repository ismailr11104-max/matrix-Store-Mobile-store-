import 'package:matrix_app/core/dete_surce/local_dete/cart_local_data.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart';
import 'package:matrix_app/features/cart/cart_model/cart_model.dart';

abstract class BaseCartRepository {
  Future<CartModel> getCartItems();

  Future<void> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  });
  Future<void> deleteCartItem(int productId);
}

class CartRepository extends BaseCartRepository {
  final CartApiService cartApiService;
  final CartLocalData cartLocalData;

  CartRepository(this.cartApiService, this.cartLocalData);

  @override
  Future<CartModel> getCartItems() async {
    try {
      final result = await cartApiService.getCartItems(ApiServesConfig.Cart);
      if (result is Map) {
        final Map<String, dynamic> cartMap = Map<String, dynamic>.from(result);
        final cart = CartModel.fromJson(cartMap);
        await cartLocalData.saveCart(cart);
        return cart;
      } else {
        throw Exception(
          "Unexpected data format for Cart. Expected Map, got ${result.runtimeType}",
        );
      }
    } catch (e) {
      final cachedCart = cartLocalData.getCart();

      if (cachedCart != null) {
        return cachedCart;
      }
      rethrow;
    }
  }

  @override
  Future<void> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  }) async {
    await cartApiService.uploadOrUpdateCart(
      productId: productId,
      quantity: quantity,
    );
  }

  @override
  Future<void> deleteCartItem(int productId) async {
    await cartApiService.deleteCartItem(productId);
  }
}
