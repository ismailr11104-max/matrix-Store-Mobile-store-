import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/local_dete/cart_local_data.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart';
import 'package:matrix_app/core/widgets/favorite_button.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/date/local_date/favorite_local_date.dart';
import 'package:matrix_app/features/favorites/date/remote_date/favorites_api_serves.dart';
import 'package:matrix_app/features/favorites/repo/favorites_repository.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CartCubit(CartRepository(CartApiService(), CartLocalData()), 1),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(
            FavoritesRepository(FavoritesApiServes(), FavoritesLocalData()),
          ),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final controller = context.read<CartCubit>();
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FE),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF8F9FE),
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF2D2D2D),
                  size: AppSized.r20,
                ),
              ),
              actions: [
                FavoriteButton(product: productModel, size: AppSized.r20),
                SizedBox(width: AppSized.w8),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSized.w16,
                vertical: AppSized.h8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: AppSized.h330,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSized.r24),
                        child: Image.network(
                          productModel.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSized.h24),
                  Text(
                    productModel.nameEn,
                    style: TextStyle(
                      fontSize: AppSized.sp24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: AppSized.h12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '\$${productModel.price}',
                        style: TextStyle(
                          fontSize: AppSized.sp28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7E72F2),
                        ),
                      ),
                      SizedBox(width: AppSized.w12),
                      Text(
                        '\$${productModel.originalPrice}',
                        style: TextStyle(
                          fontSize: AppSized.sp16,
                          color: Color(0xFFD1D1D6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSized.h16),
                  Text(
                    productModel.descriptionEn,
                    style: TextStyle(
                      fontSize: AppSized.sp14,
                      height: AppSized.h2,
                      color: Color(0xFF7E7E7E),
                    ),
                  ),
                  SizedBox(height: AppSized.h32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'QUANTITY',
                        style: TextStyle(
                          fontSize: AppSized.sp12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(AppSized.r20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: AppSized.w32,
                              height: AppSized.h42,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    controller.decrementQuantity();
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSized.w16,
                              ),
                              child: BlocBuilder<CartCubit, CartState>(
                                buildWhen: (previous, current) =>
                                    previous.quantity != current.quantity,
                                builder: (context, state) {
                                  // ✨ تم الإصلاح: الآن يقرأ من الـ state المتغيرة وليس الموديل الثابت
                                  return Text(
                                    '${state.quantity}',
                                    style: TextStyle(
                                      fontSize: AppSized.sp16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: AppSized.w32,
                              height: AppSized.h42,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    controller.incrementQuantity();
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: AppSized.h56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.uploadOrUpdateCartDate(productModel.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Product added to cart successfully!',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: AppSized.r20,
                      ),
                      label: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: AppSized.sp14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7E72F2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSized.r16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
