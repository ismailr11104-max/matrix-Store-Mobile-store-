import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 3)
class CartItemModel extends Equatable {
  @HiveField(0)
  final num productId;
  @HiveField(1)
  final num quantity;
  @HiveField(2)
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
