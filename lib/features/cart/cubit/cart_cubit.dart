import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';

import '../cart_model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepository repository;

  CartCubit(this.repository) : super(CartState()) {
    getCartData();
  }

  Future<void> getCartData() async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));

      final cartData = await repository.getCartItems();

      emit(
        state.copyWith(
          cartModel: cartData,
          cartStatus: RequestStatus.laded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          cartStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> uploadOrUpdateCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));

      await repository.uploadOrUpdateCart(
        productId: productId,
        quantity: quantity,
      );

      await getCartData();
    } catch (e) {
      emit(
        state.copyWith(
          cartStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteCartItem(int productId) async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));

      await repository.deleteCartItem(productId);

      await getCartData();
    } catch (e) {
      emit(
        state.copyWith(
          cartStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void incrementQuantity() {
    emit(state.copyWith(selectedQuantity: state.selectedQuantity + 1));
  }

  void decrementQuantity() {
    if (state.selectedQuantity > 1) {
      emit(state.copyWith(selectedQuantity: state.selectedQuantity - 1));
    }
  }
}
