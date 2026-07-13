import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/cart/components/error_no_internet.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/home/components/item_product.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Favorites",
          style: TextStyle(color: Colors.black, fontSize: AppSized.sp16),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF2D2D2D),
            size: AppSized.r20,
          ),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          switch (state.requestStatus) {
            case RequestStatus.initial:
            case RequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF7E72F2)),
              );
            case RequestStatus.error:
              return Center(child: const ErrorNoInternet());
            case RequestStatus.laded:
              if (state.favoriteList.isEmpty) {
                return const Center(
                  child: Text(
                    "No favorites yet.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }
              return GridView.builder(
                padding: EdgeInsets.all(AppSized.r16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.favoriteList.length,
                itemBuilder: (listViewContext, index) {
                  final favorite = state.favoriteList[index];
                  return ItemProduct(productModel: favorite);
                },
              );
          }
        },
      ),
    );
  }
}
