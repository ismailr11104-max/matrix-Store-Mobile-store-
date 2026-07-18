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

  factory UserModel.fromProfile(Map<String, dynamic> map) {
    final userData = map['user'] as Map<String, dynamic>? ?? map;
    return UserModel(
      name: userData['name'] as String?,
      email: userData['email'] as String?,
      phone: userData['phone'] as String?,
      accessToken: map['accessToken'] as String?, // جلب التوكن الصحيح
      refreshToken: map['refreshToken'] as String?,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, phone: $phone, password: $password}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
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
    return UserModel(
      name: userData['name'] as String?,
      email: userData['email'] as String?,
      phone:
          userData['phone']
              as String?, // السيرفر في البوستمان لا يعيد الهاتف، سيصبح null تلقائياً
      password: password, // لتخزينه محلياً عند الحاجة
      accessToken: json['accessToken'] as String?, // جلب التوكن الصحيح
      refreshToken: json['refreshToken'] as String?,
    );
  }
}
