part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String? errorMessage;
  final RequestStatus authStatus;
  final UserModel? userModel; // 🟢 الحقل المعتمد في الـ state

  const AuthState({
    this.errorMessage,
    this.authStatus = RequestStatus.initial,
    this.userModel,
  });

  AuthState copyWith({
    String? errorMessage,
    RequestStatus? authStatus,
    UserModel? userModel, // 🟢 تعديل الاسم ليتطابق
  }) {
    return AuthState(
      errorMessage:
          errorMessage ??
          this.errorMessage, // الاحتفاظ بالخطأ السابق إن لم يتغير
      authStatus: authStatus ?? this.authStatus,
      userModel:
          userModel ?? this.userModel, // 🟢 تمرير الـ model بشكل صحيح هنا!
    );
  }

  @override
  List<Object?> get props => [errorMessage, authStatus, userModel];
}
