import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/home/components/item_product.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';

class ProductAll extends StatelessWidget {
  const ProductAll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        switch (state.productStatus) {
          case RequestStatus.initial:
          case RequestStatus.loading:
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          case RequestStatus.error:
            return SliverToBoxAdapter(
              child: Center(child: Text('Error loading products')),
            );
          case RequestStatus.laded:
            return SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: state.productList.take(16).length,
              itemBuilder: (BuildContext context, int index) {
                final productModel = state.productList[index];
                return ItemProduct(productModel: productModel);
              },
            );
        }
      },
    );
  }
}
