import 'package:hive_ce_flutter/adapters.dart';
import 'package:matrix_app/core/constants/constants.dart';
import 'package:matrix_app/features/cart/cart_model/cart_item_model.dart';
import 'package:matrix_app/features/cart/cart_model/cart_model.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';
import 'package:matrix_app/features/home/model_prodect/product_specs.dart';

class CartLocalData {
  CartLocalData._internal();

  static final CartLocalData _instance = CartLocalData._internal();

  factory CartLocalData() => _instance;

  Box<CartModel>? _cartBox;

  Box<CartModel> get cartBox {
    if (_cartBox == null) {
      throw Exception("CartLocalData not initialized");
    }

    return _cartBox!;
  }

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CartModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(CartItemModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ProductModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(ProductSpecsAdapter());
    }
    try {
      _cartBox = await Hive.openBox<CartModel>(Constants.cartBox);
    } catch (e) {
      await Hive.deleteBoxFromDisk(Constants.cartBox);
      _cartBox = await Hive.openBox<CartModel>(Constants.cartBox);
    }
  }

  Future<void> saveCart(CartModel cart) async {
    await cartBox.put("cart", cart);
  }

  CartModel? getCart() {
    return cartBox.get("cart");
  }

  Future<void> clearCart() async {
    await cartBox.clear();
  }
}
