import 'package:equatable/equatable.dart';

import 'cart_item_model.dart';

class CartModel extends Equatable {
  final List<CartItemModel> items;
  final num totalItems;
  final num totalPrice;

  const CartModel({
    required this.items,
    required this.totalItems,
    required this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items:
          (json['items'] as List?)
              ?.map((item) => CartItemModel.fromJson(item))
              .toList() ??
          [],
      totalItems: json['totalItems'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
      'totalPrice': totalPrice,
    };
  }

  @override
  List<Object?> get props => [items, totalItems, totalPrice];
}
