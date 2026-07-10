import 'package:equatable/equatable.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart'; // المسار الخاص بك

class CartItemModel extends Equatable {
  final num productId;
  final num quantity;
  final ProductModel product;

  const CartItemModel({
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? 0,
      quantity: json['quantity'] ?? 0,
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  @override
  List<Object?> get props => [productId, quantity, product];
}
