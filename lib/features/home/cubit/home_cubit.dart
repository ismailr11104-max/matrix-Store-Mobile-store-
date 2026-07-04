import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/core/repo/product_repository.dart';
import 'package:matrix_app/features/category/category_model/category_model.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

part 'home_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.repository) : super(ProductState()) {
    getProductDate();
    getCategoriesDate();
  }
  final BaseProductRepository repository;

  Future<void> getProductDate() async {
    try {
      emit(state.copyWith(productStatus: RequestStatus.loading));
      final product = await repository.getProduct();
      emit(
        state.copyWith(
          productList: product,
          productStatus: RequestStatus.laded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getCategoriesDate() async {
    try {
      emit(state.copyWith(categoryStatus: RequestStatus.loading));

      final category = await repository.getCategory();
      emit(
        state.copyWith(
          categoryList: category,
          categoryStatus: RequestStatus.laded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoryStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
