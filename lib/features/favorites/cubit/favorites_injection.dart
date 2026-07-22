import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/date/local_date/favorite_local_date.dart';
import 'package:matrix_app/features/favorites/date/remote_date/favorites_api_serves.dart';
import 'package:matrix_app/features/favorites/repo/favorites_repository.dart';

class FavoritesInjection {
  static FavoritesCubit cubit() {
    return FavoritesCubit(
      FavoritesRepository(FavoritesApiServes(), FavoritesLocalData()),
    )..getFavoritesItems();
  }
}
