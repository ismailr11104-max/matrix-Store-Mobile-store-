import 'package:matrix_app/core/dete_surce/local_dete/cart_local_data.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';

class CartInjection {

  static CartCubit getCubit(){

    return CartCubit(
      CartRepository(
        CartApiService(),
        CartLocalData(),
      ),
    );

  }
}
