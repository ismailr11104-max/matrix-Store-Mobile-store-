import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/product/product_api_service.dart';
import 'package:matrix_app/features/category/repo/product_repository.dart';
import 'package:matrix_app/features/home/components/categories_list.dart';
import 'package:matrix_app/features/home/components/image_promo_carousel.dart';
import 'package:matrix_app/features/home/components/product_all.dart';
import 'package:matrix_app/features/home/components/search.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(ProductRepository(ProductsApiService()))
            ..getProductDate(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 64)),
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
