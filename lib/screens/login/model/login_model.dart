class LoginModel {
  User user;
  String accessToken;
  String refreshToken;
  int expiresIn;

  LoginModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    expiresIn: json["expires_in"],
  );
}

class User {
  String email;
  String role;
  String id;
  String name;

  User({
    required this.email,
    required this.role,
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    role: json["role"],
    id: json["id"],
    name: json["name"],
  );
}

class RefreshTokenModel {
    String accessToken;
    String refreshToken;
    int expiresIn;

    RefreshTokenModel({
        required this.accessToken,
        required this.refreshToken,
        required this.expiresIn,
    });

    factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
    };
}
