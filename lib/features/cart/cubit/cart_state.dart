part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<ProductModel> cartList;
  final RequestStatus cartStatus;
  final num quantity; // لعداد الكمية في شاشة التفاصيل
  final String? errorMessage;

  const CartState({
    this.cartList = const [],
    this.cartStatus = RequestStatus.loading,
    this.quantity = 1,
    this.errorMessage,
  });

  CartState copyWith({
    List<ProductModel>? cartList,
    RequestStatus? cartStatus,
    num? quantity,
    String? errorMessage,
  }) {
    return CartState(
      cartList: cartList ?? this.cartList,
      cartStatus: cartStatus ?? this.cartStatus,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cartList, cartStatus, quantity, errorMessage];
}
