import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/favorites/repo/favorites_repository.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final BaseFavoriteRepository repository;

  FavoritesCubit(this.repository) : super(const FavoritesState()) {
    getFavoritesItems();
  }

  void getFavoritesItems() async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      final favorites = await repository.getFavoritesItems();
      emit(
        state.copyWith(
          favoriteList: favorites,
          requestStatus: RequestStatus.laded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void addFavorites({required int productId}) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      await repository.addFavorites(productId: productId);
      getFavoritesItems();
    } catch (e) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void deleteFavoritesItem(int productId) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      await repository.deleteFavoritesItem(productId);
      getFavoritesItems();
    } catch (e) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleFavorite({required int productId}) async {
    final isAlreadyFavorite = state.favoriteList.any(
      (product) => product.id == productId,
    );
    try {
      await repository.toggleFavorite(
        productId: productId,
        isFavorite: isAlreadyFavorite,
      );
      final favorites = await repository.getFavoritesItems();
      emit(
        state.copyWith(
          favoriteList: favorites,
          requestStatus: RequestStatus.laded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
