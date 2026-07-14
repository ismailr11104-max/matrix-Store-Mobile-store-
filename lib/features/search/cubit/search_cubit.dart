import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/home/model_prodect/product_model.dart';
import 'package:matrix_app/features/search/repo/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BaseSearchRepository repository;
  SearchCubit(this.repository) : super(const SearchState());

  void getSearchItems({String? q}) async {
    if (q == null || q.trim().isEmpty) {
      emit(
        state.copyWith(
          searchList: const [],
          requestStatus: RequestStatus.initial,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(requestStatus: RequestStatus.loading, errorMessage: null),
    );

    try {
      final result = await repository.getSearchItem(q: q);
      emit(
        state.copyWith(searchList: result, requestStatus: RequestStatus.laded),
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
