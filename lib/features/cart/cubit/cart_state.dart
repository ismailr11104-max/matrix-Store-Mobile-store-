part of 'cart_cubit.dart';

class CartState extends Equatable {
  final CartModel? cartModel;
  final RequestStatus cartStatus;
  final String? errorMessage;
  final int selectedQuantity;

  const CartState({
    this.cartModel,
    this.cartStatus = RequestStatus.loading,
    this.errorMessage,
    this.selectedQuantity = 1,
  });

  CartState copyWith({
    CartModel? cartModel,
    RequestStatus? cartStatus,
    int? selectedQuantity,
    String? errorMessage,
  }) {
    return CartState(
      cartModel: cartModel ?? this.cartModel,
      cartStatus: cartStatus ?? this.cartStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }

  @override
  List<Object?> get props => [
    cartModel,
    cartStatus,
    errorMessage,
    selectedQuantity,
  ];
}
