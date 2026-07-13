import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/features/favorites/date/remote_date/favorites_dio_config.dart';

abstract class BaseFavoritesApiService {
  Future<dynamic> getFavoritesItems();

  Future<dynamic> addFavorites({required int productId});

  Future<dynamic> deleteFavoritesItem(int productId);
  Future<dynamic> toggleFavorite({
    required int productId,
    required bool isFavorite,
  });
}

class FavoritesApiServes extends BaseFavoritesApiService {
  final dio = FavoritesDioConfig.createFavoritesDio();

  @override
  Future<dynamic> deleteFavoritesItem(int productId) async {
    try {
      final response = await dio.delete(ApiServesConfig.deleteFavorite(productId));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data;
      }
      return null;
    } catch (e) {
      throw Exception("Failed To Load Favorites Data");
    }
  }

  @override
  Future<dynamic> getFavoritesItems() async {
    try {
      final response = await dio.get(ApiServesConfig.allFavorite);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Load Favorites Data");
      }
    } catch (e) {
      throw Exception("Failed To Load Favorites Data");
    }
  }

  @override
  Future<dynamic> addFavorites({required int productId}) async {
    try {
      final response = await dio.post(
        ApiServesConfig.addFavorite,
        data: {"productId": productId},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data;
      }
      return null;
    } catch (e) {
      throw Exception("Failed To Load Favorites Data");
    }
  }

  @override
  Future<dynamic> toggleFavorite({
    required int productId,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      return await deleteFavoritesItem(productId);
    } else {
      return await addFavorites(productId: productId);
    }
  }
}
