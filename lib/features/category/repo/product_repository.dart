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

  @override
  Future<List<CategoryModel>> getCategory() async {
    final result = await productsApiService.getCategory(
      ApiServesConfig.category,
    );
    if (result is List) {
      return result.map((e) => CategoryModel.fromJson(e)).toList();
    }
    throw Exception("Unexpected data format");
  }

  @override
  Future<List<ProductModel>> getProduct() async {
    final result = await productsApiService.getProduct(
      ApiServesConfig.products,
    );
    if (result is Map && result.containsKey('products')) {
      final productsData = result['products'];
      if (productsData is List) {
        return productsData.map((e) => ProductModel.fromJson(e)).toList();
      }
    } else if (result is List) {
      return result.map((e) => ProductModel.fromJson(e)).toList();
    }
    throw Exception("Unexpected data format");
  }
}
