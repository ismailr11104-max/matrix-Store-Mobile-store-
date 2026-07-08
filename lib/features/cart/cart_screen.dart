import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/cart/cart_api_service.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';
import 'package:matrix_app/features/cart/repo/cart_repository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartRepository(CartApiService()), 1),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F9FE),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(
              fontSize: AppSized.sp16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, color: Color(0xFF7E72F2)),
            ),
            SizedBox(width: AppSized.w8),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            // استخدام الـ switch لمعالجة الحالات بناءً على طلبك ومثل ملف الـ ProductAll
            switch (state.cartStatus) {
              case RequestStatus.initial:
              case RequestStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF7E72F2)),
                );

              case RequestStatus.error:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Error loading cart items',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                );

              case RequestStatus.laded:
                // إذا كانت القائمة فارغة بعد التحميل الناجح
                if (state.cartList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your cart is empty!",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartList.length,
                        padding: EdgeInsets.only(bottom: AppSized.h16),
                        itemBuilder: (BuildContext context, int index) {
                          final cartItem = state.cartList[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: AppSized.w16,
                              vertical: AppSized.h8,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white70,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // صورة المنتج
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8F9FA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Image.network(
                                    cartItem.imageUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey,
                                            ),
                                  ),
                                ),
                                SizedBox(width: AppSized.w12),
                                // تفاصيل المنتج
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.nameEn,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppSized.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '\$${cartItem.price}',
                                        style: TextStyle(
                                          fontSize: AppSized.sp16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF7E72F2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // أزرار التحكم بالكمية والحذف الجانبية
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CartCubit>()
                                            .deleteCartItemDate(cartItem.id);
                                      },
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8F9FA),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          _quantityButton(
                                            icon: Icons.remove,
                                            onTap: () => context
                                                .read<CartCubit>()
                                                .decrementQuantity(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              '${state.quantity}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          _quantityButton(
                                            icon: Icons.add,
                                            onTap: () => context
                                                .read<CartCubit>()
                                                .incrementQuantity(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // البوكس السفلي لعرض الـ Total Price والـ Checkout
                    Container(
                      padding: EdgeInsets.only(
                        left: AppSized.w24,
                        right: AppSized.w24,
                        top: AppSized.h20,
                        bottom: AppSized.h24,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
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
                                'Total Price:',
                                style: TextStyle(
                                  fontSize: AppSized.sp16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                // ملاحظة: إذا كان الـ Model أو الـ State يحتوي على totalPrice من السيرفر مباشرة،
                                // استبدل هذا المتغير بـ state.totalPrice ليعرض القيمة القادمة من الباك إيند فوراً.
                                '\$${state.cartList.fold(0.0, (sum, item) => sum + (double.tryParse(item.price.toString()) ?? 0.0)).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: AppSized.sp24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7E72F2),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSized.h20),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                // دالة الدفع أو الـ Checkout
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7E72F2),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Proceed to Checkout',
                                style: TextStyle(
                                  fontSize: AppSized.sp16,
                                  fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: Colors.black54),
      ),
    );
  }
}
