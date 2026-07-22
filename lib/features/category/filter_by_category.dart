import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/home/components/item_product.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';

class FilterByCategory extends StatelessWidget {
  const FilterByCategory({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryId)),
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.productStatus == RequestStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productStatus == RequestStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? "Error loading products"),
              );
            }

            final products = state.productList
                .where(
                  (product) =>
                      product.categoryId.toLowerCase().trim() ==
                      categoryId.toLowerCase().trim(),
                )
                .toList();

            if (products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return Padding(
              padding: EdgeInsets.all(AppSized.r16),

              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),

                itemCount: products.length,

                itemBuilder: (context, index) {
                  return ItemProduct(productModel: products[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
