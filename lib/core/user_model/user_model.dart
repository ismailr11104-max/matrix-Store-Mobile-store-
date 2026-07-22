import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final String? accessToken;
  @HiveField(5)
  final String? refreshToken;
  @HiveField(6)
  final String? imageUser;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.accessToken,
    this.refreshToken,
    this.imageUser,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? accessToken,
    String? refreshToken,
    String? imageUser,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      imageUser: imageUser ?? this.imageUser,
    );
  }

  factory UserModel.fromProfile(
    Map<String, dynamic> json, {
    UserModel? existingUser,
  }) {
    return UserModel(
      name: json['name'] ?? existingUser?.name,
      email: json['email'] ?? existingUser?.email,
      phone: json['phone'] ?? existingUser?.phone,
      password: existingUser?.password,
      accessToken: json['accessToken'] ?? existingUser?.accessToken,
      refreshToken: json['refreshToken'] ?? existingUser?.refreshToken,

      imageUser: existingUser?.imageUser,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, phone: $phone, password: $password}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUser': imageUser,
      'email': email,
      'phone': phone,
      'password': password,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserModel.fromAuthResponse(
    Map<String, dynamic> json,
    String password,
  ) {
    final userData = json['user'] as Map<String, dynamic>? ?? json;
    final String? token =
        json['accessToken'] ??
        json['token'] ??
        userData['accessToken'] ??
        userData['token'];

    final String? refresh = json['refreshToken'] ?? userData['refreshToken'];

    return UserModel(
      name: userData['name'] as String?,
      email: userData['email'] as String?,
      phone: userData['phone'] as String?,
      password: password,
      accessToken: token,
      refreshToken: refresh,
      imageUser: userData['imageUser'] ?? userData['image'] as String?,
    );
  }
}
