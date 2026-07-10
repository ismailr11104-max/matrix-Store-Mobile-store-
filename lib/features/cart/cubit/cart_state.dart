part of 'cart_cubit.dart';

class CartState extends Equatable {
  final CartModel? cartModel;
  final RequestStatus cartStatus;
  final num quantity;
  final String? errorMessage;

  const CartState({
    this.cartModel,
    this.cartStatus = RequestStatus.loading,
    this.quantity = 1,
    this.errorMessage,
  });

  CartState copyWith({
    CartModel? cartModel,
    RequestStatus? cartStatus,
    num? quantity,
    String? errorMessage,
  }) {
    return CartState(
      cartModel: cartModel ?? this.cartModel,
      cartStatus: cartStatus ?? this.cartStatus,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cartModel, cartStatus, quantity, errorMessage];
}
