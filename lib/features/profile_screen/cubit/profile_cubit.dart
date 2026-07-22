import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/core/user_model/user_model.dart';
import 'package:matrix_app/features/profile_screen/rope/profile_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final BaseUserRepository repository;

  ProfileCubit(this.repository) : super(ProfileState()) {
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    if (state.userModel == null) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.loading,
          errorMessage: null,
        ),
      );
    }
    try {
      var user = await repository.getProfile();
      final localUser = UserRepository().getUser();
      if (localUser?.imageUser != null) {
        user = user.copyWith(imageUser: localUser!.imageUser);
      }

      state.userNameController.text = user.name ?? '';
      state.emailController.text = user.email ?? '';
      state.phoneController.text = user.phone ?? '';
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

  Future<void> editUserProfile() async {
    if (state.formKey.currentState?.validate() ?? false) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.loading,
          errorMessage: null,
        ),
      );
      try {
        final updatedUser = await repository.editProfile(
          name: state.userNameController.text.trim(),
          phone: state.phoneController.text.trim(),
          email: state.emailController.text.trim(),
        );

        state.userNameController.text = updatedUser.name ?? '';
        state.emailController.text = updatedUser.email ?? '';
        state.phoneController.text = updatedUser.phone ?? '';
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
  }

  void savaImage(XFile file) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final newImage = await File(
        file.path,
      ).copy('${appDir.path}/${file.name}');

      await UserRepository().updateUser(imageUser: newImage.path);
      final updatedUser = UserRepository().getUser();
      if (updatedUser != null) {
        emit(
          state.copyWith(
            userModel: updatedUser,
            profileStatus: RequestStatus.laded,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: RequestStatus.error,
          errorMessage: "Failed to save image: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> deleteUserProfile() async {
    emit(
      state.copyWith(profileStatus: RequestStatus.loading, errorMessage: null),
    );
    try {
      await repository.deleteProfile();
      state.userNameController.clear();
      state.emailController.clear();
      state.phoneController.clear();
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

  @override
  Future<void> close() {
    state.userNameController.dispose();
    state.emailController.dispose();
    state.phoneController.dispose();
    return super.close();
  }
}
