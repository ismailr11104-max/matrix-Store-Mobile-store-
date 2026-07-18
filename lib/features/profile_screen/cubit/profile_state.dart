part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final UserModel? userModel;
  final RequestStatus profileStatus;
  final String? errorMessage;

  const ProfileState({
    this.userModel,
    this.profileStatus = RequestStatus.loading,
    this.errorMessage,
  });

  ProfileState copyWith({
    UserModel? userModel,
    RequestStatus? profileStatus,
    String? errorMessage,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      profileStatus: profileStatus ?? this.profileStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userModel, profileStatus, errorMessage];
}
