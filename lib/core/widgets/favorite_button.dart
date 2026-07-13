import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

class FavoriteButton extends StatelessWidget {
  final ProductModel product;
  final double size;

  const FavoriteButton({super.key, required this.product, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (_, state) {
        final isFavorite = state.favoriteList.any(
          (element) => element.id == product.id,
        );

        return GestureDetector(
          onTap: () {
            context.read<FavoritesCubit>().toggleFavorite(
              productId: product.id,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite
                      ? 'تمت الإزالة من المفضلات'
                      : 'تمت الإضافة إلى المفضلات',
                ),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: size,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
