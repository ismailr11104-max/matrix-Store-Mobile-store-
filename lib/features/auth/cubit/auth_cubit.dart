import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/core/user_model/user_model.dart';
import 'package:matrix_app/features/auth/repo/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());
  AuthRepository authRepository;

  Future<void> sign_in(String email, String password) async {
    try {
      emit(
        state.copyWith(authStatus: RequestStatus.loading, errorMessage: null),
      );
      final userModel = await authRepository.sign_in(
        email: email,
        password: password,
      );
      if (userModel != null) {
        emit(
          state.copyWith(authStatus: RequestStatus.laded, userModel: userModel),
        );
        // await PrefsManager().setBool("is_logged_in", true);
      }
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(authStatus: RequestStatus.loading, errorMessage: null),
      );

      await authRepository.signUp(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      emit(state.copyWith(authStatus: RequestStatus.laded));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
