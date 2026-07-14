import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/features/home/components/item_product.dart';
import 'package:matrix_app/features/search/cubit/search_cubit.dart';
import 'package:matrix_app/features/search/date/remote_date/search_api_serves.dart';
import 'package:matrix_app/features/search/repo/search_repository.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchRepository(SearchApiServes())),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _key,
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (blocContext, state) {
                return Padding(
                  padding: EdgeInsets.all(AppSized.w16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new_sharp),
                          ),
                          SizedBox(width: AppSized.w6),
                          Expanded(
                            child: Container(
                              height: AppSized.h56,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7F7F9),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: TextFormField(
                                controller: searchController,
                                onChanged: (value) {
                                  blocContext
                                      .read<SearchCubit>()
                                      .getSearchItems(q: value);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search products',
                                  hintStyle: TextStyle(
                                    color: Color(0x8A000000),
                                    fontSize: AppSized.sp16,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: Color(0x8A000000),
                                    size: AppSized.sp24,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: AppSized.h14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: state.searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemProduct(
                              productModel: state.searchList[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
