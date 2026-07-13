part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final List<ProductModel> favoriteList;
  final RequestStatus requestStatus;
  final String? errorMessage;

  const FavoritesState({
    this.favoriteList = const [],
    this.requestStatus = RequestStatus.loading,
    this.errorMessage,
  });

  FavoritesState copyWith({
    List<ProductModel>? favoriteList,
    RequestStatus? requestStatus,
    String? errorMessage,
  }) {
    return FavoritesState(
      favoriteList: favoriteList ?? this.favoriteList,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [favoriteList, requestStatus, errorMessage];
}
