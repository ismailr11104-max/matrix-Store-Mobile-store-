part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<ProductModel> searchList;
  final RequestStatus requestStatus;
  final String? errorMessage;

  const SearchState({
    this.searchList = const [],
    this.requestStatus = RequestStatus.initial,
    this.errorMessage,
  });

  SearchState copyWith({
    List<ProductModel>? searchList,
    RequestStatus? requestStatus,
    String? errorMessage,
  }) {
    return SearchState(
      searchList: searchList ?? this.searchList,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [searchList, requestStatus, errorMessage];
}
