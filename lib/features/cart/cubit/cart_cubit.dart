import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/cart_model/cart_model.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepository repository;

  CartCubit(this.repository, num initialQuantity)
    : super(CartState(quantity: initialQuantity)) {
    getCartDate();
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  Future<void> getCartDate() async {
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

  Future<void> uploadOrUpdateCartDate(int productId) async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));
      await repository.uploadOrUpdateCart(
        productId: productId,
        quantity: state.quantity.toInt(),
      );

      getCartDate();
    } catch (e) {
      emit(
        state.copyWith(
          cartStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteCartItemDate(int productId) async {
    try {
      if (state.cartModel == null) return;

      emit(state.copyWith(cartStatus: RequestStatus.loading));
      await repository.deleteCartItem(productId);

      final updatedItems = state.cartModel!.items
          .where((element) => element.productId != productId)
          .toList();

      num newTotalPrice = 0;
      num newTotalItems = 0;
      for (var item in updatedItems) {
        newTotalPrice +=
            (item.product.price *
            item.quantity); // حساب السعر بناءً على السعر الفعلي والكمية[cite: 3]
        newTotalItems += item.quantity;
      }

      final updatedCartModel = CartModel(
        items: updatedItems,
        totalItems: newTotalItems,
        totalPrice: newTotalPrice,
      );

      emit(
        state.copyWith(
          cartModel: updatedCartModel,
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
}
