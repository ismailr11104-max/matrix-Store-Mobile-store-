import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart'; // تأكد من صحة مسار الـ Service
import 'package:matrix_app/features/home/model_prodect/product_model.dart'; // استيراد الـ ProductModel الخاص بك

abstract class BaseCartRepository {
  Future<List<ProductModel>> getCartItems();
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
  Future<List<ProductModel>> getCartItems() async {
    final result = await cartApiService.getCartItems();

    if (result is Map) {
      final cartItemsData = result['items'];

      if (cartItemsData is List) {
        return cartItemsData.map((item) {
          final productJson = item['product'];
          return ProductModel.fromJson(productJson);
        }).toList();
      }
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
