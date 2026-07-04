part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String? errorMessage;
  final RequestStatus authStatus;
  final UserModel? userModel;

  const AuthState({
    this.errorMessage,
    this.authStatus = RequestStatus.initial,
    this.userModel,
  });

  AuthState copyWith({
    String? errorMessage,
    RequestStatus? authStatus,
    UserModel? userModel,
  }) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      authStatus: authStatus ?? this.authStatus,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [errorMessage, authStatus, userModel];
}
