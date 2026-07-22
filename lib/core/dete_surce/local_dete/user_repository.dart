import 'package:hive_ce_flutter/adapters.dart';
import 'package:matrix_app/core/constants/constants.dart';
import 'package:matrix_app/core/user_model/user_model.dart';

class UserRepository {
  UserRepository._internal();

  static final _instance = UserRepository._internal();

  factory UserRepository() => _instance;
  Box<UserModel>? _userBox;

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception("UserRepository not initialized");
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    _userBox = await Hive.openBox(Constants.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(Constants.currentUser, user);
  }

  UserModel? getUser() => userBox.get(Constants.currentUser);

  Future<void> updateTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    final user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        accessToken: accessToken,
        refreshToken: refreshToken ?? user.refreshToken,
      );
      await saveUser(updatedUser);
    }
  }

  String? getAccessToken() {
    return getUser()?.accessToken;
  }

  String? getRefreshToken() {
    return getUser()?.refreshToken;
  }

  updateUser({
    String? name,
    String? imageUser,
    String? email,
    String? phone,
    String? password,
  }) async {
    final UserModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        imageUser: imageUser,
        email: email,
        phone: phone,
        password: password,
      );

      await saveUser(updatedUser);
    }
  }

  Future<void> delete() async {
    await userBox.delete(Constants.currentUser);
  }

  Future<void> clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final user = getUser();

    if (user == null) {
      return "No Account Found Please Register First";
    }

    if (user.email != email || user.password != password) {
      return "Incorrect Email or Password";
    }
    return null;
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final user = getUser();

    if (user != null && user.email == email) {
      return "User Already Exists Please Login";
    }

    final newUser = UserModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );

    await saveUser(newUser);
    return null;
  }
}
