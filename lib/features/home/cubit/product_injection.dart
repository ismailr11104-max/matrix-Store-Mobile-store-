import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/product/product_api_service.dart';
import 'package:matrix_app/features/category/repo/product_repository.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';

class ProductInjection {
  static BlocProvider<ProductCubit> provider() {
    return BlocProvider(
      create: (_) => ProductCubit(ProductRepository(ProductsApiService()))
        ..getProductDate()
        ..getCategoriesDate(),
    );
  }
}
