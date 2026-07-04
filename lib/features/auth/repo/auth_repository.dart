import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/auth/auth_api_service.dart';
import 'package:matrix_app/core/user_model/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiService);
  ApiService apiService = ApiService();
  Future<UserModel?> sign_in({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiServesConfig.authLogin,
      body: {"email": email, "password": password},
    );
    UserModel model = UserModel.fromAuthResponse(response, email);
    await _saveUser(model);
    return model;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await apiService.post(
      ApiServesConfig.authRegister,
      body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      },
    );
  }

  Future _saveUser(UserModel model) async {
    await UserRepository().saveUser(model);
  }
}
