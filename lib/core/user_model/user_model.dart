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

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'password': password};
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  factory UserModel.fromAuthResponse(Map<String, dynamic> json, String email) {
    return UserModel(
      email: email,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, phone: $phone, password: $password}';
  }
}
