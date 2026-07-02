part of 'home_cubit.dart';

class ProductState extends Equatable {
  final List<ProductModel> productList;
  final List<CategoryModel> categoryList;
  final RequestStatus productStatus;
  final RequestStatus categoryStatus;
  final String? errorMessage;

  ProductState({
    this.productList = const [],
    this.categoryList = const [],
    this.productStatus = RequestStatus.loading,
    this.categoryStatus = RequestStatus.loading,
    this.errorMessage,
  });

  ProductState copyWith({
    List<ProductModel>? productList,
    List<CategoryModel>? categoryList,
    RequestStatus? productStatus,
    RequestStatus? categoryStatus,
    String? errorMessage,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      categoryList: categoryList ?? this.categoryList,
      productStatus: productStatus ?? this.productStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    productList,
    categoryList,
    productStatus,
    categoryStatus,
    errorMessage,
  ];
}
