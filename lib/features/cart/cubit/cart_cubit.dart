import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepository repository;

  // استقبال الـ Repository وتعيين قيمة الكمية الابتدائية للعداد
  CartCubit(this.repository, num initialQuantity)
    : super(CartState(quantity: initialQuantity)) {
    getCartDate(); // استدعاء تلقائي لجلب بيانات السلة عند إنشاء الكيوبيت
  }

  // التحكم في عداد الكمية داخل التطبيق
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
      final cartItems = await repository.getCartItems();
      emit(
        state.copyWith(
          cartList: cartItems,
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

  // 2️⃣ دالة إضافة منتج أو تحديث كميته في السلة (POST)
  Future<void> uploadOrUpdateCartDate(int productId) async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));
      await repository.uploadOrUpdateCart(
        productId: productId,
        quantity: state.quantity.toInt(),
      );

      // بعد الإضافة الناجحة نقوم بإعادة تحديث وجلب بيانات السلة تلقائياً
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

  // 3️⃣ دالة حذف منتج من السلة (DELETE)
  Future<void> deleteCartItemDate(int productId) async {
    try {
      emit(state.copyWith(cartStatus: RequestStatus.loading));
      await repository.deleteCartItem(productId);

      // تحديث قائمة السلة المعروضة في التطبيق فوراً بدون عمل ريلود للشاشة
      final updatedList = state.cartList
          .where((element) => element.id != productId)
          .toList();
      emit(
        state.copyWith(
          cartList: updatedList,
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
