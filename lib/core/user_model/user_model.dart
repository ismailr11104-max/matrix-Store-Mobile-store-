class UserModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.name,
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

  factory UserModel.fromAuthResponse(
    Map<String, dynamic> json,
    String username,
  ) {
    return UserModel(
      name: username,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, phone: $phone, password: $password}';
  }
}
