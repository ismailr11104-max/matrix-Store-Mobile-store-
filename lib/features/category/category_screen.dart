import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/category/filter_by_category.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_injection.dart';
import 'package:matrix_app/features/home/cubit/home_cubit.dart';
import 'package:matrix_app/features/home/cubit/product_injection.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ProductInjection.provider(),
        BlocProvider(create: (context) => FavoritesInjection.cubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Categories")),
        body: SafeArea(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state.categoryStatus == RequestStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.categoryStatus == RequestStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? "Error loading categories"),
                );
              }
              if (state.categoryList.isEmpty) {
                return const Center(child: Text("No categories found"));
              }
              return Padding(
                padding: EdgeInsets.all(AppSized.r16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: state.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = state.categoryList[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        // 2️⃣ الآن يمكنك قراءته بدون أي مشاكل
                        final productCubit = context.read<ProductCubit>();
                        final favoritesCubit = context.read<FavoritesCubit>();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: productCubit),
                                BlocProvider.value(value: favoritesCubit),
                              ],
                              child: FilterByCategory(categoryId: category.id),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: AppSized.w120,
                            height: AppSized.h120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xffB3B5FC), Color(0xffE6E7FF)],
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                category.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSized.h8),
                          Text(
                            category.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppSized.sp16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4A4A4A),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
