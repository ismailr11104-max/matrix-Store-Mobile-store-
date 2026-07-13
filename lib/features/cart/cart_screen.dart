import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/components/empty_cart_widget.dart';
import 'package:matrix_app/features/cart/components/error_no_internet.dart';
import 'package:matrix_app/features/cart/components/item_card.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';
import 'package:matrix_app/features/favorites/favorites_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontSize: AppSized.sp16),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          switch (state.cartStatus) {
            case RequestStatus.initial:
            case RequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF7E72F2)),
              );

            case RequestStatus.error:
              return Center(child: const ErrorNoInternet());

            case RequestStatus.laded:
              if (state.cartModel == null || state.cartModel!.items.isEmpty) {
                return Center(child: EmptyCartWidget());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSized.w20,
                      vertical: AppSized.h16,
                    ),
                    child: Text(
                      "Products (${state.cartModel!.items.length})",
                      style: TextStyle(
                        fontSize: AppSized.sp16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartModel!.items.length,
                      padding: EdgeInsets.only(bottom: AppSized.h16),
                      itemBuilder: (BuildContext context, int index) {
                        final cartItem = state.cartModel!.items[index];
                        return ItemCard(cartItem: cartItem);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: AppSized.w24,
                      right: AppSized.w24,
                      top: AppSized.h24,
                      bottom: AppSized.h24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 20,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total (${state.cartModel!.items.length} items)',
                              style: TextStyle(
                                fontSize: AppSized.sp14,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '\$${state.cartModel!.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: AppSized.sp20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7E72F2),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSized.h24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7E72F2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: AppSized.sp16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
