import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/core/user_model/user_model.dart';
import 'package:matrix_app/features/profile_screen/date/remut_date/user_api_serves.dart';

abstract class BaseUserRepository {
  Future<UserModel> getProfile();

  Future<UserModel> editProfile({
    required String name,
    required String email,
    required String phone,
  });
  Future<void> deleteProfile();
}

class ProfileRepository extends BaseUserRepository {
  final UserApiServes userApiServes;

  ProfileRepository(this.userApiServes);

  @override
  Future<UserModel> getProfile() async {
    try {
      final Map<String, dynamic> result = await userApiServes.getProfile(
        ApiServesConfig.authMy,
      );
      return UserModel.fromProfile(result);
    } catch (e) {
      throw Exception("Failed To Load User Data");
    }
  }

  @override
  Future<void> deleteProfile() async {
    try {
      await userApiServes.deleteProfile(ApiServesConfig.authMy);
      // حذف بيانات المستخدم محلياً بعد حذف الحساب من السيرفر
      await UserRepository().delete();
    } catch (e) {
      throw Exception("Failed To Delete User Account");
    }
  }

  @override
  Future<UserModel> editProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final Map<String, dynamic> result = await userApiServes.editProfile(
        ApiServesConfig.authMy,
        body: {"name": name, "email": email, "phone": phone},
      );

      final updatedUser = UserModel.fromProfile(result);

      // تحديث البيانات محلياً داخل قاعدة بيانات Hive لتنعكس في التطبيق
      await UserRepository().updateUser(
        name: updatedUser.name,
        email: updatedUser.email,
        phone: updatedUser.phone,
      );

      return updatedUser;
    } catch (e) {
      throw Exception("Failed To Update User Data");
    }
  }
}
