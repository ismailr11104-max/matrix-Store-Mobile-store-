import 'package:matrix_app/features/favorites/date/local_date/favorite_local_date.dart';
import 'package:matrix_app/features/favorites/date/remote_date/favorites_api_serves.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

abstract class BaseFavoriteRepository {
  Future<List<ProductModel>> getFavoritesItems();

  Future<void> addFavorites({required int productId});

  Future<void> deleteFavoritesItem(int productId);
  Future<void> toggleFavorite({
    required int productId,
    required bool isFavorite,
  });
}

class FavoritesRepository extends BaseFavoriteRepository {
  final FavoritesApiServes favoritesApiServes;
  final FavoritesLocalData favoritesLocalData;

  FavoritesRepository(this.favoritesApiServes, this.favoritesLocalData);

  @override
  Future<void> addFavorites({required int productId}) async {
    await favoritesApiServes.addFavorites(productId: productId);
    await getFavoritesItems();
  }

  @override
  Future<void> deleteFavoritesItem(int productId) async {
    await favoritesApiServes.deleteFavoritesItem(productId);
    await getFavoritesItems();
  }

  @override
  Future<List<ProductModel>> getFavoritesItems() async {
    try {
      final result = await favoritesApiServes.getFavoritesItems();
      if (result is List) {
        final favorites = result
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        await favoritesLocalData.saveFavorites(favorites);
        return favorites;
      } else {
        throw Exception("Expected List, got ${result.runtimeType}");
      }
    } catch (e) {
      final cachedFavorites = favoritesLocalData.getFavorites();

      if (cachedFavorites.isNotEmpty) {
        return cachedFavorites;
      }
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite({
    required int productId,
    required bool isFavorite,
  }) async {
    await favoritesApiServes.toggleFavorite(
      productId: productId,
      isFavorite: isFavorite,
    );
    await getFavoritesItems();
  }
}
