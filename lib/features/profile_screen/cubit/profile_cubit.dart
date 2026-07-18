import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/core/user_model/user_model.dart';
import 'package:matrix_app/features/profile_screen/rope/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final BaseUserRepository repository;

  ProfileCubit(this.repository) : super(const ProfileState()) {
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    emit(
      state.copyWith(profileStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      final user = await repository.getProfile();
      emit(state.copyWith(userModel: user, profileStatus: RequestStatus.laded));
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // دالة تعديل البروفايل
  Future<void> editUserProfile({
    required String name,
    required String phone,
  }) async {
    emit(
      state.copyWith(profileStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      final updatedUser = await repository.editProfile(
        name: name,
        phone: phone,
        email: '',
      );
      emit(
        state.copyWith(
          userModel: updatedUser,
          profileStatus: RequestStatus.laded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // دالة حذف البروفايل
  Future<void> deleteUserProfile() async {
    emit(
      state.copyWith(profileStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      await repository.deleteProfile();
      emit(state.copyWith(profileStatus: RequestStatus.laded, userModel: null));
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
