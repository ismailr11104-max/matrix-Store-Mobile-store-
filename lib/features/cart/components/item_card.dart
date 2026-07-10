import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';

class ItemCard extends StatelessWidget {
   const ItemCard({super.key, required this.cartItem});
  final cartItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSized.w20,
        vertical: AppSized.h12,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: AppSized.w80,
            height: AppSized.h80,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(6),
            child: Image.network(
              cartItem.product.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: AppSized.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.nameEn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppSized.sp14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: AppSized.w12),
                Text(
                  '\$${cartItem.product.price}',
                  style: TextStyle(
                    fontSize: AppSized.sp16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                _showDeleteConfirmation(
                  context,
                  cartItem,
                );
              },
              child: SvgPicture.asset(
                'assets/images/icon_delete.svg',
                width: AppSized.w24,
                height: AppSized.h24,
              ),
            ),
            SizedBox(width: AppSized.w12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSized.w12,
                vertical: AppSized.h8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${cartItem.quantity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSized.sp16,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          ],
          ),
        ],
      ),
    );
  }
   void _showDeleteConfirmation(BuildContext context, final cartItem) {
     showDialog(
       context: context,
       builder: (dialogContext) => AlertDialog(
         backgroundColor: Colors.white,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
         contentPadding: const EdgeInsets.symmetric(
           horizontal: 24,
           vertical: 24,
         ),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             const Text(
               'Delete Item',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Color(0xFF1E293B),
               ),
             ),
             const SizedBox(height: 16),
             SvgPicture.asset(
               'assets/images/icon_delete.svg',
               width: AppSized.w48,
               height: AppSized.h48,
             ),
             const SizedBox(height: 16),
             Text(
               'Are you sure you want to remove "${cartItem.product.nameEn}" from your cart? This action cannot be undone.',
               textAlign: TextAlign.center,
               style: const TextStyle(
                 fontSize: 14,
                 color: Color(0xFF64748B),
                 height: 1.4,
               ),
             ),
             const SizedBox(height: 24),
             Row(
               children: [
                 Expanded(
                   child: OutlinedButton(
                     onPressed: () {
                       context.read<CartCubit>().deleteCartItemDate(
                         cartItem.productId.toInt(),
                       );
                       Navigator.pop(dialogContext);
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(
                             '${cartItem.product.nameEn} removed from cart',
                           ),
                           duration: const Duration(seconds: 2),
                         ),
                       );
                     },
                     child: const Text(
                       'Delete',
                       style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.bold,
                         color: Color(0xFF7E72F2),
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(width: 12),
                 Expanded(
                   child: ElevatedButton(
                     onPressed: () => Navigator.pop(dialogContext),
                     child: const Text(
                       'Cancel',
                       style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ],
         ),
       ),
     );
   }
}
