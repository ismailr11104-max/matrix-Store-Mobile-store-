import 'package:hive_ce_flutter/adapters.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';
import 'package:matrix_app/features/home/model_prodect/product_specs.dart';

class FavoritesLocalData {
  FavoritesLocalData._internal();

  static final FavoritesLocalData _instance = FavoritesLocalData._internal();

  factory FavoritesLocalData() => _instance;

  Box<ProductModel>? _favoritesBox;

  Box<ProductModel> get favoritesBox {
    if (_favoritesBox == null) {
      throw Exception("FavoritesLocalData not initialized");
    }
    return _favoritesBox!;
  }

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ProductModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(ProductSpecsAdapter());
    }

    try {
      _favoritesBox = await Hive.openBox<ProductModel>("favorites_box");
    } catch (e) {
      await Hive.deleteBoxFromDisk("favorites_box");
      _favoritesBox = await Hive.openBox<ProductModel>("favorites_box");
    }
  }

  Future<void> saveFavorites(List<ProductModel> favorites) async {
    await favoritesBox.clear();
    for (var product in favorites) {
      await favoritesBox.put(product.id, product);
    }
  }

  List<ProductModel> getFavorites() {
    return favoritesBox.values.toList();
  }

  Future<void> clearFavorites() async {
    await favoritesBox.clear();
  }
}
