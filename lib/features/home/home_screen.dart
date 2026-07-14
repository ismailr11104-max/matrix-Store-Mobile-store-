import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/product/product_api_service.dart';
import 'package:matrix_app/features/category/repo/product_repository.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/date/local_date/favorite_local_date.dart';
import 'package:matrix_app/features/favorites/date/remote_date/favorites_api_serves.dart';
import 'package:matrix_app/features/favorites/repo/favorites_repository.dart';
import 'package:matrix_app/features/home/components/categories_list.dart';
import 'package:matrix_app/features/home/components/image_promo_carousel.dart';
import 'package:matrix_app/features/home/components/product_all.dart';
import 'package:matrix_app/features/home/components/hader_page.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductCubit(ProductRepository(ProductsApiService()))
                ..getProductDate(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(
            FavoritesRepository(FavoritesApiServes(), FavoritesLocalData()),
          ),
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
            const Search(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ImagePromoCarousel(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const CategoriesList(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const ProductAll(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
