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

  // حقن الـ Service داخل الـ Repository بنفس نمط الـ Product تماماً
  CartRepository(this.cartApiService);

  // 1. جلب منتجات السلة وتحويلها إلى List من ProductModel مباشرة
  @override
  Future<List<ProductModel>> getCartItems() async {
    final result = await cartApiService.getCartItems();

    // أ- إذا كان السيرفر يعيد القائمة مباشرة
    if (result is List) {
      return result.map((e) => ProductModel.fromJson(e)).toList();
    }
    // ب- إذا كان السيرفر يعيد Map ويحتوي على قائمة المنتجات بداخل مفتاح معين (مثل 'cartItems' أو 'products')
    else if (result is Map) {
      // نبحث عن أي مفتاح يحتوي على قائمة بداخل الـ Map القادم من السيرفر
      final cartData =
          result['cartItems'] ?? result['products'] ?? result['data'];
      if (cartData is List) {
        return cartData.map((e) => ProductModel.fromJson(e)).toList();
      }
    }

    throw Exception("Unexpected data format for Cart");
  }

  // 2. دالة إضافة منتج أو تحديث كميته في السلة
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

  // 3. دالة حذف منتج من السلة عبر الـ ID
  @override
  Future<dynamic> deleteCartItem(int productId) async {
    final result = await cartApiService.deleteCartItem(productId);
    return result;
  }
}
