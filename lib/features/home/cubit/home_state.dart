part of 'home_cubit.dart';

class ProductState extends Equatable {
  final List<ProductModel> productList;
  final List<ProductModel> filteredProducts;
  final List<CategoryModel> categoryList;
  final String? selectedCategory;
  final RequestStatus productStatus;
  final RequestStatus categoryStatus;
  final String? errorMessage;
  const ProductState({
    this.productList = const [],
    this.filteredProducts = const [],
    this.categoryList = const [],

    this.selectedCategory,

    this.productStatus = RequestStatus.initial,
    this.categoryStatus = RequestStatus.initial,

    this.errorMessage,
  });

  ProductState copyWith({
    List<ProductModel>? productList,
    List<ProductModel>? filteredProducts,
    List<CategoryModel>? categoryList,
    String? selectedCategory,
    RequestStatus? productStatus,
    RequestStatus? categoryStatus,
    String? errorMessage,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categoryList: categoryList ?? this.categoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      productStatus: productStatus ?? this.productStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    productList,
    filteredProducts,
    categoryList,
    selectedCategory,
    productStatus,
    categoryStatus,
    errorMessage,
  ];
}
