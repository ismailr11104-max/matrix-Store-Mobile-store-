import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/product/product_api_service.dart';
import 'package:matrix_app/features/category/category_model/category_model.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

abstract class BaseProductRepository {
  Future<List<CategoryModel>> getCategory();
  Future<List<ProductModel>> getProduct();
}

class ProductRepository extends BaseProductRepository {
  final ProductsApiService productsApiService;
  ProductRepository(this.productsApiService);
  List<ProductModel>? _products;
  List<CategoryModel>? _categories;

  @override
  Future<List<ProductModel>> getProduct() async {
    if (_products != null) {
      return _products!;
    }
    final result = await productsApiService.getProduct(
      ApiServesConfig.products,
    );
    List<ProductModel> products = [];
    if (result is Map && result['products'] is List) {
      products = (result['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else if (result is List) {
      products = result.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Unexpected products format");
    }
    _products = products;
    return products;
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    if (_categories != null) {
      return _categories!;
    }
    final result = await productsApiService.getCategory(
      ApiServesConfig.category,
    );
    if (result is List) {
      final categories = result
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      _categories = categories;

      return categories;
    }
    throw Exception("Unexpected categories format");
  }

  void clearProductCache() {
    _products = null;
  }

  void clearCategoryCache() {
    _categories = null;
  }
}
