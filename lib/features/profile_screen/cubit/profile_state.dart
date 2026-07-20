part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final UserModel? userModel;
  final RequestStatus profileStatus;
  final String? errorMessage;
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  ProfileState({
    this.userModel,
    this.profileStatus = RequestStatus.loading,
    this.errorMessage,
    GlobalKey<FormState>? formKey,
    TextEditingController? userNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) : formKey = formKey ?? GlobalKey<FormState>(),
       userNameController = userNameController ?? TextEditingController(),
       emailController = emailController ?? TextEditingController(),
       phoneController = phoneController ?? TextEditingController();

  ProfileState copyWith({
    UserModel? userModel,
    RequestStatus? profileStatus,
    String? errorMessage,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      profileStatus: profileStatus ?? this.profileStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      formKey: this.formKey,
      userNameController: this.userNameController,
      emailController: this.emailController,
      phoneController: this.phoneController,
    );
  }

  @override
  List<Object?> get props => [
    userModel,
    profileStatus,
    errorMessage,
    formKey,
    userNameController.text,
    emailController.text,
    phoneController.text,
  ];
}
